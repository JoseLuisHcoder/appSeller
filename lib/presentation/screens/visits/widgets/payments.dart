import 'package:flutter/material.dart';

import '../../../../data/themes.dart';
import '../../../../widgets/search_static.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: kGrey800),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              // const Flexible(child: SearchStatic()),
              SizedBox(
                  width: 48,
                  child: IconButton(
                      color: Colors.grey.shade800,
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code)))
            ],
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _saldo(),
            _linearProgress(),
            const SizedBox(
              height: 5,
            ),
            _lineCredit(),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            _balanceOutstanding(),
            const Divider(),
            _imageCenter(context),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                        labelColor: const Color(0xff00BBF9),
                        unselectedLabelColor: Colors.grey.shade800,
                        indicatorColor: const Color(0xff00BBF9),
                        tabs: const [
                          Tab(text: 'Deuda vencida'),
                          Tab(
                            text: 'Deuda por vencer',
                          )
                        ]),
                    Expanded(
                        child: TabBarView(children: [
                      _listOrders(context),
                      _listOrders2(context)
                    ]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _imageCenter(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Icon(
                  Icons.signal_cellular_alt,
                  size: 80,
                  color: Colors.grey.shade400,
                )),
            const SizedBox(
              height: 4,
            ),
            const Text('Antiguedad de la deuda'),
          ],
        ));
  }

  Container _balanceOutstanding() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: 'Proximo pago: ',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color(0xff525252))),
                TextSpan(
                    text: '25 de mayo',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff525252))),
              ])),
              const Text('S/ 1750.00',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff525252)))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Saldo pendiente',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color(0xff525252))),
              Text('S/ 1250.00',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color(0xff525252))),
            ],
          ),
        ],
      ),
    );
  }

  Container _lineCredit() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Linea de crédito: ',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: Color(0xff525252))),
            TextSpan(
                text: 'S/ 5000.00',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff525252))),
          ])),
          const Icon(
            Icons.warning_rounded,
            color: Color(0xffF86C5E),
          )
        ],
      ),
    );
  }

  Container _linearProgress() {
    return Container(
        height: 6,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: LinearProgressIndicator(
          color: const Color(0xff00BBF9),
          value: 0.7,
          backgroundColor: Colors.grey.shade200,
        ));
  }

  Container _saldo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Consumido',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color(0xff525252))),
              Text('Disponible',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color(0xff525252))),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('S/ 3000.00',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color(0xff525252))),
              Text('S/ 2000.00',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color(0xff525252))),
            ],
          ),
        ],
      ),
    );
  }

  Container _listOrders(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Column(
        children: [
          const Divider(),
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.grey.shade600,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'P001-0005645',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800),
                          ),
                          const Text(
                            'Vencio el 12/05/2023',
                            style: TextStyle(color: Color(0xffF86C5E)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'S/ 750.00',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.grey.shade600,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'P001-0005632',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800),
                          ),
                          const Text(
                            'Vencio el 10/05/2023',
                            style: TextStyle(color: Color(0xffF86C5E)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'S/ 500.00',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.grey.shade600,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'P001-0005620',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800),
                          ),
                          const Text(
                            'Vencio el 02/05/2023',
                            style: TextStyle(color: Color(0xffF86C5E)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'S/ 1750.00',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: Colors.white,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'P001-0005620',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            'Vencio el 02/05/2023',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'S/ 3000.00',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _listOrders2(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Column(
        children: [
          const Divider(),
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.grey.shade600,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'P001-0005645',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800),
                          ),
                          const Text(
                            'Vence el 12/05/2023',
                            style: TextStyle(color: Color(0xff00BBF9)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'S/ 200.00',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.grey.shade600,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'P001-0005632',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800),
                          ),
                          const Text(
                            'Vence el 10/05/2023',
                            style: TextStyle(color: Color(0xff00BBF9)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'S/ 150.00',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: Colors.white,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'P001-0005620',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            'Vencio el 02/05/2023',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'S/ 350.00',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              )
            ],
          ),
        ],
      ),
    );
  }
}
