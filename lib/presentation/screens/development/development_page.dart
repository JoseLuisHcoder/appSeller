import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendedor/domain/blocs/auth/auth_bloc.dart';
import 'package:vendedor/presentation/screens/login/login.dart';

class DevelopmentPage extends StatelessWidget {
  const DevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('DevelopmentPage'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              authBloc.add(LogOutEvent());
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route route) => false);
            },
            child: Text('Cerrar sesion')),
      ),
    );
  }
}
