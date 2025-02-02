import 'package:flutter/material.dart';
import 'package:JAJA/styles/default.dart';

class CardSuggestion extends StatelessWidget {
  final String? text;
  final String? title;
  final Color? color;
  final Color? lightColor;

  const CardSuggestion({
    super.key,
    required this.title,
    required this.text,
    required this.color,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: color ?? colorDark, width: 2),
      ),
      color: lightColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              text ?? "",
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}