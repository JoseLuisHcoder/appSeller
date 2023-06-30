import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendedor/data/themes.dart';

class TimerVisit extends StatefulWidget {
  const TimerVisit({super.key});

  @override
  State<TimerVisit> createState() => _TimerVisitState();
}

class _TimerVisitState extends State<TimerVisit> {
  Timer? _timer;
  int _seconds = 0;
  bool isVisiting = false;

  void _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedTime = prefs.getInt('savedTimeFirst');
    if (savedTime != null) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      int difference = (currentTime - savedTime) ~/ 1000;
      setState(() {
        isVisiting = true;
        _seconds = difference;
      });
    } else {
      return null;
    }
    _startTimer();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedTime();
  }

  @override
  void dispose() {
    isVisiting = false;
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(TimerVisit oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadSavedTime();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return isVisiting == true
        ? Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                  color: kPrimary, borderRadius: BorderRadius.circular(5)),
              child: Text(
                _formatTime(_seconds),
                // _formatTime(widget.seconds),
                textAlign: TextAlign.center,
                style: TextStyle(color: kWhite, fontSize: 24),
              ),
            ),
          )
        : Container();
  }
}
