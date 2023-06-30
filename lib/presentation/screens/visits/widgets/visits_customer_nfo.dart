import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendedor/domain/models/response/visit_item.dart';
import 'package:vendedor/domain/services/visit_services.dart';
import 'package:vendedor/presentation/screens/visits/widgets/payments.dart';
import 'package:vendedor/presentation/screens/visits/widgets/timer.dart';

import '../../../../data/themes.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'cart.dart';

class VisitsCustomerInfo extends StatefulWidget {
  int customer;
  bool visited;
  VisitsCustomerInfo({Key? key, required this.customer, required this.visited})
      : super(key: key);

  @override
  State<VisitsCustomerInfo> createState() => _VisitsCustomerInfoState();
}

class _VisitsCustomerInfoState extends State<VisitsCustomerInfo> {
  List<bool> _checkedList = [false, false, false];
  bool documentosCompletar = false;
  bool dni = false;
  bool nombreRepresentante = false;
  bool garantias = false;
  List<String> images = [
    'images/antiguedadDeudau.jpg',
    'images/deudaVencidaPorVenceru.jpg',
    'images/distVentasPorLineau.jpg',
    'images/evolMargenBeneficiou.jpg',
    'images/evolMixVentasu.jpg',
    'images/partVentasUsuariou.jpg',
    'images/promDiasMorosidadu.jpg',
    'images/proyeccionVentasu.jpg',
    'images/tasaCrecimientou.jpg',
    'images/ticketPromediou.jpg',
  ];

  List<String> title = [
    'Antiguedad de la deuda',
    'Deuda vencida vs deuda por vencer',
    'Distribución de ventas por linea',
    'Evolución del margen de beneficio',
    'Evolución del mix',
    'Participación en las ventas de cada cliente',
    'Promedio de dias de morosidad',
    'Proyección de ventas',
    'Tasa de crecimiento',
    'Ticket promedio en los ultimos 6 meses',
  ];

  late CustomerVisit visitCust;
  int val = 0;
  int? customerID;

  void getInfo() async {
    final visit = await visitServices.getVisitCustomerInfo(widget.customer);
    int value = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final customerIDV = prefs.getInt('customerIdVisit');
    if (visit == null) {
      value = 2;
    } else {
      value = 1;
    }
    setState(() {
      customerID = customerIDV;
      visitCust = visit!;
      val = value;
    });
  }

