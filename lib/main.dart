import 'package:flutter/material.dart';
import 'package:laboratorio/chat.dart';
import 'package:laboratorio/components/bottomNavigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Chat(),
        bottomNavigationBar: BottomNavigator(),
      )
    );
  }
}