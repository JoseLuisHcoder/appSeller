// import 'package:ecommerce/data/utils.dart';
// import 'package:ecommerce/domain/models/product.dart';
// import 'package:ecommerce/domain/services/product_favorite_service.dart';
// import 'package:ecommerce/presentation/widgets/detail_product_page.dart';
// import 'package:ecommerce/presentation/widgets/promotion_detail.dart';
// import 'package:flutter/material.dart';

// import '../../data/themes.dart';

// class CardProductOption4 extends StatefulWidget {
//   final Product product;
//   final void onPressed;
//   const CardProductOption4({super.key, required this.product, this.onPressed});

//   @override
//   State<CardProductOption4> createState() => _CardProductOption4State();
// }

// class _CardProductOption4State extends State<CardProductOption4> {
//   bool isFavorite = false;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => DetailProductPage(
//                       product: widget.product,
//                     )));
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         padding: const EdgeInsets.all(10),
//         width: 170,
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: kGrey400,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//                 height: 100,
//                 child: widget.product?.productImage[0].urlPath != null
//                     ? FadeInImage.assetNetwork(
//                         placeholder: defaultImage, // imagen por defecto
//                         image: widget.product?.productImage[0].urlPath ?? "",
//                         fit: BoxFit.contain,
//                       )
//                     : Image.asset(defaultImage, fit: BoxFit.contain)),
//             SizedBox(
//               height: 4,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${widget.product?.brandItem?.name}",
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: kGrey800,
//                     ),
//                   ),
//                   Text(
//                     "${widget.product?.name}",
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: kGrey900,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'SKU: ${widget.product?.sku}',
//                         style: const TextStyle(
//                             fontSize: 12,
//                             color: kGrey800,
//                             fontWeight: FontWeight.w300),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "S/${widget.product?.productPrice.price}",
//                         style: const TextStyle(
//                             fontSize: 20,
//                             color: kSecondary,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ],
//                   ),
//                   const Row(
//                     children: [
//                       Row(
//                         children: [
//                           Text('Ganas: '),
//                           Text(
//                             '10 puntos',
//                             style: TextStyle(color: kBlue, fontSize: 14),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Disponible',
//                           style: TextStyle(color: kGreen, fontSize: 14)),
//                       InkWell(
//                         onTap: () async {
//                           await productFavoriteServices.postFavorite(
//                               idProduct: widget.product.id);
//                           setState(() {
//                             isFavorite = true;
//                           });
//                         },
//                         child: Icon(
//                           Icons.favorite,
//                           color: isFavorite ? Colors.red : icoFavDisabled,
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
