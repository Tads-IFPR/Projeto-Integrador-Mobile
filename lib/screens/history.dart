import 'package:flutter/material.dart';
import 'package:laboratorio/components/history/chatCard.dart';
import 'package:laboratorio/dao/chat.dart';

class History extends StatelessWidget {
  final Function onChatTap;
  final Function onDeleteChat;

  const History({
    super.key,
    required this.onChatTap,
    required this.onDeleteChat,
  });

  _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this chat? This action cannot be undone.'),
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
                onDeleteChat(index);
              },
              child: const Text('Delete', style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: chatDAO.allChats.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onChatTap(index),
              onLongPress: () => _showDeleteConfirmationDialog(context, index),
              child: ChatCard(text: chatDAO.allChats[index].title, isFirst: index == 0),
            );
          },
        )
      ),
    );
  }
}