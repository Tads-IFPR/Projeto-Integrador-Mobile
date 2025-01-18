import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:laboratorio/dao/chat.dart';
import 'package:laboratorio/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:laboratorio/components/chat/message.dart';
import 'package:laboratorio/components/chat/textBar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
  final _controller = TextEditingController();
  List<Message> messages = [];

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _audioPath;
  final List<File> _images = [];
  bool _isRecording = false;

  void _sendMessage() async {
    final userInput = _controller.text;
    if (userInput.isEmpty) return;
    _controller.clear();

    await chatDAO.addMessage('User message', userInput, false);
    setState(() {
      messages.add(Message(isReponse: false, text: userInput));
    });

    final result = await openAIService.sendMessage(userInput);
    await chatDAO.addMessage(result?['title'] ?? 'Bot message', result?['message'] ?? 'Failed to get a response.', true);
    setState(() {
      messages.add(Message(isReponse: true, text: result?['message'] ?? 'Failed to get a response.'));
    });
  }

  _pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result == null) return null;

    for (final path in result.paths) {
      final file = File(path!);
      _images.add(file);
    }
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
      _audioPath = filePath;
      _isRecording = true;
    });
  }

  Future<void> _stopRecordingAndSend() async {
    await _recorder.stopRecorder();

    setState(() {
      _isRecording = false;
    });

    if (_audioPath != null) {
      final audioFile = File(_audioPath!);
      final resultAudio = await openAIService.transcribeAudio(audioFile);

      if (resultAudio == null) return;

      await chatDAO.addMessage('User message', resultAudio, false, file: audioFile);
      setState(() {
        messages.add(Message(isReponse: false, audio: audioFile));
      });

      final result = await openAIService.sendMessage(resultAudio);
      await chatDAO.addMessage(result?['title'] ?? 'Bot message', result?['message'] ?? 'Failed to get a response.', true);
      setState(() {
        messages.add(Message(isReponse: true, text: result?['message'] ?? 'Failed to get a response.'));
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
    setChatMessages();
  }

  setChatMessages() async {
    if (chatDAO.currentChat != null) {
      var tempMessages = chatDAO.chatMessages;
      List<Message> messagesFromChat = [];

      for (var message in tempMessages) {
        var files = await chatDAO.getFilesForMessage(message.id);
        if (files.isNotEmpty) {
          final audioFile = File(files.first.path);
          messagesFromChat.add(Message(isReponse: message.isBot, audio: audioFile));
          continue;
        }

        messagesFromChat.add(Message(isReponse: message.isBot, text: message.messageText));
      }

      setState(() {
        messages = messagesFromChat;
      });
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
              pickImages: _pickImages,
              isRecording: _isRecording,
            )
          ],
        ),
      ),
    );
  }
}