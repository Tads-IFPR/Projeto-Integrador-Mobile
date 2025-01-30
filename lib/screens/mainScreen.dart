import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:laboratorio/components/bottomNavigator.dart';
import 'package:laboratorio/screens/chat.dart';
import 'package:laboratorio/screens/history.dart';
import 'package:laboratorio/screens/profile.dart';
import 'package:laboratorio/screens/metrics.dart';
import 'package:laboratorio/screens/objectives.dart';

import '../dao/chat.dart';
import '../database/database.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  List<Widget> pages = [];



  get lastUserId => null;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    refreshPages();
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
  void refreshPages() {
    setState(() {
      pages = [
        const ChatScreen(),
        History(onChatTap: onChatTap, onDeleteChat: onDeleteChat),
        UserProfile(userId: lastUserId ?? 1),
        const DatabaseOverview(),
        const AddObjectiveScreen(),
      ];
    });
  }
  Future<int?> _fetchLastUserId() async {
    final lastUser = await (db.select(db.users)
      ..orderBy([(u) => OrderingTerm.desc(u.id)])
      ..limit(1))
        .getSingleOrNull();
    return lastUser?.id;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigator(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
