// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:ecommerce/data/utils.dart';
// import 'package:ecommerce/domain/blocs/blocs.dart';
// import 'package:ecommerce/domain/models/product.dart';
// import 'package:ecommerce/domain/models/response/product_image.dart';
// import 'package:ecommerce/presentation/widgets/more_info_offer.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/themes.dart';

// class CardProductOption3 extends StatefulWidget {
//   final Product? product;
//   final void onPressed;
//   const CardProductOption3({super.key, required this.product, this.onPressed});

//   @override
//   State<CardProductOption3> createState() => _CardProductOption3State();
// }

// class _CardProductOption3State extends State<CardProductOption3> {
//   bool _showOverlay = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       padding: const EdgeInsets.all(10),
//       width: 200,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 2,
//           color: kGrey400,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               _slider(widget.product!.productImage),
//               const SizedBox(
//                 height: 4,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 2),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 7, vertical: 2),
//                       decoration: BoxDecoration(
//                           color: kGrey200,
//                           border: Border.all(width: 1, color: kGrey200),
//                           borderRadius: BorderRadius.circular(16)),
//                       child: Text(
//                         widget.product?.categoryItem!.name ?? "",
//                         style: const TextStyle(fontSize: 12, color: kGrey800),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 3,
//                     ),
//                     Text(
//                       widget.product?.name ?? "Nombre no disponible",
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: kGrey800,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('SKU: ${widget.product?.sku}',
//                             style:
//                                 const TextStyle(color: kGrey800, fontSize: 12)),
//                         const Icon(Icons.favorite, color: icoFavDisabled),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     Row(
//                       children: [
//                         const Text('\u{1f525} '),
//                         Text(
//                           "S/${widget.product?.productPrice.price}",
//                           style: const TextStyle(
//                               fontSize: 14,
//                               color: kSecondary,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "S/${(widget.product?.productPrice.price)}",
//                           style: const TextStyle(
//                               decoration: TextDecoration.lineThrough,
//                               fontSize: 10,
//                               color: kGrey500),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                             'Quedan  ${widget.product?.productStock?.actualStock}',
//                             style: TextStyle(color: kSecondary, fontSize: 12)),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _showOverlay = true;
//                             });
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 color: kGrey200,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child:
//                                   const Icon(Icons.keyboard_arrow_up_outlined)),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//           if (_showOverlay)
//             MoreInfoOffer(
//               onPressedClose: () {
//                 setState(() {
//                   _showOverlay = false;
//                 });
//               },
//               product: widget.product,
//             )
//         ],
//       ),
//     );
//   }

//   Widget _slider(List<ProductImage> images) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 100,
//         aspectRatio: 16 / 9,
//         viewportFraction: 1,
//         autoPlay: false,
//         enlargeCenterPage: true,
//         enableInfiniteScroll: true,
//       ),
//       items: _getImages(images),
//     );
//   }

//   List<Widget> _getImages(List<ProductImage> images) {
//     return images.map((image) {
//       return Container(
//         height: 85,
//         child: image.urlPath != null
//             ? FadeInImage.assetNetwork(
//                 placeholder: defaultImage,
//                 image: image.urlPath,
//                 fit: BoxFit.contain,
//               )
//             : Image.asset(defaultImage, fit: BoxFit.fitHeight),
//       );
//     }).toList();
//   }
// }
