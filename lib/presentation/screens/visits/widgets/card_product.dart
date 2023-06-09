import 'dart:ui';

import 'package:vendedor/data/utils.dart';
import 'package:vendedor/domain/blocs/blocs.dart';
import 'package:vendedor/domain/models/cart_product.dart';
import 'package:vendedor/domain/models/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/themes.dart';
import '../../../../widgets/add_minus_button.dart';

class CardProduct extends StatefulWidget {
  final CartProduct? product;
  const CardProduct({super.key, required this.product});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    // final productBloc = BlocProvider.of<ProductBloc>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: kGrey400,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: 140,
                      child: widget.product?.product.productImage[0].urlPath !=
                              null
                          ? FadeInImage.assetNetwork(
                              placeholder: defaultImage, // imagen por defecto
                              image: widget.product?.product.productImage[0]
                                      .urlPath ??
                                  "",
                              fit: BoxFit.contain,
                            )
                          : Image.asset(defaultImage, fit: BoxFit.contain)),
                  Positioned(
                      right: 0,
                      child: Container(
                          width: 54,
                          height: 20,
                          child: Stack(children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    width: 54,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: kBlue,
                                    ),
                                    child: const Stack(children: <Widget>[
                                      Positioned(
                                          top: 3,
                                          left: 9,
                                          child: Text(
                                            '¡Nuevo!',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: kWhite,
                                                fontSize: 12,
                                                letterSpacing:
                                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          )),
                                    ]))),
                          ]))),
                ],
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product!.product.name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: kTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          'SKU: ${widget.product?.product.sku}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: kTextColor,
                              fontWeight: FontWeight.w300),
                        ),
                        const Text('-'),
                        const Text('Disponible',
                            style: TextStyle(
                              color: kGreen,
                            ))
                      ],
                    ),
                    AddMinusButton(
                      onPressedMinus: () {
                        // setState(() {
                        //   productBloc.add(OnSubstractProductToCartEvent(
                        //       widget.product!.product.id));
                        // });
                      },
                      onPressedMore: () {
                        // setState(() {
                        //   productBloc.add(OnAddQuantityProductToCartEvent(
                        //       widget.product!.product.id));
                        // });
                      },
                      quantity: widget.product!.quantity,
                    ),
                    Row(
                      children: [
                        Text(
                          "S/${widget.product!.product.productPrice.price}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: kSecondary,
                              fontWeight: FontWeight.w400),
                        ),
                        const Text(' - '),
                        const Text(''),
                        Text(
                          "S/${widget.product?.product.productPrice.price}",
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: kGrey500),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Text('\u{1f525}'),
                        Text(
                          ' Estás ahorrando S/20.00',
                          style: TextStyle(fontSize: 12, color: kSecondary),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            widget.product!.product.description!,
            style: const TextStyle(fontSize: 12, color: kTextColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Ganas: '),
                  Text(
                    '10 puntos',
                    style: TextStyle(color: kBlue, fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.turned_in_not,
                    color: kGrey800,
                  ),
                  GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   productBloc.add(OnDeleteProductToCartEvent(
                        //       widget.product!.product.id));
                        // });
                      },
                      child: const Icon(
                        Icons.delete_forever_sharp,
                        color: kSecondary,
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
