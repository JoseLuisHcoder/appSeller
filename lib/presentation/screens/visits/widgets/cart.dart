import 'package:flutter/material.dart';

import '../../../../data/themes.dart';
import '../../../../widgets/card_product.dart';
import '../../../../widgets/card_product_option2.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
                '00:03:56',
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
        onPressed: () {},
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
