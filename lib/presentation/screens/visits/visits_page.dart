import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendedor/domain/models/response/customer_seller.dart';
import 'package:vendedor/domain/models/response/history_orders.dart';
import 'package:vendedor/domain/services/customers_services.dart';
import 'package:vendedor/presentation/screens/visits/widgets/timer.dart';
import 'package:vendedor/presentation/screens/visits/widgets/visits_customer_nfo.dart';

import '../../../data/themes.dart';
import '../../../widgets/search_static.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

const String textBarSearch = "Ingresa los datos";

class _VisitsPageState extends State<VisitsPage> {
  int? customerIdVisit;
  void initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final customerIDV = prefs.getInt('customerIdVisit');
    setState(() {
      customerIdVisit = customerIDV;
    });
  }

  String textSearch = "";

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Flexible(
                    child: SearchStatic(
                  text: textBarSearch,
                  onChanged: (search) {
                    setState(() {
                      textSearch = search;
                    });
                  },
                )),
                customerIdVisit != null ? TimerVisit() : Container()
              ],
            )),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
                future: customerServices.getCustomerSeller(),
                builder: (BuildContext context,
                    AsyncSnapshot<CustomerSeller?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Muestra un mensaje de error si ocurre un error
                  } else if (snapshot.hasData) {
                    CustomerSeller? customers = snapshot.data;
                    if (customers != null) {
                      return Column(children: [
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
                          height: MediaQuery.of(context).size.height * 2,
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
                                  _listOrders(context, customers.onRoute),
                                  _listOrders(context, customers.notInRoute)
                                ]))
                              ],
                            ),
                          ),
                        ),
                      ]);
                    }
                    return const Text("No se pudo cargar la data");
                  }
                  return const Text("No se pudo cargar la data");
                })));
  }

  Container _lineCredit(CustomerSeller customers) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: 'Clientes a visitar: ',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: kAppBar)),
            TextSpan(
                text:
                    "${(customers.onRouteQuantityVisited + customers.onRoutePendingVisit)}",
                style: const TextStyle(
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
          value: (customers.onRouteQuantityVisited == 0 &&
                  customers.onRoutePendingVisit == 0)
              ? 0
              : customers.onRouteQuantityVisited /
                  (customers.onRouteQuantityVisited +
                      customers.onRoutePendingVisit),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Visitados',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff525252))),
                  const Text('('),
                  const Icon(Icons.timer_outlined, size: 12, color: kAppBar),
                  Text(customers.timeCompleted,
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: kAppBar)),
                  const Text(')')
                ],
              ),
              const Text('Por visitar',
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
                Text(customers.onRouteQuantityVisited.toString(),
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
                Text(customers.timeCompleted,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: kAppBar)),
                const Text(')')
              ]),
              Text(customers.onRoutePendingVisit.toString(),
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

  Container _listOrders(BuildContext context, responsesCompleted) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: responsesCompleted.length,
        itemBuilder: (context, index) {
          final response = responsesCompleted[index];
          return Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        response["key"],
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 20, color: kTextColor),
                      ),
                    ],
                  ),
                  const Divider(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: response["value"].length,
                    itemBuilder: (context, index2) {
                      final result = response["value"][index2];
                      return result["customer"]["legal_representator"]
                              .contains(textSearch)
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VisitsCustomerInfo(
                                      customer: result["customer"]["id"],
                                      visited: result["visit"]["visited"],
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    initState();
                                  });
                                });
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
                                              const Divider(),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  result["customer"]
                                                      ["legal_representator"],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: kAppBar,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                width: 317,
                                                child: Text(
                                                  result["customer"]["address"],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: kAppBar,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  result["visit"]["visit"]
                                                          .isNotEmpty
                                                      ? Text(
                                                          result["visit"]
                                                                  ["visit"][0][
                                                              "date_programmed"],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: kGrey500,
                                                          ),
                                                        )
                                                      : const Text(""),
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
                                                  Text(
                                                    customerIdVisit ==
                                                            result["customer"]
                                                                ["id"]
                                                        ? "Visitando"
                                                        : result["visit"][
                                                                    "visited"] ==
                                                                true
                                                            ? "Visitado"
                                                            : "",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: customerIdVisit ==
                                                              result["customer"]
                                                                  ["id"]
                                                          ? kSecondary
                                                          : kGreen,
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
                              ))
                          : Container();
                    },
                  ),
                  const Divider(),
                ],
              ),
              const Divider(),
              // Agrega más elementos de la lista aquí según tus necesidades
            ],
          );
        },
      ),
    );
  }
}
