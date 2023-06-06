import 'package:vendedor/data/utils.dart';
import 'package:vendedor/domain/blocs/blocs.dart';
import 'package:vendedor/domain/models/product.dart';
import 'package:vendedor/domain/services/product_favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/themes.dart';
import '../domain/blocs/product/product_event.dart';
import 'add_minus_button.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;
  const DetailProductPage({super.key, required this.product});
  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int quantity = 1;
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Detalles del Producto',
            style: TextStyle(
              fontSize: 18,
              color: kGrey400,
            ),
          ),
          iconTheme: const IconThemeData(color: kGrey400),
          backgroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                // _countItems(),
                const SizedBox(
                  height: 10,
                ),
                _addButton(),

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
                    'S/${widget.product.productPrice.price.toString()}',
                    style: TextStyle(
                        fontSize: 20,
                        color: kSecondary,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  productBloc
                      .add(OnAddProductToCartEvent(widget.product, quantity));
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
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 10),
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
                        Expanded(
                          // Agregado Expanded
                          child: Text(
                            'Agregar',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: btnPrimary),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Container _countItems() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     child: Row(
  //       children: [

  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //           AddMinusButton(
  //             onPressedMinus: () {
  //               setState(() {
  //                 quantity--;
  //               });
  //             },
  //             onPressedMore: () {
  //               setState(() {
  //                 quantity++;
  //               });
  //             },
  //             quantity: quantity,
  //           )
  //         ]),

  //       ],
  //     ),
  //   );
  // }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share_outlined,
                        color: kGrey800,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        await productFavoriteServices.postFavorite(
                            idProduct: widget.product.id);
                        setState(() {
                          isFavorite = true;
                        });
                      },
                      child: Icon(
                        Icons.favorite,
                        color: isFavorite ? Colors.red : icoFavDisabled,
                      ),
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
