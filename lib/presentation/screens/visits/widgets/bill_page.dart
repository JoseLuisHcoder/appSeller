import 'package:flutter/material.dart';

class BillPage extends StatefulWidget {
  final String qrCode;
  BillPage({Key? key, required this.qrCode}) : super(key: key);

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.qrCode);
  }
}
