// import 'package:ecommerce/domain/blocs/blocs.dart';
// import 'package:ecommerce/domain/models/product.dart';
// import 'package:ecommerce/presentation/widgets/add_minus_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/themes.dart';

// class MoreInfoOffer extends StatefulWidget {
//   final void Function()? onPressedClose;
//   final Product? product;
//   const MoreInfoOffer({super.key, required this.onPressedClose, this.product});

//   @override
//   State<MoreInfoOffer> createState() => _MoreInfoOfferState();
// }

// class _MoreInfoOfferState extends State<MoreInfoOffer> {
//   int quantity = 1;
//   @override
//   Widget build(BuildContext context) {
//     final productBloc = BlocProvider.of<ProductBloc>(context);
//     return Container(
//         color: kWhite,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 3,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           widget.product!.name,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: kGrey900,
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.close),
//                         onPressed: widget.onPressedClose,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(widget.product!.description!,
//                             maxLines: 5,
//                             style:
//                                 const TextStyle(color: kGrey800, fontSize: 10)),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 7,
//                   ),
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     AddMinusButton(
//                       onPressedMinus: () {
//                         setState(() {
//                           quantity--;
//                         });
//                       },
//                       onPressedMore: () {
//                         setState(() {
//                           quantity++;
//                         });
//                       },
//                       quantity: quantity,
//                     )
//                   ]),
//                   const SizedBox(
//                     height: 2,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       widget.onPressedClose!();
//                       productBloc.add(
//                           OnAddProductToCartEvent(widget.product!, quantity));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: btnBgPrimary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 5),
//                         child: const Row(
//                           children: [
//                             Icon(
//                               Icons.shopping_cart_checkout_outlined,
//                               color: btnPrimary,
//                             ),
//                             Text(
//                               'Agregar',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: btnPrimary),
//                             ),
//                           ],
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 2,
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('\u{1f525} '),
//                       Text('Estás ahorrando S/20.00',
//                           style: TextStyle(color: kSecondary, fontSize: 12)),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }
