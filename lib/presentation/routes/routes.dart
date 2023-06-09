// import 'package:ecommerce/presentation/screens/home/home_page.dart';
// import 'package:ecommerce/presentation/screens/login/loading_page.dart';
// import 'package:ecommerce/presentation/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:vendedor/presentation/screens/home/home_page.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  // 'loadingPage': (context) => LoadingPage(),
  'getStarted': (context) => const HomePage(),
  // 'signInPage': (context) => Login(),
};
