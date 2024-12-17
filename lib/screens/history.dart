import 'package:flutter/material.dart';
import 'package:laboratorio/main.dart';

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
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return GestureDetector(
            onTap: () => onChatTap(index),
            child: Text(chat.messages[chat.messages.length - 1].text?? (
                chat.messages[chat.messages.length - 1].audio != null
                ? 'Audio'
                : ''
              )
            )
          );
        },
      ),
    );
  }
}