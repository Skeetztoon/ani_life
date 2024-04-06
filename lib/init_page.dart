import 'package:ani_life/features/map/presentation/map_screen.dart';
import 'package:ani_life/features/profile/presentation/profile_screen.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _currentIndex = 0;
  final tabs = [
    const MapScreen(),
    const ProfileScreen(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: aniColorDark,
        unselectedItemColor: aniColorLight,
        onTap: _navigateBottomBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Events",
            icon: Icon(
              Icons.map_outlined,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.person_outline,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
