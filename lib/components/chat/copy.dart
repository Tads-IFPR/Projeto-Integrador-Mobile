import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final String text;

  const CopyButton({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => {
        Clipboard.setData(ClipboardData(text: text))
      }, 
      icon: const Icon(Icons.copy)
    );
  }
}