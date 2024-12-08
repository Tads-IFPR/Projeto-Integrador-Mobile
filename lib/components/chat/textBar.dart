import 'package:flutter/material.dart';

const _colorWhite = Color.fromRGBO(255, 252, 255, 1);
const _colorDark = Color.fromRGBO(80, 81, 79, 1);

class TextBar extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSend;

  const TextBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _colorWhite,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: _colorDark,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          top: 2,
          bottom: 2,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => {
                print('Sending file')
              },
              icon: const Icon(Icons.attach_file),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () => {
                print('Listening audio')
              },
              icon: const Icon(Icons.mic),
            ),
            IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send),
            ),
          ],
        ), 
      )
    );
  }
}