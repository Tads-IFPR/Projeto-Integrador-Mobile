import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laboratorio/screens/chat.dart';
import 'package:laboratorio/components/bottomNavigator.dart';
import 'package:laboratorio/components/chat/message.dart';
import 'package:laboratorio/screens/history.dart';
import 'package:laboratorio/services/openAIService.dart';

void main() {
  runApp(const App());
}

final openAIService = OpenAIService('key-here');

//this should be refactored
class MessageModel {
  final String? text;
  final bool isReponse;
  final File? audio;

  MessageModel({
    required this.isReponse,
    this.text,
    this.audio,
  });
}

class ChatModel {
  List<MessageModel> messages = [];
  ChatModel({
    required this.messages,
  });
}

ChatModel? currentChat;

List<ChatModel> chats = [];

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      Chat(chat: currentChat),
      History(onChatTap: onChatTap),
      const Text('Profile'),
    ];
  }

  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onChatTap(int index) {
    setState(() {
      pages[0] = Chat(chat: chats[index]);
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigator(
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
      )
    );
  }
}