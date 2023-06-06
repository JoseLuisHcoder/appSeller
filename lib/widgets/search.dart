// import 'dart:async';
// import 'dart:math';

// import 'package:ecommerce/data/data.dart';
// import 'package:ecommerce/presentation/screens/search/search_page.dart';
// import 'package:flutter/material.dart';

// import '../../data/themes.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   String searchText = 'Busca en nuestro almacen';
//   Random random = Random();
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     startTextRotation();
//   }

//   void startTextRotation() {
//     _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
//       setState(() {
//         int randomIndex = random.nextInt(4);
//         searchText = searchTextRotation[randomIndex];
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         CustomSearchDelegate searchDelegate = CustomSearchDelegate();
//         showSearch(
//           context: context,
//           delegate: searchDelegate,
//         );
//       },
//       child: Container(
//         height: 32,
//         margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: kAppBar,
//           ),
//           color: kWhite,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [
//             const SizedBox(width: 10),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 500),
//                   transitionBuilder:
//                       (Widget child, Animation<double> animation) {
//                     return FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     );
//                   },
//                   child: Text(
//                     searchText,
//                     key: ValueKey<String>(searchText),
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: 40,
//               margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
//               decoration: BoxDecoration(
//                 color: kAppBar,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(
//                 Icons.search,
//                 color: kWhite,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
