import 'package:carousel_slider/carousel_slider.dart';
import 'package:vendedor/data/themes.dart';

import 'package:flutter/material.dart';
import 'package:vendedor/domain/models/response/product_promotions.dart';

class CardProductPromotions extends StatelessWidget {
  final ProductPromotions product;
  CardProductPromotions({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(10)),
                          color: bgPromoCardUp,
                        ),
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: promoCardUp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            product.promotionsBonus.isNotEmpty == true
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Por la compra de ${product.promotionsBonus[0].nPurchasedItems} recibes ${product.promotionsBonus[0].mBonusItems} de regalo',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: promoCardUp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  )
                                : Container(),
                            product.promotionsGift.isNotEmpty == true
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Por ${product.promotionsGift[0]["condition"]} recibes:',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: promoCardUp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      product.promotionsGift.isNotEmpty == true
                          ? Container(
                              padding: const EdgeInsets.all(8),
                              color: bgPromoCardMidle,
                              width: double.infinity,
                              child: RichText(
                                text: TextSpan(
                                    children: gifts(product.promotionsGift)),
                              ),
                            )
                          : Container(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10)),
                          color: bgPromoCardDown,
                        ),
                        child: Column(
                          children: [
                            product.promotionsDiscount.isNotEmpty == true
                                ? Text(
                                    'Por la compra de ${product.promotionsDiscount[0]["minimum_quantity"]} recibes ${product.promotionsDiscount[0]["discount_percentage"]}% de descuento :',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: promoCardUp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                : Container(),
                            product.promotionsDiscount.isNotEmpty == true
                                ? Row(
                                    children: [
                                      const Text('\u{1f525}'),
                                      Text(
                                        "S/ ${product.productPrice.price - (product.productPrice.price * product.promotionsDiscount[0]["discount_percentage"] / 100)}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: promoCardDown,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const Text('  '),
                                      Text(
                                        "S/ ${product.productPrice.price}",
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: kGrey500),
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      const Text('\u{1f525}'),
                                      Text(
                                        "S/ ${product.productPrice.price}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: promoCardDown,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      )
                    ],
                  )),
              Expanded(
                flex: 1,
                child:
                    Image.network(product.productImage[0].urlPath, width: 120),
              )
            ],
          )
        ],
      ),
    );
  }

  List<InlineSpan> gifts(promotion) {
    List<InlineSpan> gifts = [];
    for (var gift in promotion) {
      gifts.add(const TextSpan(
        text: ' \u{1f381} ',
        style: TextStyle(
          fontSize: 12,
        ),
      ));
      gifts.add(TextSpan(
        text: gift["gift"]["name"],
        style: const TextStyle(
          fontSize: 12,
          color: promoCardMiddle,
          fontWeight: FontWeight.w400,
        ),
      ));
    }
    return gifts;
  }
}
