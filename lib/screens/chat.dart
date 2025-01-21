import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:laboratorio/components/chat/filePreview/filePreview.dart';
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

  final ScrollController _scrollController = ScrollController();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _audioPath;
  final List<File> _images = [];
  bool _isRecording = false;
  bool _isLoading = false;

  toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  } 

  void _sendMessage() async {
    final userInput = _controller.text;
    if (userInput.isEmpty) return;
    toggleLoading();
    _controller.clear();
    clearFiles();

    final result = await openAIService.sendMessage(userInput, files: _images);

    await chatDAO.addMessage(result?['title'] ?? 'User message', userInput, false, false, categories: result?['categories'] ?? [], files: _images);
    setState(() {
      messages.add(Message(isReponse: false, text: userInput));
    });

    await chatDAO.addMessage(result?['title'] ?? 'Bot message', result?['message'] ?? 'Failed to get a response.', true, false);
    setState(() {
      messages.add(Message(isReponse: true, text: result?['message'] ?? 'Failed to get a response.'));
    });

    toggleLoading();
  }

  clearFiles() {
    setState(() {
      _images.clear();
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
      setState(() {
        _images.add(file);
      });
    }
  }

  _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
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
      toggleLoading();
      final audioFile = File(_audioPath!);
      final resultAudio = await openAIService.transcribeAudio(audioFile);

      if (resultAudio == null) return;

      await chatDAO.addMessage('User message', resultAudio, false, true, audio: audioFile);
      setState(() {
        messages.add(Message(isReponse: false, audio: audioFile));
      });

      final result = await openAIService.sendMessage(resultAudio);
      await chatDAO.addMessage(result?['title'] ?? 'Bot message', result?['message'] ?? 'Failed to get a response.', true, false, categories: result?['categories'] ?? []);
      setState(() {
        messages.add(Message(isReponse: true, text: result?['message'] ?? 'Failed to get a response.'));
      });

      toggleLoading();
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
        if (files.isNotEmpty && message.isAudio) {
          final audioFile = File(files.first.path);
          messagesFromChat.add(Message(isReponse: message.isBot, audio: audioFile));
          continue;
        } else if (files.isNotEmpty && !message.isAudio) {
          List<File> listFiles = [];
          for (var file in files) {
            listFiles.add(File(file.path));
          }
          messagesFromChat.add(Message(isReponse: message.isBot, files: listFiles));
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
      body: SafeArea(
        child: Column(
          children: [
            // Expanded widget for the messages
            Expanded(
              child: _isLoading ? const Center(
                  child: CircularProgressIndicator(), // The loading indicator
                ) : ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  reverse: false,
                  itemBuilder: (context, index) {
                    return messages[index];
                  },
                ),
            ),
            // Text bar and attachments
            Column(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 16,
                    end: 16,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      for (final image in _images) ...[
                        FilePreview(
                          file: image,
                          showRemoveButton: true,
                          onRemove: () => _removeImage(_images.indexOf(image)),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 16,
                    end: 16,
                    top: 8,
                    bottom: 8,
                  ),
                  child: TextBar(
                    controller: _controller,
                    onSendMessage: _sendMessage,
                    startRecording: _startRecording,
                    stopRecording: _stopRecordingAndSend,
                    pickImages: _pickImages,
                    isRecording: _isRecording,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}