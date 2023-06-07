import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/themes.dart';
import '../../../../widgets/card_product.dart';
import '../../../../widgets/card_product_option2.dart';
import 'package:timer_builder/timer_builder.dart';
import 'dart:async';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("savedTimeFirst");
  }

  void _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedTime = prefs.getInt('savedTimeFirst');
    if (savedTime != null) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      int difference = (currentTime - savedTime) ~/ 1000;
      setState(() {
        _seconds = difference;
      });
    } else {
      await prefs.setInt(
          'savedTimeFirst', DateTime.now().millisecondsSinceEpoch);
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

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
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
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              width: 120,
              height: 32,
              decoration: BoxDecoration(
                  color: kPrimary, borderRadius: BorderRadius.circular(5)),
              child: Text(
                _formatTime(_seconds),
                textAlign: TextAlign.center,
                style: TextStyle(color: kWhite, fontSize: 24),
              ),
            ),
          )
        ],
        backgroundColor: kWhite,
        elevation: 0,
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const CardProduct(),
                const CardProduct(),
                const SizedBox(height: 10),
                _buttonTotal(context),
                const SizedBox(
                  height: 10,
                ),
                CardProductOption2(),
              ],
            ),
          )),
    );
  }

  SizedBox _buttonTotal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 63,
      child: ElevatedButton(
        onPressed: () {
          remove();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kGrey600,
        ),
        child: const Text('S/1800',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: kWhite)),
      ),
    );
  }
}
