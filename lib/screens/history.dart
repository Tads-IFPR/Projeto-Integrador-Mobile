import 'package:flutter/material.dart';
import 'package:laboratorio/components/history/chatCard.dart';
import 'package:laboratorio/components/history/filter.dart';
import 'package:laboratorio/dao/chat.dart';
import 'package:laboratorio/database/database.dart';

class History extends StatefulWidget {
  final Function onChatTap;
  final Function onDeleteChat;

  const History({
    super.key,
    required this.onChatTap,
    required this.onDeleteChat,
  });

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Chat> chats = [];
  List<String> filters = ['CSS', 'JS', 'HTML'];
  List<String> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    getAllChats();
  }

  getAllChats() async {
    await chatDAO.getAllChats();
    setState(() {
      chats = chatDAO.allChats;
    });
  }

  _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text(
              'Are you sure you want to delete this chat? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                widget.onDeleteChat(index);
              },
              child: const Text('Delete',
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  filterChats() {
    if (selectedFilters.isEmpty) {
      return;
    }

    setState(() {
      // chats = chatDAO.allChats.where((chat) {
      //   return selectedFilters.contains(chat.language);
      // }).toList();
    });
  }

  _onChangeFilter(String filter) {
    setState(() {
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
      } else {
        selectedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Column(
        children: [
          Filter(filters: filters, selectedFilters: selectedFilters, onChangeFilter: _onChangeFilter),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => widget.onChatTap(index),
                  onLongPress: () =>
                      _showDeleteConfirmationDialog(context, index),
                  child: ChatCard(
                    text: chats[index].title,
                    isFirst: index == 0,
                  ),
                );
              },
            ),
          ),
        ]
      )
    );
  }
}
