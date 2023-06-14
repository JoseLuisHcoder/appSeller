import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendedor/presentation/screens/visits/widgets/timer.dart';

import '../../../data/themes.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
  const HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TimerVisit()],
        title: const Text('App Seller'),
      ),
      body: const Center(
        child: Text('Home page'),
      ),
    );
  }
}
