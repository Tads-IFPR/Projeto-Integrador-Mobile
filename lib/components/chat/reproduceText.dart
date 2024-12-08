import 'package:flutter/material.dart';

class Reproducetext extends StatelessWidget {
  final String text;

  const Reproducetext({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => {
        print('Playing: $text')	
      }, 
      icon: const Icon(Icons.graphic_eq)
    );
  }
}