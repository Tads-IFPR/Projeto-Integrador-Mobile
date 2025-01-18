import 'dart:io';
import 'package:flutter/material.dart';
import 'package:laboratorio/components/chat/filePreview/TextFilePreview.dart';
import 'package:laboratorio/components/chat/filePreview/imagePreview.dart';
import 'package:laboratorio/components/chat/filePreview/unsupportedFilePreview.dart';
import 'package:laboratorio/styles/default.dart';

class FilePreview extends StatelessWidget {
  final File file;
  final Function() onRemove;

  const FilePreview({
    super.key,
    required this.file,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final fileExtension = file.path.split('.').last.toLowerCase();
    Widget preview = UnsupportedFilePreview();
    
    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
      preview = ImagePreview(file: file);
    }
    
    if (['txt', 'md', 'log', 'json', 'csv'].contains(fileExtension)) {
      preview = TextFilePreview(file: file);
    }

    return SizedBox(
      height: 120,
      width: 80,
      child: Stack(
        children: [
          Positioned.fill(
            child: preview
          ),
          Positioned(
            top: -5,
            left: -5,
            child: IconButton(
              onPressed: onRemove,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(colorWhite),
              ),
              iconSize: 20,
              icon: const Icon(Icons.close, color: Colors.red),
              tooltip: "Remove file",
            ),
          ),
        ],
      ),
    );
  }
}
