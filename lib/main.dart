import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendedor/data/themes.dart';
import 'package:vendedor/domain/blocs/auth/auth_bloc.dart';

import 'package:vendedor/presentation/screens/base.dart';
import 'package:vendedor/presentation/screens/login/loading_page.dart';

import 'domain/blocs/auth/auth_bloc.dart';
import 'domain/blocs/cart/cart_bloc.dart';
import 'domain/blocs/product/product_bloc.dart';
import 'domain/blocs/promotion/promotion_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        theme: solarTheme,
        home: LoadingPage(),
      ),
    );
  }
}
