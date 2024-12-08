import 'package:flutter/material.dart';
import 'package:laboratorio/components/chat/copy.dart';
import 'package:laboratorio/components/chat/reproduceText.dart';

const _colorWhite = Color.fromRGBO(255, 252, 255, 1);
const _colorDark = Color.fromRGBO(80, 81, 79, 1);

class Message extends StatelessWidget {
  final String text;
  final bool isReponse;

  const Message({
    super.key,
    required this.isReponse,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isReponse ? const SizedBox(height: 16) : const SizedBox.shrink(),
        Container(
          alignment: isReponse ? Alignment.centerLeft : Alignment.centerRight,
          decoration: BoxDecoration(
            color: isReponse ? _colorWhite : _colorDark,
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
          child:Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isReponse ? _colorDark : _colorWhite,
            ),
          ),
        ),
        isReponse ?
          Row(
            children: [
              CopyButton(text: text),
              Reproducetext(text: text)
            ],
          )
          : const SizedBox.shrink(),
        isReponse ? const SizedBox(height: 16) : const SizedBox.shrink(),
      ],
    );
  }
}

