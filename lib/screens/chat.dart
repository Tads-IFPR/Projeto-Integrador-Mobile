import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:laboratorio/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:laboratorio/components/chat/message.dart';
import 'package:laboratorio/components/chat/textBar.dart';

class Chat extends StatefulWidget {
  final ChatModel? chat;
  const Chat({
    super.key,
    required this.chat,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _controller = TextEditingController();
  List<Message> messages = [];

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _filePath;
  bool _isRecording = false;

  void _sendMessage() async {
    final userInput = _controller.text;
    if (userInput.isEmpty) return;
    _controller.clear();

    currentChat?.messages.add(MessageModel(isReponse: false, text: userInput));
    setState(() {
      messages.add(Message(isReponse: false, text: userInput));
    });

    final result = await openAIService.sendMessage(userInput);
    currentChat?.messages.add(MessageModel(isReponse: true, text: result ?? 'Failed to get a response.'));
    setState(() {
      messages.add(Message(isReponse: true, text: result ?? 'Failed to get a response.'));
    });
  }

  Future<void> _startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'audio-${DateTime.now().millisecondsSinceEpoch}.m4a';
    final filePath = '${directory.path}/$fileName';

    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacMP4,
    );

    setState(() {
      _filePath = filePath;
      _isRecording = true;
    });
  }

  Future<void> _stopRecordingAndSend() async {
    await _recorder.stopRecorder();

    setState(() {
      _isRecording = false;
    });

    if (_filePath != null) {
      final audioFile = File(_filePath!);
      final resultAudio = await openAIService.transcribeAudio(audioFile);

      if (resultAudio == null) return;

      currentChat?.messages.add(MessageModel(isReponse: false, audio: audioFile));
      setState(() {
        messages.add(Message(isReponse: false, audio: audioFile));
      });

      final result = await openAIService.sendMessage(resultAudio);

      currentChat?.messages.add(MessageModel(isReponse: true, text: result ?? 'Failed to get a response.'));
      setState(() {
        messages.add(Message(isReponse: true, text: result ?? 'Failed to get a response.'));
      });
    }
  }


  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _recorder.openRecorder();
  }

  @override
  void initState() {
    super.initState();
    _initializeRecorder();

    if (widget.chat != null && widget.chat?.messages.isNotEmpty == true) {
      List<Message> messagesFromChat = [];

      for (var message in widget.chat?.messages ?? []) {
        if (message.text != null) {
          messagesFromChat.add(Message(isReponse: message.isReponse, text: message.text));
        } else if (message.audio != null) {
          messagesFromChat.add(Message(isReponse: message.isReponse, audio: message.audio));
        }
      }

      setState(() {
        messages = messagesFromChat;
      });
    } else {
      currentChat = ChatModel(messages: []);
      chats.add(currentChat!);
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
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