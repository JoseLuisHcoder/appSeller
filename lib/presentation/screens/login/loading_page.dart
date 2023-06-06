import 'package:vendedor/domain/blocs/blocs.dart';
import 'package:vendedor/presentation/screens/base.dart';
import 'package:vendedor/presentation/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/themes.dart';
import '../../../domain/blocs/product/product_event.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_animationController);

    _animation.addStatusListener(_animationListener);

    _animationController.forward();
  }

  _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.removeStatusListener(_animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogOutState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Login()),
              (Route route) => false);
        } else if (state is SuccessAuthState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Base()),
              (Route route) => false);
        } else if (state is SuccessCartLoaded) {
          final productBloc = BlocProvider.of<ProductBloc>(context);
          productBloc.add(OnLoadedCartEvent());
        } else if (state is FailureCartLoaded) {
          final productBloc = BlocProvider.of<ProductBloc>(context);
          productBloc.add(OnNotLoadedCartEvent());
        }
      },
      child: Scaffold(
        backgroundColor: kBgLoadingColor,
        body: Center(
            child: SizedBox(
          height: 212,
          width: 181,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, child) => Transform.scale(
                  scale: _animation.value,
                  child: Image.asset('images/solarLoading.png'),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
