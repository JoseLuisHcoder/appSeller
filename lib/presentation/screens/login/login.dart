import 'package:ecommerce/domain/blocs/blocs.dart';
import 'package:ecommerce/presentation/screens/base.dart';
import 'package:ecommerce/presentation/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/themes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool _obscureText = true;

class _LoginState extends State<Login> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    _passwordController.clear();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Cargando"), backgroundColor: kGreen));
        } else if (state is FailureAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: kError));
        } else if (state is SuccessAuthState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Base()),
              (_) => false);
        } else if (state is SuccessCartLoaded) {
          final productBloc = BlocProvider.of<ProductBloc>(context);
          productBloc.add(OnLoadedCartEvent());
        } else if (state is FailureCartLoaded) {
          final productBloc = BlocProvider.of<ProductBloc>(context);
          productBloc.add(OnNotLoadedCartEvent());
        }
      },
      child: Scaffold(
          backgroundColor: kGrey200,
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Image.asset(
                      'images/solar.png',
                      width: 250,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('¡Bienvenido!',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const Text('Inicia sesión',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Correo Electrónico',
                          hintStyle: TextStyle(fontSize: 16),
                          contentPadding: EdgeInsets.only(top: 18),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          hintStyle: const TextStyle(fontSize: 16),
                          contentPadding: const EdgeInsets.only(top: 18),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(fontSize: 16, color: kGrey600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          authBloc.add(LoginEvent(_emailController.text.trim(),
                              _passwordController.text.trim()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondary,
                        ),
                        child: const Text('Iniciar sesión',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kWhite)),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}
