import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laboratorio/components/chat/player.dart';
import 'package:laboratorio/styles/default.dart';

class CardSuggestion extends StatelessWidget {
  final String? text;
  final String? title;

  const CardSuggestion({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        text ?? "",
        style: const TextStyle(
          fontSize: 14,
          color: colorWhite,
        ),
      )
    );
  }
}