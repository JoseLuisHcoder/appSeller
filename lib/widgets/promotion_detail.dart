import 'package:vendedor/data/utils.dart';
import 'package:vendedor/domain/blocs/blocs.dart';
import 'package:vendedor/domain/models/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/themes.dart';
import '../../domain/models/response/product_promotions.dart';
import 'add_minus_button.dart';

class PromotionDetail extends StatefulWidget {
  final ProductPromotions product;
  const PromotionDetail({super.key, required this.product});

  @override
  State<PromotionDetail> createState() => _PromotionDetailState();
}

class _PromotionDetailState extends State<PromotionDetail> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Detalles de la promoción',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          iconTheme: const IconThemeData(color: kTextColor),
          backgroundColor: kWhite),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: kGrey200,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: defaultImage,
                            image: widget.product.productImage[0].urlPath,
                            fit: BoxFit.contain,
                            width: 120,
                          ),
                        ],
                      ),
                      _descriptionProduct()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                _countItems(),
                const SizedBox(
                  height: 10,
                ),
                _productPromotions(),
                _addButton(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('\u{1f525}'),
                      Text(
                        ' Estás ahorrando S/20.00',
                        style: TextStyle(fontSize: 12, color: kSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _addButton() {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'S/${widget.product.productPrice.price}',
                    style: TextStyle(
                        fontSize: 20,
                        color: kSecondary,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "S/ 870.00",
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: kGrey500),
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                // productBloc
                //     .add(OnAddProductToCartEvent(widget.product, quantity));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Agregado al carrito"),
                    backgroundColor: kSuccess));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: btnBgPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.shopping_cart_checkout_outlined,
                        color: btnPrimary,
                        size: 17,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Agregar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: btnPrimary),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Container _productPromotions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: kSecondary,
      child: const Column(
        children: [
          Row(
            children: [
              //Image.asset(
              //  'assets/box.png',
              //  width: 25,
              //  height: 25,
              //),
              SizedBox(
                width: 10,
              ),
              Text(
                '8 Baldes de Rimula X3',
                style: TextStyle(color: kWhite),
              ),
            ],
          ),
          Row(
            children: [
              //Image.asset(
              //  'assets/box.png',
              //  width: 25,
              //  height: 25,
              //),
              SizedBox(
                width: 10,
              ),
              Text(
                '2 Botellas de HELIX del mismo producto',
                style: TextStyle(color: kWhite),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _countItems() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          const Text(
            'Por la compra de  ',
            style: TextStyle(fontSize: 12, color: kGrey600),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AddMinusButton(
              onPressedMinus: () {
                setState(() {
                  quantity--;
                });
              },
              onPressedMore: () {
                setState(() {
                  quantity++;
                });
              },
              quantity: quantity,
            )
          ]),
          const Text(
            ' obtienes:',
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Expanded _descriptionProduct() {
    return Expanded(
      child: Container(
        color: kWhite,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: const TextStyle(
                  fontSize: 16, color: kGrey900, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  'SKU: ${widget.product.sku}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: kGrey800,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.product.description,
              style: const TextStyle(
                  fontSize: 12, color: kGrey800, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.share_outlined,
                      color: kGrey800,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.favorite,
                      color: kGrey400,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
