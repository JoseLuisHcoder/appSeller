import 'package:flutter/material.dart';

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
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
            width: 120,
            height: 32,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              width: 120,
              height: 32,
              decoration: BoxDecoration(
                  color: kPrimary, borderRadius: BorderRadius.circular(5)),
              child: Text(
                '0:00:00',
                // _formatTime(widget.seconds),
                textAlign: TextAlign.center,
                style: TextStyle(color: kWhite, fontSize: 24),
              ),
            ),
          )
        ],
        title: const Text('App Seller'),
      ),
      body: const Center(
        child: Text('Home page'),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}
