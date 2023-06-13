import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/data/themes.dart';
import 'package:vendedor/domain/models/response/history_orders.dart';
import 'package:vendedor/domain/services/order_services.dart';
import 'package:vendedor/widgets/qr_scanner.dart';
import 'package:vendedor/widgets/search_static.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  String stringQr = "";
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
    var idCustomer = await secureStorage.readToken();
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
          backgroundColor: appBarBackgroundColor,
          title: Text('Cuentas por cobrar')
          // Row(
          //   children: [
          //     const Flexible(
          //         child: SearchStatic(
          //       textSearch: 'Buscar factura',
          //     )),
          //     IconButton(
          //         color: kTextColor,
          //         onPressed: () async {
          //           Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => QRViewExample(
          //               onQrScan: (String code) {},
          //             ),
          //           ));
          //           //var result = await BarcodeScanner.scan();
          //           //setState(() {
          //           //  stringQr = result.rawContent;
          //           //});
          //         },
          //         icon: const Icon(Icons.qr_code))
          //   ],
          // )
          ),
      body: payments.isEmpty == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text(stringQr),
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
                  // TODO: Overflow en lista
                  _statusDebt(context),
                  _movements(context),
                  // todo: drop space
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15),
                  //   child: Column(
                  //     children: [
                  //       const Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: Text(
                  //           'Movimientos',
                  //           style: TextStyle(
                  //               fontSize: 18, fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //       _listMovements(context),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }

  Container _movements(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    width: 205,
                    padding: EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: kBlue, width: 2)),
                    ),
                    child: Text('MOVIMIENTOS')),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text('Jumio 2023'),
                _ordersMoviments(context),
                _ordersMoviments1(context)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text('Mayo 2023'),
                _ordersMoviments(context),
                _ordersMoviments1(context)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text('Abril 2023'),
                _ordersMoviments(context),
                _ordersMoviments1(context)
              ],
            )
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
                  Tab(text: 'Deuda vencida'),
                  Tab(
                    text: 'Deuda por vencer',
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

  Container _imageCenter(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: kGrey200, borderRadius: BorderRadius.circular(10)),
                height: 320,
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  //Initialize the chart widget
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      // Enable legend
                      legend: Legend(isVisible: false),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_SalesData, String>>[
                        LineSeries<_SalesData, String>(
                            dataSource: data,
                            xValueMapper: (_SalesData sales, _) => sales.month,
                            yValueMapper: (_SalesData sales, _) => sales.sales,
                            name: 'Sales',
                            isVisibleInLegend: false,
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ]),
                ])),
            const SizedBox(
              height: 4,
            ),
            const Text('Antigüedad de la deuda'),
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
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'Próximo pago: ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: kTextColor)),
                TextSpan(
                    text: _formatDateNames(format.parse(nextPay!.dueDate)),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: kTextColor)),
              ])),
              Text('S/ ${nextPay?.partialAmount}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kTextColor))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Saldo pendiente',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: kTextColor)),
              Text('S/ 1250.00',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: kTextColor)),
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
              text: TextSpan(children: [
            const TextSpan(
                text: 'Linea de crédito: ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: kTextColor)),
            TextSpan(
                text:
                    'S/ ${payments[0].order.customer.customerPayment?.creditLine}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kTextColor)),
          ])),
          const Icon(
            Icons.warning_rounded,
            color: kSecondary,
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
          color: kBlue,
          value: sum / payments[0].order.customer.customerPayment!.creditLine,
          backgroundColor: kGrey200,
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Consumido',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: kTextColor)),
              Text('Disponible',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: kTextColor)),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('S/ ${sum.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kTextColor)),
              Text(
                  'S/ ${(payments[0].order.customer.customerPayment!.creditLine - sum).toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kTextColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ordersMoviments1(BuildContext context) {
    List<Widget> widgets = orderWidgets.map((historyOrder) {
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
                            'F001-000526',
                            // historyOrder.id.toString(),
                            style: const TextStyle(
                                fontSize: 14,
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
                'S/ -450',
                //'S/ ${_calculateTotalAmount(orderWidgets)}',
                // 'S/ ${historyOrder.partialAmount}',
                style: const TextStyle(fontSize: 20, color: kSecondary),
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

  Widget _ordersMoviments(BuildContext context) {
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
                            'F001-000535',
                            // historyOrder.id.toString(),
                            style: const TextStyle(
                                fontSize: 14,
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
                'S/ 250',
                //'S/ ${_calculateTotalAmount(orderWidgets)}',
                // 'S/ ${historyOrder.partialAmount}',
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

  Container _listMovements(BuildContext context) {
    List<Widget> movementWidgets = orderWidgets3.map((historyOrder) {
      return Column(
        children: [
          const Divider(),
          const Text(
            'Mayo 2023',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: kTextColor),
          ),
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
                            _formatDate(format.parse(historyOrder.dueDate)),
                            style: const TextStyle(color: kTextColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                //'S/ ${_calculateTotalAmount(historyOrder.order.orderPaymentHistory)}',
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
        children: movementWidgets,
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.month, this.sales);

  final String month;
  double sales;
}
