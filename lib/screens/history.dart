import 'package:flutter/material.dart';
import 'package:laboratorio/components/history/chatCard.dart';
import 'package:laboratorio/dao/chat.dart';

class History extends StatelessWidget {
  final Function onChatTap;

  const History({
    super.key,
    required this.onChatTap,
  });

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
              child: ChatCard(text: chatDAO.allChats[index].title, isFirst: index == 0),
            );
          },
        )
      ),
    );
  }
}