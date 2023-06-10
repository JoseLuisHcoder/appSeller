import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/cart_product.dart';
import 'package:vendedor/domain/services/cart_services.dart';
import 'package:vendedor/presentation/screens/home/home_page.dart';
import 'package:vendedor/presentation/screens/visits/widgets/card_product.dart';

import '../../../../data/themes.dart';
// import '../../../../widgets/card_product.dart';
import '../../../../widgets/card_product_option2.dart';
import 'package:timer_builder/timer_builder.dart';
import 'dart:async';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartProduct>? cartProducts;

  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    _loadSavedTime();
  }

  Future<void> fetchData() async {
    String? token = await secureStorage.readToken();
    int customerId = int.parse(token!); // Realiza la conversión a entero

    List<CartProduct>? products =
        await cartServices.getCartByCustomer(customerId);
    setState(() {
      cartProducts = products;
    });
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
        iconTheme: IconThemeData(color: kGrey800),
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
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: ListView(
            children: [
              if (cartProducts == null)
                CircularProgressIndicator()
              else if (cartProducts!.isEmpty)
                Text('No hay productos en el carrito')
              else
                Container(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartProducts!.length,
                      itemBuilder: (context, index) {
                        CartProduct product = cartProducts![index];
                        return CardProduct(product: product);
                      }),
                ),
              const SizedBox(height: 10),
              _buttonTotal(context),
              const SizedBox(
                height: 10,
              ),
              CardProductOption2(),
              _finishVisit(context)
            ],
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

  SizedBox _finishVisit(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 63,
      child: ElevatedButton(
        onPressed: () {
          remove();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
        ),
        child: const Text('Finalizar Visita',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: kWhite)),
      ),
    );
  }
}
