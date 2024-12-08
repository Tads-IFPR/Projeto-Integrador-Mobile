import 'package:flutter/material.dart';
import 'package:laboratorio/chat.dart';

const _colorWhite = Color.fromRGBO(255, 252, 255, 1);
const _colorPrimary = Color.fromRGBO(36, 123, 160, 1);
const _colorDark = Color.fromRGBO(80, 81, 79, 1);

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      backgroundColor: _colorWhite,
      selectedItemColor: _colorDark,
      currentIndex: _selectedIndex,
      selectedIconTheme: const IconThemeData(color: _colorPrimary),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Chat()),
        );
        break; 
      default:
    }
  }
}