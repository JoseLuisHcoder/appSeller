import 'package:flutter/material.dart';
import 'package:vendedor/data/themes.dart';
import 'package:vendedor/presentation/screens/home/widgets/ben3.dart';

import 'package:vendedor/widgets/add_minus_button.dart';

class Ben2 extends StatelessWidget {
  const Ben2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffbe3e),
      ),
      body: Container(
        color: Color(0xffffbe3e),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.98,
              child: Image.asset(
                'images/bs33.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          _buttonHeader(context),
          // Container(
          //     padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
          //     margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         ElevatedButton(
          //             onPressed: () {
          //               // Navigator.push(context,
          //               //     MaterialPageRoute(builder: (context) => Ben2()));
          //             },
          //             child: Text('Mis puntos')),
          //         ElevatedButton(
          //             onPressed: () {
          //               // Navigator.push(
          //               //     context,
          //               //     MaterialPageRoute(
          //               //         builder: (context) => BenSlider()));
          //             },
          //             child: Text('Beneficios')),
          //       ],
          //     ))
        ]),
      ),
    );
  }

  Container _buttonHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: kTextColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.chevron_left_outlined,
                    size: 35,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Soy exclusivo',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Ben3()));
            },
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: kTextColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.navigate_next_outlined,
                    size: 35,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
