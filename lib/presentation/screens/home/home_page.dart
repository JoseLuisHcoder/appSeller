import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/themes.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
  const HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
              width: 120,
              height: 32,
              child: isVisiting == true
                  ? Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: 120,
                      height: 32,
                      decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        _formatTime(_seconds),
                        // _formatTime(widget.seconds),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kWhite, fontSize: 24),
                      ),
                    )
                  : Container(),
            )
          ],
          title: const Text('Inicio - Dashboard',
              style: TextStyle(fontSize: 16, color: kWhite)),
        ),
        body: Column(children: [
          _textPromotions(),
          Flexible(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  // width: 300,
                  height: 250,
                  child: Image.asset('images/antiguedadDeDeudaS.jpg'),
                ),
                Container(
                  // width: 300,
                  height: 250,
                  child: Image.asset('images/deudaVencidaPorVencerS.jpg'),
                ),
                Container(
                  // width: 300,
                  height: 250,
                  child: Image.asset('images/misDeudasPorVencerS.jpg'),
                ),
                Container(
                  // width: 300,
                  height: 250,
                  child: Image.asset('images/promDiasMorosidadS.jpg'),
                ),
              ],
            )),
          ),
        ]));
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  Container _textPromotions() {
    return Container(
      color: kGrey200,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Mantente bien informado sobre promociones y tus pedidos',
              style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
