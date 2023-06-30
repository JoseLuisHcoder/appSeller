import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/cart_product.dart';
import 'package:vendedor/domain/models/response/product_promotions.dart';
import 'package:vendedor/domain/services/cart_services.dart';
import 'package:vendedor/domain/services/product_promotions_service.dart';
import 'package:vendedor/domain/services/visit_services.dart';
import 'package:vendedor/presentation/screens/home/home_page.dart';
import 'package:vendedor/presentation/screens/visits/widgets/card_product.dart';
import 'package:vendedor/presentation/screens/visits/widgets/card_product_promotions.dart';
import 'package:vendedor/presentation/screens/visits/widgets/timer.dart';
import 'package:vendedor/presentation/screens/visits/widgets/visits_customer_nfo.dart';

import '../../../../data/themes.dart';
// import '../../../../widgets/card_product.dart';
import '../../../../widgets/card_product_option2.dart';
import 'package:timer_builder/timer_builder.dart';
import 'dart:async';

class Cart extends StatefulWidget {
  final int customer;
  const Cart({super.key, required this.customer});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  ShoppingCart? cartProducts;
  List<ProductPromotions>? productsPro;
  bool timer_ = false;
  bool loading = true;

  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchPro();
    startVisit();
  }

  Future<void> fetchData() async {
    ShoppingCart? products =
        await cartServices.getCartByCustomer(widget.customer);
    setState(() {
      cartProducts = products;
      loading = false;
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
    prefs.remove("customerIdVisit");
  }

  Future<void> fetchPro() async {
    List<ProductPromotions>? apiProducts =
        await productPromotion.getProductsPromotions();
    if (apiProducts != null) {
      setState(() {
        productsPro = apiProducts;
      });
    }
  }

  void _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedTime = prefs.getInt('savedTimeFirst');
    if (savedTime != null) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      int difference = (currentTime - savedTime) ~/ 1000;
      setState(() {
        timer_ = true;
        _seconds = difference;
      });
    } else {
      await prefs.setInt(
          'savedTimeFirst', DateTime.now().millisecondsSinceEpoch);
      await prefs.setInt('customerIdVisit', widget.customer);
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

  Future<void> startVisit() async {
    final message = await visitServices.startVisit(widget.customer);
    if (message["code"] == 200) {
      print(message["code"]);
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message["message"]), backgroundColor: kGreen));*/
    } else {
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message["message"]), backgroundColor: kError));*/
      print(message["code"]);
      //Navigator.pop(context);
    }
    _loadSavedTime();
  }

  Future<void> finishVisit(context) async {
    final message = await visitServices.finishVisit(widget.customer);
    if (message["code"] == 200) {
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message["message"]), backgroundColor: kGreen));*/
      _timer?.cancel();
      remove();
    } else {
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message["message"]), backgroundColor: kError));*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kGrey800),
        actions: [TimerVisit()],
        backgroundColor: kWhite,
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: ListView(
            children: [
              if (loading == true)
                Center(child: CircularProgressIndicator())
              else if (loading == false && cartProducts == null)
                Text('No hay productos en el carrito')
              else
                Container(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartProducts?.shoppingCartItems.length,
                      itemBuilder: (context, index) {
                        CartProduct? product =
                            cartProducts?.shoppingCartItems[index];
                        return CardProduct(product: product);
                      }),
                ),
              const SizedBox(height: 10),
              _buttonTotal(context),
              const SizedBox(
                height: 10,
              ),
              if (productsPro != null)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productsPro!.length,
                    itemBuilder: (context, index) {
                      ProductPromotions product = productsPro![index];
                      // Renderizar cada producto de la API aquí
                      return CardProductPromotions(product: product);
                    }),
              // CardProductOption2(),
              _finishVisit(context)
            ],
          )),
    );
  }

  SizedBox _buttonTotal(BuildContext context) {
    String calculateTotalPrice() {
      double totalPrice = 0;
      if (cartProducts != null) {
        for (CartProduct cartProduct in cartProducts!.shoppingCartItems) {
          totalPrice += cartProduct.promotionalTotalPrice;
        }
      }
      return 'S/${totalPrice.toStringAsFixed(2)}';
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 63,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kGrey600,
        ),
        child: Text(
          calculateTotalPrice(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: kWhite,
          ),
        ),
      ),
    );
  }

  SizedBox _finishVisit(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 63,
      child: ElevatedButton(
        onPressed: () {
          finishVisit(context);
          Navigator.of(context).pop();
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
