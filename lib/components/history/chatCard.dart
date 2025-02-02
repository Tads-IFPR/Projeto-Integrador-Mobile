import 'package:flutter/material.dart';
import 'package:JAJA/styles/default.dart';

class ChatCard extends StatelessWidget {
  final String text;
  final bool isFirst;

  const ChatCard({
    super.key,
    required this.text,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isFirst ? const SizedBox.shrink() : const SizedBox(height: 8),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: colorDark,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: colorWhite
            ),
          ) 
        ),
      ],
    );
  }
}