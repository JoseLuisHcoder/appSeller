import 'package:flutter/material.dart';
import 'package:vendedor/domain/models/response/visit_item.dart';
import 'package:vendedor/domain/services/visit_services.dart';
import 'package:vendedor/presentation/screens/visits/widgets/payments.dart';

import '../../../../data/themes.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'cart.dart';

class VisitsCustomerInfo extends StatefulWidget {
  int customer;
  VisitsCustomerInfo({Key? key, required this.customer}) : super(key: key);

  @override
  State<VisitsCustomerInfo> createState() => _VisitsCustomerInfoState();
}

class _VisitsCustomerInfoState extends State<VisitsCustomerInfo> {
  List<bool> _checkedList = [false, false, false];

  List<IconData> icons = [
    Icons.signal_cellular_alt,
    Icons.signal_cellular_alt,
    Icons.signal_cellular_alt,
  ];

  late CustomerVisit visitCust;
  int val = 0;

  void getInfo() async {
    final visit = await visitServices.getVisitCustomerInfo(widget.customer);
    int value = 0;
    if (visit == null) {
      value = 2;
    } else {
      value = 1;
    }
    setState(() {
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
        iconTheme: IconThemeData(color: kGrey800),
        title: const Text(
          'Plan de visitas',
          style: TextStyle(color: kAppBar, fontSize: 16),
        ),
        backgroundColor: kWhite,
        elevation: 0,
      ),
      body: val == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : val == 2
              ? Center(
                  child: Text("No se pudo cargar"),
                )
              : Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  width: double.infinity,
                  child: ListView(
                    children: [
                      _nameCompany(),
                      const Divider(),
                      _infoUser(),
                      SizedBox(height: 10),
                      _slider(),
                      const SizedBox(height: 7),
                      _agenda(),
                      SizedBox(height: 20),
                      _buttonInit(context),
                      SizedBox(height: 20),
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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (contex) => Cart()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kGreen,
        ),
        child: const Text('INICIAR VISITA',
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
          SizedBox(height: 7),
          Text(
            'Agenda',
            style: TextStyle(fontSize: 16, color: kGrey800),
          ),
          SizedBox(height: 10),
          _taskAgenda(),
          Divider(),
          Column(
            children: List.generate(_checkedList.length, (index) {
              return CheckboxListTile(
                value: _checkedList[index],
                title: Row(
                  children: [
                    Expanded(child: Text(tasks[index])),
                    Text(
                      tasksMonts[index],
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _checkedList[index] = value!;
                  });
                },
              );
            }),
          )
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
          padding: EdgeInsets.symmetric(horizontal: 7),
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
                style: TextStyle(fontSize: 24),
              ),
              Text('Días del carro con productos',
                  style: TextStyle(fontSize: 12))
            ],
          ),
        ),
        Container(
          height: 84,
          width: 104,
          padding: EdgeInsets.symmetric(horizontal: 7),
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
                style: TextStyle(fontSize: 24),
              ),
              Text('Galone por vender', style: TextStyle(fontSize: 12))
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentsPage()));
          },
          child: Container(
            height: 84,
            width: 104,
            padding: EdgeInsets.symmetric(horizontal: 7),
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
                  style: TextStyle(fontSize: 24),
                ),
                Text('Deuda por cobrar', style: TextStyle(fontSize: 12))
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
            height: 150.0, // Ajusta la altura del slider según tus necesidades
            autoPlay: false, // Habilita la reproducción automática
          ),
          items: icons.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.signal_cellular_alt,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 7),
        const Text('Desarrollo del cliente')
      ],
    );
  }

  Container _infoUser() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          visitCust.legalRepresentator.toUpperCase(),
          style: TextStyle(fontSize: 20, color: kAppBar),
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
                    style: TextStyle(fontSize: 12, color: kGrey800),
                  ),
                );
              }),
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
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
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    visitCust.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(fontSize: 14, color: kGrey600),
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
          padding: EdgeInsets.only(right: 15),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1.0, color: kGrey200),
            ),
          ),
          child: Column(children: [
            Text(
              visitCust.socialReason,
              style: TextStyle(fontSize: 20, color: kAppBar),
            ),
            Row(
              children: [
                Text(
                  'Ultima visita:',
                  style: TextStyle(fontSize: 14, color: kGrey600),
                ),
                SizedBox(width: 5),
                Text(
                    "${visitCust.lastVisit.day.toString()}/${visitCust.lastVisit.month.toString()}",
                    style: TextStyle(color: kGrey800)),
                SizedBox(width: 5),
                Text(
                    "${visitCust.lastVisit.hour.toString()}:${visitCust.lastVisit.minute}",
                    style: TextStyle(color: kGrey800))
              ],
            )
          ]),
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Scoring',
            style: TextStyle(fontSize: 16, color: kGrey600),
          ),
          Text(visitCust.scoring,
              style: TextStyle(fontSize: 20, color: kGreen)),
        ]),
      ),
    ]);
  }
}
