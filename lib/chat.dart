import 'dart:io';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import 'package:laboratorio/components/chat/message.dart';
import 'package:laboratorio/components/chat/textBar.dart';
import 'package:laboratorio/services/openAIService.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _openAIService = OpenAIService('key-here');
  final _controller = TextEditingController();
  List<Message> messages = [];

  final _record = Record();
  String? _audioFilePath;
  bool _isRecording = false;

  void _sendMessage() async {
    final userInput = _controller.text;
    if (userInput.isEmpty) return;
    _controller.clear();

    setState(() {
      messages.add(Message(isReponse: false, text: userInput));
    });

    final result = await _openAIService.sendMessage(userInput);
    setState(() {
      messages.add(Message(isReponse: true, text: result ?? 'Failed to get a response.'));
    });
  }

  Future<void> _startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    _audioFilePath = '${directory.path}/recording.m4a';

    if (await _record.hasPermission()) {
      await _record.start(path: _audioFilePath);
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecordingAndSend() async {
    if (await _record.isRecording()) {
      await _record.stop();

      setState(() {
        _isRecording = false;
      });

      if (_audioFilePath != null) {
        final audioFile = File(_audioFilePath!);
        final resultAudio = await _openAIService.transcribeAudio(audioFile);

        if (resultAudio == null) {
          return;
        }

        setState(() {
          messages.add(Message(isReponse: false, text: resultAudio));
        });

        final result = await _openAIService.sendMessage(resultAudio);
        setState(() {
          messages.add(Message(isReponse: true, text: result ?? 'Failed to get a response.'));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: messages
            ),
            TextBar(
              controller: _controller,
              onSendMessage: _sendMessage,
              startRecording: _startRecording,
              stopRecording: _stopRecordingAndSend,
              isRecording: _isRecording,
            )
          ],
        ),
      ),
    );
  }
}