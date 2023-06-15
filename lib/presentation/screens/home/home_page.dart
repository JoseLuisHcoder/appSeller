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
          backgroundColor: kAppBar,
          actions: [TimerVisit()],
          title: const Text('Inicio - Dashboard',
              style: TextStyle(fontSize: 18, color: kWhite)),
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
          Expanded(
            child: Text('Revisa los datos de los usuarios',
                maxLines: 2, style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
