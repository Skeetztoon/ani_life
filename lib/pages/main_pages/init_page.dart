import 'package:ani_life/pages/main_pages/profile_page.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

import 'map_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  int _currentIndex = 0;
  final tabs = [
    const MapPage(),
    const ProfilePage(),
  ];

  void _navigateBottomBar (int index) {
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
        selectedItemColor: AniColorDark,
        unselectedItemColor: AniColorLight,
        onTap: _navigateBottomBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: "Events",
            icon: Icon(Icons.map_outlined, size: 30,),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.star_border),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.message_outlined),
          // ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.person_outline, size: 30,),
          ),
        ],
      ),
    );
  }
}
