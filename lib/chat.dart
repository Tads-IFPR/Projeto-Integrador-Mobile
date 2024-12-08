import 'package:flutter/material.dart';
import 'package:laboratorio/components/chat/message.dart';
import 'package:laboratorio/components/chat/textBar.dart';

const loremIpsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet suscipit ligula, nec elementum lorem. Phasellus volutpat sollicitudin lacus, quis pulvinar lectus aliquet nec. Nam vulputate nulla quis imperdiet vulputate. Aenean consequat, risus sed pellentesque convallis, urna ipsum tincidunt nisi, sit amet sagittis magna justo in purus. Aliquam efficitur, nunc eget interdum tincidunt, justo erat fermentum felis, eget consequat orci nulla mattis purus. Cras mollis pellentesque vulputate. Etiam a ligula a turpis placerat pharetra suscipit vel quam. Duis volutpat ultrices libero. Nunc congue nisi id quam vehicula eleifend at ut est. Pellentesque laoreet justo vitae mi rhoncus, id eleifend ante consequat.';
const _colorPrimary = Color.fromRGBO(36, 123, 160, 1);
const _colorWhite = Color.fromRGBO(255, 252, 255, 1);
const _colorDark = Color.fromRGBO(80, 81, 79, 1);

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(direction: Axis.vertical, children: [
              Message(isReponse: false, text: loremIpsum),
              Message(isReponse: true, text: loremIpsum),
            ]),
            TextBar()
          ],
        ),
      ),
    );
  }
}