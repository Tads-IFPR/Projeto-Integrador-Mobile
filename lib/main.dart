import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:JAJA/controllers/chatController.dart';
import 'package:JAJA/dao/chat.dart';
import 'package:JAJA/database/database.dart';
import 'package:JAJA/screens/chat.dart';
import 'package:JAJA/components/bottomNavigator.dart';
import 'package:JAJA/screens/history.dart';
import 'package:JAJA/services/geminiService.dart';
import 'package:JAJA/screens/profile.dart';
import 'package:JAJA/services/openAIService.dart';
import 'package:JAJA/screens/configuration.dart';
import 'package:JAJA/screens/metrics.dart';
import 'package:JAJA/styles/default.dart';

void main() {
  runApp(const App());
}

final openAIService = OpenAIService('your-token-here');
final geminiService = Geminiservice('your-token-here');
final chatController = ChatController(geminiService, openAIService);

class App extends StatefulWidget {

  final int initialIndex;
  const App({super.key, this.initialIndex = 0});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Widget> pages = [];
  var _selectedIndex = 0;

  bool? get isSaveChats => null;

  int? get photoId => null;


  get userId => 1;

  @override
  void initState() {
    super.initState();
    _checkInitialScreen();
  }

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

  void onDeleteChat(int index) async {
    chatDAO.deleteChat(chatDAO.allChats[index].id);

    setState(() {
      refreshPages();
      _selectedIndex = 0;
    });
  }

  Future<void> saveUser(String name, String email) async {
    final user = UsersCompanion(
      name: Value(name),
      email: Value(email),
      isSaveChats: Value(isSaveChats!),
      photoId: Value(photoId),
    );

    await db.createRecord(db.users, user);
  }

  void refreshPages() {
    setState(() {
      pages = [
        const ChatScreen(),
        History(onChatTap: onChatTap, onDeleteChat: onDeleteChat),
        UserProfile(userId: userId),
        const DatabaseOverview(),
      ];
    });
  }

  Future<void> _checkInitialScreen() async {
    final users = await db.getAllRecords(db.users);
    if (users.isEmpty) {
      setState(() {
        pages = [
          const Configuration()
        ];
      });
    } else {
      refreshPages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Main Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: pages.asMap().containsKey(_selectedIndex) 
          ? pages[_selectedIndex]
          : const Center(child: CircularProgressIndicator(color: colorPrimary)),
        bottomNavigationBar: pages.length > 1 ? BottomNavigator(
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ) : null,
      )
    );
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }
}