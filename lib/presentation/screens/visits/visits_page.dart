import 'package:flutter/material.dart';
import 'package:vendedor/domain/models/response/customer_seller.dart';
import 'package:vendedor/domain/models/response/history_orders.dart';
import 'package:vendedor/domain/services/customers_services.dart';
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
        child: FutureBuilder(
            future: customerServices.getCustomerSeller(),
            builder: (BuildContext context,
                AsyncSnapshot<CustomerSeller?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Muestra un mensaje de error si ocurre un error
              } else if (snapshot.hasData) {
                CustomerSeller? customers = snapshot.data;
                if (customers != null) {
                  List<ResponseData>? responsesCompleted = customers.response
                      .where((response) => response.results2.any((result2) =>
                          result2.orders.any((order) => order.order.completed)))
                      .toList();

                  List<ResponseData>? responsesNotCompleted = customers.response
                      .where((response) => response.results2.every((result2) =>
                          result2.orders
                              .every((order) => !order.order.completed)))
                      .toList();
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      _saldo(customers),
                      _linearProgress(customers),
                      const SizedBox(
                        height: 5,
                      ),
                      _lineCredit(customers),
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
                                _listOrders(context, responsesCompleted),
                                _listOrders(context, responsesNotCompleted)
                              ]))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Text("No se pudo cargar la data");
              }
              return Text("No se pudo cargar la data");
            }),
      ),
    );
  }

  Container _lineCredit(CustomerSeller customers) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Clientes a visitar: ',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: kAppBar)),
            TextSpan(
                text:
                    "${(customers.ordersCompleted + customers.ordersNotCompleted)}",
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

  Container _linearProgress(CustomerSeller customers) {
    return Container(
        height: 6,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: LinearProgressIndicator(
          color: const Color(0xff00BBF9),
          value: customers.ordersCompleted /
              (customers.ordersNotCompleted + customers.ordersCompleted),
          backgroundColor: Colors.grey.shade200,
        ));
  }

  Container _saldo(CustomerSeller customers) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
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
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(customers.ordersCompleted.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: kAppBar)),
                const Text('('),
                const Text('Tiempo de visita:',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: kAppBar)),
                const Text('2h 3m',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: kAppBar)),
                const Text(')')
              ]),
              Text(customers.ordersNotCompleted.toString(),
                  style: const TextStyle(
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

  Container _listOrders(
      BuildContext context, List<ResponseData> responsesCompleted) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: responsesCompleted.length,
        itemBuilder: (context, index) {
          ResponseData response = responsesCompleted[index];
          return Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        response.districtName,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 20, color: kTextColor),
                      ),
                    ],
                  ),
                  const Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: response.results2.length,
                    itemBuilder: (context, index2) {
                      final result = response.results2[index2];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VisitsCustomerInfo(
                                  customer: result.customerId,
                                ),
                              ),
                            );
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(),
                                          Text(
                                            result
                                                .orders[0].order.customer.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: kAppBar,
                                            ),
                                          ),
                                          Text(
                                            result.orders[0].order.customer
                                                .customerAgency.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: kAppBar,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                result.orders[0].order
                                                    .datePayApproximate
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: kGrey500,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              Text(
                                                result.orders[0].order
                                                            .completed ==
                                                        true
                                                    ? "Visitado"
                                                    : "",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: kGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                  const Divider(),
                ],
              ),
              Divider(),
              // Agrega más elementos de la lista aquí según tus necesidades
            ],
          );
        },
      ),
    );
  }

  Container _listOrders2(
      BuildContext context, List<ResponseData> responsesNotCompleted) {
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
