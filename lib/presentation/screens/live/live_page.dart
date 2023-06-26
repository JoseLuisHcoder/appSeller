import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/cart_from_seller.dart';
import 'package:vendedor/domain/models/response/history_orders.dart';
import 'package:vendedor/domain/models/response/order_customer_seller.dart';
import 'package:vendedor/domain/services/cart_services.dart';
import 'package:vendedor/domain/services/order_services.dart';
import 'package:vendedor/presentation/screens/visits/widgets/timer.dart';

import '../../../data/themes.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [const TimerVisit()],
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Datos en vivo',
            style: TextStyle(color: kGrey800),
          )),
      body: SingleChildScrollView(
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
      height: 1000,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
                labelColor: kBlue,
                unselectedLabelColor: kTextColor,
                indicatorColor: kBlue,
                tabs: [
                  Tab(text: 'Pedidos en linea'),
                  Tab(
                    text: 'Pagos en linea',
                  )
                ]),
            Expanded(
                child: TabBarView(children: [
              FutureBuilder(
                future: cartServices.getCartBySeller(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    if (snapshot.data != null) {
                      CartSeller cartSeller = snapshot.data!;
                      return _buildOrderList(cartSeller);
                    }

                    return const Text("");
                  }
                },
              ),
              FutureBuilder(
                future: cartServices.getOrderCustomerBySeller(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    if (snapshot.data != null) {
                      OrderCustomerSeller orderSeller = snapshot.data!;
                      return _buildPaymentList(orderSeller);
                    }
                    return const Text("");
                  }
                },
              ),
            ]))
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Productos en carrito',
                          // historyOrder.id.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        Row(children: [
                          Text(
                            '05 Jun - ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kGrey400),

                            // 'Venció el ${_formatDate(format.parse(historyOrder.dueDate))}',
                          ),
                          Text(
                            'RC001-000660',
                            style: TextStyle(
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
            const Text(
              '5',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: TextStyle(fontSize: 24, color: kGrey800),
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Productos en promocion',
                          // historyOrder.id.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        Text(
                          '05 Jun',
                          // 'Venció el ${_formatDate(format.parse(historyOrder.dueDate))}',
                          style: TextStyle(color: kGrey600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Text(
              '7',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: TextStyle(fontSize: 24, color: kGrey900),
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
                          child: const Text(
                            'Linea de credito',

                            // historyOrder.id.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
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
            const Text(
              'S/15000',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: TextStyle(fontSize: 24, color: kGrey800),
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
                          child: const Text(
                            'Promociones no aprovechadas',

                            // historyOrder.id.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
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
            const Text(
              '15',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: TextStyle(fontSize: 24, color: kGrey800),
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
                          child: const Text(
                            'Saldo en linea de credito',

                            // historyOrder.id.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
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
            const Text(
              'S/7800',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: TextStyle(fontSize: 24, color: kGrey800),
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Productos devueltos',
                          // historyOrder.id.toString(),
                          style: TextStyle(
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
            const Text(
              '3',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: TextStyle(fontSize: 24, color: kGrey800),
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Productos cancelados',
                          // historyOrder.id.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                        Row(children: [
                          Text(
                            '05 Jun - ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kGrey400),

                            // 'Venció el ${_formatDate(format.parse(historyOrder.dueDate))}',
                          ),
                          Text(
                            'RC001-000660',
                            style: TextStyle(
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
            const Text(
              '2',
              //'S/ ${_calculateTotalAmount(orderWidgets)}',
              // 'S/ ${historyOrder.partialAmount}',
              style: TextStyle(fontSize: 24, color: kGrey800),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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

  Widget _buildOrderList(CartSeller cartSeller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cartSeller.response.length,
        itemBuilder: (context, index) {
          final response = cartSeller.response[index];
          return Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        response.ubiGeoName,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: response.results2.length,
                    itemBuilder: (context, index2) {
                      double totalPrice = 0.0;
                      final result = response.results2[index2];
                      for (final item in result.shoppingCart) {
                        for (final shoppingCartItem in item.shoppingCartItems) {
                          totalPrice += shoppingCartItem.promotionalTotalPrice;
                        }
                      }
                      return GestureDetector(
                        onTap: () {},
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
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        Container(
                                          width: 200,
                                          child: Text(
                                            result.customerName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("S/.${totalPrice.toStringAsFixed(2)}")
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPaymentList(OrderCustomerSeller cartSeller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cartSeller.response.length,
        itemBuilder: (context, index) {
          final response = cartSeller.response[index];
          return Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        response.ubiGeoName,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: response.results2.length != 0 ? 1 : 0,
                    itemBuilder: (context, index2) {
                      double totalPrice = 0.0;
                      final result = response.results2[index2];
                      for (final item in result.orders) {
                        totalPrice += (item.order.finalPrice >= 0
                            ? item.order.finalPrice
                            : 0);
                      }

                      return GestureDetector(
                        onTap: () {},
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
                                    width: MediaQuery.of(context).size.width *
                                        0.58,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        Container(
                                          width: 200,
                                          child: Text(
                                            result.customerName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("S/.${totalPrice.toStringAsFixed(2)}")
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