  List<String> tasks = [
    "Dias del carro con productos",
    "Galones por vender",
    "Deuda por cobrar",
    "sdfsdfsdfsdfsdfsdfsf",
  ];
  List<String> tasksMonts = [
    "0",
    "500",
    "S/2500",
    "25",
  ];

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGrey800),
        title: const Text(
          'Plan de visitas',
          style: TextStyle(color: kAppBar, fontSize: 16),
        ),
        actions: [customerID != null ? const TimerVisit() : Container()],
        backgroundColor: kWhite,
        elevation: 0,
      ),
      body: val == 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : val == 2
              ? const Center(
                  child: Text("No se pudo cargar"),
                )
              : Container(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  width: double.infinity,
                  child: ListView(
                    children: [
                      _nameCompany(),
                      const Divider(),
                      _infoUser(),
                      const SizedBox(height: 10),
                      _slider(),
                      const SizedBox(height: 7),
                      _agenda(),
                      const SizedBox(height: 20),
                      _buttonInit(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }

  SizedBox _buttonInit(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48,
      child: ElevatedButton(
        onPressed: widget.visited
            ? null
            : () async {
                if (customerID == null || customerID == widget.customer) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => Cart(
                                customer: widget.customer,
                              ))).then((value) {
                    setState(() {
                      initState();
                    });
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Ya inició una visita con un cliente distinito"),
                      backgroundColor: kError));
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              (customerID == widget.customer) ? kSecondary : kGreen,
        ),
        child: Text(
            (customerID == widget.customer)
                ? 'CONTINUAR VISITA'
                : widget.visited
                    ? 'TERMINADO'
                    : 'INICIAR VISITA',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: kWhite)),
      ),
    );
  }

  String getDays(DateTime date) {
    DateTime today = DateTime.now();
    int days = today.day - date.day;
    return '$days';
  }

  Container _agenda() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 7),
          const Text(
            'Agenda',
            style: TextStyle(fontSize: 16, color: kGrey800),
          ),
          const SizedBox(height: 10),
          // _taskAgenda(),
          const Divider(),
          Column(children: [
            ListTile(
              leading: const Icon(Icons.shopping_cart_checkout_outlined),
              title: const Text('Dias del Carro con productos'),
              trailing: Text(getDays(visitCust.creationDateShoppingCart),
                  style: const TextStyle(fontSize: 24)),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text('Promociones no aprovechadas'),
              trailing: Text('4', style: TextStyle(fontSize: 24)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Galones por vender'),
              trailing: Text(visitCust.achievedSalesGoal.toString(),
                  style: const TextStyle(fontSize: 24)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Deuda por cobrar'),
                  Text('S/${visitCust.dailySalesGoal}',
                      style: const TextStyle(fontSize: 24))
                ],
              ),
              onTap: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentsPage()));*/
              },
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
            ),
            const Divider(),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Documentos por completar'),
                  value: documentosCompletar,
                  onChanged: (bool? value) {
                    setState(() {
                      documentosCompletar = value ?? false;
                      if (documentosCompletar) {
                        dni = true;
                        nombreRepresentante = true;
                        garantias = true;
                      } else {
                        dni = false;
                        nombreRepresentante = false;
                        garantias = false;
                      }
                    });
                    print(value);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text('DNI'),
                        value: dni,
                        onChanged: (bool? value) {
                          setState(() {
                            dni = value ?? false;
                            if (dni && nombreRepresentante && garantias) {
                              documentosCompletar = true;
                            } else {
                              documentosCompletar = false;
                            }
                          });
                          print(value);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text('Nombre de representante'),
                        value: nombreRepresentante,
                        onChanged: (bool? value) {
                          setState(() {
                            nombreRepresentante = value ?? false;
                            if (dni && nombreRepresentante && garantias) {
                              documentosCompletar = true;
                            } else {
                              documentosCompletar = false;
                            }
                          });
                          print(value);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text('Garantias'),
                        value: garantias,
                        onChanged: (bool? value) {
                          setState(() {
                            garantias = value ?? false;
                            if (dni && nombreRepresentante && garantias) {
                              documentosCompletar = true;
                            } else {
                              documentosCompletar = false;
                            }
                          });
                          print(value);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ])
          // Container(
          //   child: ListView.builder(
          //       itemCount: _checkedList.length,
          //       itemBuilder: (context, index) {
          //         return CheckboxListTile(
          //             value: _checkedList[index],
          //             title: Text("Item ${index + 1}"),
          //             onChanged: (value) {
          //               setState(() {
          //                 _checkedList[index] = value!;
          //               });
          //             });
          //       }),
          // )
        ],
      ),
    );
  }

  Row _taskAgenda() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 84,
          width: 104,
          padding: const EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kGrey100,
              border: Border.all(width: 1, color: kGrey400)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getDays(visitCust.creationDateShoppingCart),
                style: const TextStyle(fontSize: 24),
              ),
              const Text('Días del carro con productos',
                  style: TextStyle(fontSize: 12))
            ],
          ),
        ),
        Container(
          height: 84,
          width: 104,
          padding: const EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kGrey100,
              border: Border.all(width: 1, color: kGrey400)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                visitCust.achievedSalesGoal.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              const Text('Galones por vender', style: TextStyle(fontSize: 12))
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PaymentsPage()));
          },
          child: Container(
            height: 84,
            width: 104,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kGrey100,
                border: Border.all(width: 1, color: kGrey400)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'S/${visitCust.dailySalesGoal}',
                  style: const TextStyle(fontSize: 24),
                ),
                const Text('Deuda por cobrar', style: TextStyle(fontSize: 12))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _slider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0, // Ajusta la altura del slider según tus necesidades
            autoPlay: false, // Habilita la reproducción automática
          ),
          items: images.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
        // const Text('Desarrollo del cliente')
      ],
    );
  }

  Container _infoUser() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          visitCust.legalRepresentator.toUpperCase(),
          style: const TextStyle(fontSize: 20, color: kAppBar),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: List<Widget>.generate(visitCust.tags.length, (index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: kGrey200,
                    border: Border.all(width: 1, color: kGrey200),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    visitCust.tags[index].tagName,
                    style: const TextStyle(fontSize: 12, color: kGrey800),
                  ),
                );
              }),
            )),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: kGrey200,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: kGrey400,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_2_outlined,
                      size: 50,
                      color: kGrey400,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    visitCust.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 14, color: kGrey600),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Row _nameCompany() {
    return Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(right: 15),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1.0, color: kGrey200),
            ),
          ),
          child: Column(children: [
            Text(
              visitCust.socialReason,
              style: const TextStyle(fontSize: 20, color: kAppBar),
            ),
            Row(
              children: [
                const Text(
                  'Ultima visita:',
                  style: TextStyle(fontSize: 14, color: kGrey600),
                ),
                const SizedBox(width: 5),
                Text(
                    "${visitCust.lastVisit.day.toString()}/${visitCust.lastVisit.month.toString()}",
                    style: const TextStyle(color: kGrey800)),
                const SizedBox(width: 5),
                Text(
                    "${visitCust.lastVisit.hour.toString()}:${visitCust.lastVisit.minute}",
                    style: const TextStyle(color: kGrey800))
              ],
            )
          ]),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Scoring',
            style: TextStyle(fontSize: 16, color: kGrey600),
          ),
          Text(visitCust.scoring,
              style: const TextStyle(fontSize: 20, color: kGreen)),
        ]),
      ),
    ]);
  }
}
