import 'package:flutter/material.dart';

class UnsupportedFilePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Preview not available for this file type.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}