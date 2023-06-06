// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:ecommerce/presentation/widgets/promotion_detail.dart';
// import 'package:flutter/material.dart';

// import '../../data/themes.dart';
// import '../../domain/models/response/product_promotions.dart';

// class SliderHome extends StatelessWidget {
 

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//         options: CarouselOptions(
//           height: 180, // Altura del carrusel
//           aspectRatio: 16 / 9, // Relación de aspecto de las imágenes
//           viewportFraction: 1, // Porción visible de cada imagen en el carrusel
//           autoPlay: true, // Reproducción automática del carrusel
//           autoPlayInterval: Duration(
//               seconds:
//                   5), // Intervalo de tiempo entre las transiciones automáticas
//           autoPlayAnimationDuration: Duration(
//               milliseconds:
//                   800), // Duración de la animación de transición automática
//           pauseAutoPlayOnTouch:
//               true, // Pausar reproducción automática al tocar el carrusel
//           enlargeCenterPage: true, // Agrandar la imagen central del carrusel
//           enableInfiniteScroll:
//               true, // Habilitar el desplazamiento infinito del carrusel
//         ),
//         itemCount: 5,
//         itemBuilder: (BuildContext context, index, i) {
//           return GestureDetector(
//             onTap: () {
//                          },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                           flex: 2,
//                           child: Column(
//                             children: [
//                               Container(
//                                 decoration: const BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(10)),
//                                   color: bgPromoCardUp,
//                                 ),
//                                 padding: const EdgeInsets.all(8),
//                                 width: double.infinity,
//                                 child: RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: 'Por cada ',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: promoCardUp,
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: product[index].name,
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: promoCardUp,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: ' obtienes: ',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: promoCardUp,
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 color: bgPromoCardMidle,
//                                 width: double.infinity,
//                                 child: RichText(
//                                   text: const TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: ' \u{1f381} ',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: '8 baldes del mismo producto',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: promoCardMiddle,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: '\n \u{1f381} ',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: '2 botellas del mismo producto',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: promoCardMiddle,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 // const Column(
//                                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                                 //     children: [
//                                 //       Text(
//                                 //         '8 baldes del mismo producto',
//                                 //         style: TextStyle(
//                                 //             fontSize: 12,
//                                 //             color: kWhite,
//                                 //             fontWeight: FontWeight.w400),
//                                 //       ),
//                                 //       Text(
//                                 //         '2 botellas del mismo producto',
//                                 //         style: TextStyle(
//                                 //             fontSize: 12,
//                                 //             color: kWhite,
//                                 //             fontWeight: FontWeight.w400),
//                                 //       )
//                                 //     ]),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: const BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(10)),
//                                   color: bgPromoCardDown,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Text('\u{1f525}'),
//                                     Text(
//                                       'S/ ',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: promoCardDown,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     Text(
//                                       product[index]
//                                           .productPrice
//                                           .price
//                                           .toString(),
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: promoCardDown,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     Text('  '),
//                                     Text(
//                                       "S/ 970.00",
//                                       style: TextStyle(
//                                           decoration:
//                                               TextDecoration.lineThrough,
//                                           color: kGrey500),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )),
//                       Expanded(
//                         flex: 1,
//                         child: Image.network(
//                             product[index].productImage[0].urlPath,
//                             width: 120),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
