import 'package:flutter/material.dart';
import 'package:laboratorio/chat.dart';
import 'package:laboratorio/components/bottomNavigator.dart';
import 'package:laboratorio/services/openAIService.dart';

void main() {
  runApp(const App());
}

final openAIService = OpenAIService('key-here');

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final pages = [
    const Chat(),
    const Text('History'),
    const Text('Profile'),
  ];

  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigator(
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
      )
    );
  }
}