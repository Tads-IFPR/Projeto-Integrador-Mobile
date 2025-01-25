import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final File file;

  const ImagePreview({
    super.key,
    required this.file
  });

   void _showImageInModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(file),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _showImageInModal(context),
        child: Image.file(
          file,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Text('Could not load image'),
          ),
        )
    );
  }
}