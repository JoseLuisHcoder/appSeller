import 'package:vendedor/data/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vendedor/domain/blocs/auth/auth_bloc.dart';
import 'package:vendedor/presentation/screens/home/widgets/ben.dart';
import 'package:vendedor/presentation/screens/login/login.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Drawer(
      child: Container(
        color: kBgColor,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 45.0, right: 16.0, left: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: const TextSpan(
                      text: 'Editar perfil',
                      style: TextStyle(
                        color: kPrimary,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Tu Nombre',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 20,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                radius: 48,
                backgroundColor: kSecondary200,
                child: Icon(
                  Icons.face,
                  color: kPrimary,
                  size: 50,
                ),
              ),
              decoration: BoxDecoration(
                color: kBgColor,
                boxShadow: [],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: LayoutBuilder(
            //       builder: (context, constraints) {
            //         final progressBarWidth = constraints.maxWidth * 0.75;
            //         return Stack(
            //           alignment: Alignment.centerLeft,
            //           children: [
            //             const SizedBox(
            //               height: 20,
            //               child: LinearProgressIndicator(
            //                 value: 0.75,
            //                 backgroundColor: kGrey600,
            //                 valueColor: AlwaysStoppedAnimation<Color>(
            //                   kGrey800,
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               width: progressBarWidth,
            //               height: 20,
            //               decoration: const BoxDecoration(
            //                 gradient: LinearGradient(
            //                   begin: Alignment.topCenter,
            //                   end: Alignment.bottomCenter,
            //                   colors: [
            //                     Color(0xFFD9D9D9),
            //                     Color(0xFFFFFFFF),
            //                     Color(0xFFCACACA),
            //                   ],
            //                   stops: [
            //                     0,
            //                     0.75,
            //                     1,
            //                   ],
            //                 ),
            //               ),
            //               child: const Stack(
            //                 alignment: Alignment.centerLeft,
            //                 children: [
            //                   Positioned(
            //                     left: 2,
            //                     child: Icon(
            //                       Icons.diamond_outlined,
            //                       color: kTextColor,
            //                       size: 16,
            //                     ),
            //                   ),
            //                   Positioned(
            //                     right: 2,
            //                     child: Text(
            //                       '3000',
            //                       style: TextStyle(
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.w400,
            //                         color: kTextColor,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         );
            //       },
            //     ),
            //   ),
            // ),
            const Divider(color: kTextColor),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text('Beneficios'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ben()),
                );
              },
            ),

            // ListTile(
            //   leading: const Icon(Icons.workspace_premium),
            //   title: const Text('Insignias'),
            //   trailing: const Icon(Icons.arrow_forward_ios),
            //   onTap: () {
            //     // Acción cuando se toca "Insignias y beneficios"
            //   },
            // ),

            // ListTile(
            //   leading: const Icon(Icons.workspace_premium),
            //   title: const Text('Trivias'),
            //   trailing: const Icon(Icons.arrow_forward_ios),
            //   onTap: () {
            //     // Acción cuando se toca "Insignias y beneficios"
            //   },
            // ),
            const Divider(color: kTextColor),
            ListTile(
              leading: const Icon(Icons.tune),
              title: const Text('Configuración'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Acción cuando se toca "Configuración"
              },
            ),
            const Divider(color: kTextColor),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Centro de ayuda'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Acción cuando se toca "Centro de ayuda"
              },
            ),
            const Divider(color: kTextColor),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    authBloc.add(LogOutEvent());
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Login()),
                        (Route route) => false);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.power_settings_new_rounded,
                        color: kPrimary,
                      ),
                      SizedBox(width: 8.0),
                      TextButton(
                        onPressed: () {
                          authBloc.add(LogOutEvent());
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                              (Route route) => false);
                        },
                        child: Text(
                          'Cerrar sesión',
                          style: TextStyle(
                            color: kPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
