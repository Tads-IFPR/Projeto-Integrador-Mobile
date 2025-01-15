import 'package:flutter/material.dart';
import 'package:laboratorio/dao/chat.dart';
import 'package:laboratorio/database/database.dart';
import 'package:laboratorio/screens/chat.dart';
import 'package:laboratorio/components/bottomNavigator.dart';
import 'package:laboratorio/screens/history.dart';
import 'package:laboratorio/services/openAIService.dart';

void main() {
  runApp(const App());
}

final openAIService = OpenAIService('your-token-here');

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
      const ChatScreen(),
      History(onChatTap: onChatTap),
      const Text('Profile'),
    ];
  }

  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      chatDAO.setChat(null);
    }

    setState(() {
      refreshPages();
      _selectedIndex = index;
    });
  }

  void onChatTap(int index) async {
    chatDAO.setChat(chatDAO.allChats[index]);

    setState(() {
      refreshPages();
      _selectedIndex = 0;
    });
  }

  void refreshPages() {
    setState(() {
      pages[0] = const ChatScreen();
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

  @override
  void dispose() {
    db.close();
    super.dispose();
  }
}