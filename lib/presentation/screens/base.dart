import 'package:flutter/material.dart';
import 'package:vendedor/data/themes.dart';
import 'package:vendedor/presentation/screens/development/development_page.dart';
import 'package:vendedor/presentation/screens/live/paymets_page.dart';

import 'package:vendedor/presentation/screens/visits/visits_page.dart';

import 'home/home_page.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  BaseState createState() => BaseState();
}

class BaseState extends State {
  final List _pages = [
    const HomePage(),
    VisitsPage(),
    const LivePage(),
    const DevelopmentPage()
  ];
  int _selectedTab = 0;

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: bottomNavigationBarSelected,
          unselectedItemColor: kAppBar,
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          items: const [
            BottomNavigationBarItem(
                backgroundColor: itemBottomNavigationBarBackground,
                label: 'Inicio',
                icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                backgroundColor: itemBottomNavigationBarBackground,
                label: 'Plan de visitas',
                icon: Icon(Icons.wb_sunny_outlined)),
            BottomNavigationBarItem(
                backgroundColor: itemBottomNavigationBarBackground,
                label: 'En vivo',
                icon: Icon(Icons.attach_money)),
            BottomNavigationBarItem(
                backgroundColor: itemBottomNavigationBarBackground,
                label: 'Desarrollo',
                icon: Icon(Icons.more_horiz))
          ]),
      body: _pages[_selectedTab],
    );
  }
}
