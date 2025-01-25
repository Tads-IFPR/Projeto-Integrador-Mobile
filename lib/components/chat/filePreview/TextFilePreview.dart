import 'dart:io';
import 'package:flutter/material.dart';

class TextFilePreview extends StatelessWidget {
  final File file;

  const TextFilePreview({super.key, required this.file});

  Future<String> _readFileContent() async {
    try {
      return await file.readAsString();
    } catch (e) {
      return 'Could not read file content';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _readFileContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error reading file: ${snapshot.error}'));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              snapshot.data ?? 'No content available',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          );
        }
      },
    );
  }
}