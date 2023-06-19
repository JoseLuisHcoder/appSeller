import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/history_orders.dart';
import 'package:vendedor/domain/services/order_services.dart';

import '../../../data/themes.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  List<HistoryOrder> payments = [];
  List<OrderPaymentHistory> orderWidgets = [];
  List<OrderPaymentHistory> orderWidgets2 = [];
  List<OrderPaymentHistory> orderWidgets3 = [];
  OrderPaymentHistory? nextPay;
  int tabHeight = 0;
  double sum = 0;

  DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ss");
  List<_SalesData> data = [
    _SalesData('Enero', 0),
    _SalesData('Febrero', 0),
    _SalesData('Marzo', 0),
    _SalesData('Abril', 0),
    _SalesData('Mayo', 0),
    _SalesData('Junio', 0),
    _SalesData('Julio', 0),
    _SalesData('Agosto', 0),
    _SalesData('Septiembre', 0),
    _SalesData('Octubre', 0),
    _SalesData('Noviembre', 0),
    _SalesData('Diciembre', 0)
  ];
  Future<void> chargeOrders() async {
    var idCustomer = "93";
    var temp =
        await orderServices.getOrdersByCustomer(int.parse(idCustomer!)) ?? [];

    double sumPartialAmount = temp.fold(0, (sum, historyOrder) {
      return sum +
          historyOrder.order.orderPaymentHistory
              .map((payment) => payment.partialAmount)
              .fold(0, (partialSum, amount) => partialSum + amount);
    });

    temp.sort((a, b) => b.order.id.compareTo(a.order.id));

    List<OrderPaymentHistory> orderWidgetsTemp = [];
    List<OrderPaymentHistory> orderWidgetsComplete = [];
    List<OrderPaymentHistory> orderWidgetsTemp2 = [];

    DateTime? nextDueDate;

    for (var historyOrder in temp) {
      for (var payment in historyOrder.order.orderPaymentHistory) {
        DateTime dueDate = format.parse(payment.dueDate);

        data[dueDate.month - 1].sales =
            data[dueDate.month - 1].sales + payment.partialAmount;

        if (!payment.paymentCompleted) {
          if (nextDueDate == null || dueDate.isBefore(nextDueDate)) {
            nextDueDate = dueDate;
            nextPay = payment;
          }
          if (dueDate.isBefore(DateTime.now())) {
            orderWidgetsTemp.add(payment);
          } else {
            orderWidgetsTemp2.add(payment);
          }
        } else {
          orderWidgetsComplete.add(payment);
        }
      }
    }

    for (var historyOrder in temp) {
      for (var payment in historyOrder.order.orderPaymentHistory) {
        DateTime dueDate = format.parse(payment.dueDate);
        bool temp =
            dueDate.isAfter(DateTime.now()) && !payment.paymentCompleted;
        if (temp) {}
      }
    }

    setState(() {
      payments = temp;
      orderWidgets = orderWidgetsTemp;
      orderWidgets2 = orderWidgetsTemp2;
      orderWidgets3 = orderWidgetsComplete;
      tabHeight = orderWidgets.length;

      sum = sumPartialAmount;
    });
  }

  @override
  initState() {
    chargeOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Datos en vivo',
            style: TextStyle(color: kGrey800),
          )),
      body: payments.isEmpty == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _statusDebt(context),
                ],
              ),
            ),
    );
  }

  Container _statusDebt(BuildContext context) {
    return Container(
      height: (tabHeight * 69) + 75,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                onTap: (value) {
                  setState(() {
                    if (value == 1) {
                      tabHeight = orderWidgets2.length;
                    } else {
                      tabHeight = orderWidgets.length;
                    }
                  });
                },
                labelColor: kBlue,
                unselectedLabelColor: kTextColor,
                indicatorColor: kBlue,
                tabs: const [
                  Tab(text: 'Pedidos en linea'),
                  Tab(
                    text: 'Pagos en linea',
                  )
                ]),
            Expanded(
                child: TabBarView(
                    children: [_listOrders(context), _listOrders2(context)]))
          ],
        ),
      ),
    );
  }

  // Container _movements(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     child: Expanded(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                   width: 205,
  //                   padding: EdgeInsets.symmetric(vertical: 7),
  //                   decoration: BoxDecoration(
  //                     border:
  //                         Border(bottom: BorderSide(color: kBlue, width: 2)),
  //                   ),
  //                   child: Text('DATOS UTILES')),
  //             ],
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(height: 15),
  //               _ordersMoviments(context),
  //               _ordersMoviments4(context),
  //               _ordersMoviments1(context),
  //               _ordersMoviments2(context),
  //               _ordersMoviments3(context),
  //               _ordersMoviments6(context),
  //               _ordersMoviments5(context)
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _ordersMoviments1(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Icon(
              Icons.credit_card,
              color: kGrey600,
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
                          'Productos en carrito',
                          // historyOrder.id.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        Row(children: [
                          Text(
                            '05 Jun - ',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kGrey400),

                            // 'Venció el ${_formatDate(format.parse(historyOrder.dueDate))}',
                          ),
                          Text(
                            'RC001-000660',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kGrey400),
                          )
                        ])
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              '5',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: const TextStyle(fontSize: 24, color: kGrey800),
            )
          ],
        ),
      ],
    );
  }

  Widget _ordersMoviments(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Icon(
              Icons.description_outlined,
              color: kGrey600,
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
                          'Productos en promocion',
                          // historyOrder.id.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        Text(
                          '05 Jun',
                          // 'Venció el ${_formatDate(format.parse(historyOrder.dueDate))}',
                          style: const TextStyle(color: kGrey600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              '7',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: const TextStyle(fontSize: 24, color: kGrey900),
            )
          ],
        ),
      ],
    );
  }

  Widget _ordersMoviments6(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Icon(
              Icons.credit_card,
              color: kGrey600,
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
                        Container(
                          child: Text(
                            'Linea de credito',

                            // historyOrder.id.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              'S/15000',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: const TextStyle(fontSize: 24, color: kGrey800),
            )
          ],
        ),
      ],
    );
  }

  Widget _ordersMoviments4(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Icon(
              Icons.credit_card,
              color: kGrey600,
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
                        Container(
                          child: Text(
                            'Promociones no aprovechadas',

                            // historyOrder.id.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              '15',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: const TextStyle(fontSize: 24, color: kGrey800),
            )
          ],
        ),
      ],
    );
  }

  Widget _ordersMoviments5(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Icon(
              Icons.credit_card,
              color: kGrey600,
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
                        Container(
                          child: Text(
                            'Saldo en linea de credito',

                            // historyOrder.id.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              'S/7800',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: const TextStyle(fontSize: 24, color: kGrey800),
            )
          ],
        ),
      ],
    );
  }

  Widget _ordersMoviments2(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Icon(
              Icons.credit_card,
              color: kGrey600,
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
                          'Productos devueltos',
                          // historyOrder.id.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              '3',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: const TextStyle(fontSize: 24, color: kGrey800),
            )
          ],
        ),
      ],
    );
  }

  Widget _ordersMoviments3(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Icon(
              Icons.credit_card,
              color: kGrey600,
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
                          'Productos cancelados',
                          // historyOrder.id.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        Row(children: [
                          Text(
                            '05 Jun - ',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kGrey400),

                            // 'Venció el ${_formatDate(format.parse(historyOrder.dueDate))}',
                          ),
                          Text(
                            'RC001-000660',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kGrey400),
                          )
                        ])
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              '2',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: const TextStyle(fontSize: 24, color: kGrey800),
            )
          ],
        ),
      ],
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

  Widget _listOrders(BuildContext context) {
    List<Widget> widgets = orderWidgets.map((historyOrder) {
      return Column(
        children: [
          const Divider(),
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: kGrey600,
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
                            historyOrder.id.toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kTextColor),
                          ),
                          Text(
                            'Venció el ${_formatDate(format.parse(historyOrder.dueDate))}',
                            style: const TextStyle(color: kSecondary),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                //'S/ ${_calculateTotalAmount(orderWidgets)}',
                'S/ ${historyOrder.partialAmount}',
                style: const TextStyle(fontSize: 20, color: kGrey900),
              )
            ],
          ),
        ],
      );
    }).toList();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Column(
        children: widgets,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
  }

  String _formatDateNames(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} de ${_getMonthName(date.month)}';
  }

  double _calculateTotalAmount(List<OrderPaymentHistory> payments) {
    double temp =
        payments.fold(0, (sum, payment) => sum + payment.partialAmount);
    return double.parse(temp.toStringAsFixed(2));
  }

  Container _listOrders2(BuildContext context) {
    List<Widget> widgets = orderWidgets2.map((historyOrder) {
      return Column(
        children: [
          const Divider(),
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: kGrey600,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            historyOrder.id.toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kTextColor),
                          ),
                          Text(
                            'Vence el ${_formatDate(format.parse(historyOrder.dueDate))}',
                            style: const TextStyle(color: kBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
//'S/ ${_calculateTotalAmount(orderWidgets2)}',
                'S/ ${historyOrder.partialAmount}',
                style: const TextStyle(fontSize: 20, color: kGrey900),
              )
            ],
          ),
        ],
      );
    }).toList();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Column(
        children: widgets,
      ),
    );
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return monthNames[month - 1];
  }
}

class _SalesData {
  _SalesData(this.month, this.sales);

  final String month;
  double sales;
}
