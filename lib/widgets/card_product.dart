import 'package:flutter/material.dart';

import '../../data/themes.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: kGrey400,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Image.network(
                      'https://d2r9epyceweg5n.cloudfront.net/stores/987/204/products/rimula-r4-x-15w40-4l1-ac889731d29dd4c3fc16197199460451-640-0.jpg',
                      width: 120),
                  Positioned(
                      right: 0,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('¡Nuevo!'))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shell Advance AX5 ',
                      style: TextStyle(
                          fontSize: 16,
                          color: kGrey900,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '20W-50',
                      style: TextStyle(
                          fontSize: 16,
                          color: kGrey900,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    const Row(
                      children: [
                        Text(
                          'SKU:45465465',
                          style: TextStyle(
                              fontSize: 12,
                              color: kGrey800,
                              fontWeight: FontWeight.w300),
                        ),
                        Text('-'),
                        Text('Disponible',
                            style: TextStyle(
                              color: kGreen,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: kGrey200,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: kGrey400,
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.remove,
                            size: 10,
                          ),
                        ),
                        const Text(
                          ' 1 ',
                          style: TextStyle(fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: kGrey200,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: kGrey400,
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 10,
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'S/850.00',
                          style: TextStyle(
                              fontSize: 20,
                              color: kSecondary,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(' - '),
                        Text(''),
                        Text(
                          "S/ 870.00",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: kGrey500),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Text('\u{1f525}'),
                        Text(
                          ' Estás ahorrando S/20.00',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: kSecondary),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'Lubricante de alta calidad diseñado especificamente para motores de motocicleta',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12,
                color: Colors.grey.shade600),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Ganas: '),
                  Text(
                    '10 puntos',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFF00BBF9),
                        fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.turned_in_not,
                    color: Colors.grey.shade800,
                  ),
                  const Icon(
                    Icons.delete_forever_sharp,
                    color: Color(0xFFF86C5E),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
