import 'package:flutter/material.dart';

const _colorWhite = Color.fromRGBO(255, 252, 255, 1);
const _colorPrimary = Color.fromRGBO(36, 123, 160, 1);
const _colorDark = Color.fromRGBO(80, 81, 79, 1);

class BottomNavigator extends StatefulWidget {
  final ValueChanged<int>? onItemTapped;
  final int selectedIndex;

  BottomNavigator({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });

  @override
  State<BottomNavigator> createState() => BottomNavigatorState();
}

class BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.onItemTapped,
      backgroundColor: _colorWhite,
      selectedItemColor: _colorDark,
      currentIndex: widget.selectedIndex,
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
}