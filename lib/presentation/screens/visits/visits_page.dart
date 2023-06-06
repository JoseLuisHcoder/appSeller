import 'package:flutter/material.dart';
import 'package:vendedor/presentation/screens/visits/widgets/visits_customer_nfo.dart';

import '../../../data/themes.dart';
import '../../../widgets/search_static.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

const String textSearch = "Ingresa los datos";

class _VisitsPageState extends State<VisitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Row(
            children: [
              Flexible(child: SearchStatic(textSearch: textSearch)),
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
                          Tab(text: 'Clientes en ruta'),
                          Tab(
                            text: 'Clientes fuera de ruta',
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

  Container _lineCredit() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Clientes a visitar: ',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: kAppBar)),
            TextSpan(
                text: '17',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: kAppBar)),
          ])),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Visitados',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff525252))),
                  Text('('),
                  Icon(Icons.timer_outlined, size: 12, color: kAppBar),
                  Text('2h 3m',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: kAppBar)),
                  Text(')')
                ],
              ),
              Text('Por visitar',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Color(0xff525252))),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text('5',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: kAppBar)),
                Text('('),
                Text('Tiempo de visita:',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: kAppBar)),
                Text('2h 3m',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: kAppBar)),
                Text(')')
              ]),
              Text('12',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: kAppBar)),
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
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'CERRO COLORADO',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20, color: kTextColor),
                    ),
                  ],
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => VisitsCustomerInfo()));
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey.shade600,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Text(
                                    'LUBRIMOTORS SQL',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Text(
                                    'Calle Las Américas 563',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ultima visita: HOY 10:20 AM',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGrey500),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        'VISITADO',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGreen),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => VisitsCustomerInfo()));
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey.shade600,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Text(
                                    'REPRESENTACIONES CABAÑA DIESEL',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Text(
                                    'Calle Las Américas 863',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ultima visita: 12-MAY-2023',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGrey500),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGreen),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
            Divider(),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'CAYMA',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20, color: kTextColor),
                    ),
                  ],
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => VisitsCustomerInfo()));
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey.shade600,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Text(
                                    'LUBRIMOTORS SQL',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Text(
                                    'Calle Las Américas 563',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ultima visita: HOY 10:20 AM',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGrey500),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        'VISITADO',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGreen),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => VisitsCustomerInfo()));
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey.shade600,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Text(
                                    'REPRESENTACIONES CABAÑA DIESEL',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Text(
                                    'Calle Las Américas 863',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kAppBar),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ultima visita: 12-MAY-2023',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGrey500),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: kGreen),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
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
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Container _listOrders2(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
        child: Column(
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'CERRO COLORADO',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20, color: kTextColor),
                    ),
                  ],
                ),
                const Divider(),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.grey.shade600,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Text(
                                  'LUBRIMOTORS SQL',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Text(
                                  'Calle Las Américas 563',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ultima visita: HOY 10:20 AM',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGrey500),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      'VISITADO',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGreen),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.grey.shade600,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Text(
                                  'REPRESENTACIONES CABAÑA DIESEL',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Text(
                                  'Calle Las Américas 863',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ultima visita: 12-MAY-2023',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGrey500),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGreen),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
            Divider(),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'CAYMA',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20, color: kTextColor),
                    ),
                  ],
                ),
                const Divider(),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.grey.shade600,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Text(
                                  'LUBRIMOTORS SQL',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Text(
                                  'Calle Las Américas 563',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ultima visita: HOY 10:20 AM',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGrey500),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      'VISITADO',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGreen),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.grey.shade600,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Text(
                                  'REPRESENTACIONES CABAÑA DIESEL',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Text(
                                  'Calle Las Américas 863',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kAppBar),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ultima visita: 12-MAY-2023',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGrey500),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kGreen),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
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
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
