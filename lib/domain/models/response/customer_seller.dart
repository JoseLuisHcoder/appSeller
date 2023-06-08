import 'package:vendedor/domain/models/response/history_orders.dart';

class CustomerSeller {
  final int ordersCompleted;
  final int ordersNotCompleted;
  final List<ResponseData> response;

  CustomerSeller({
    required this.ordersCompleted,
    required this.ordersNotCompleted,
    required this.response,
  });

  factory CustomerSeller.fromJson(Map<String, dynamic> json) {
    return CustomerSeller(
      ordersCompleted: json['orders_completed'],
      ordersNotCompleted: json['orders_not_completed'],
      response: List<ResponseData>.from(
        json['response'].map((data) => ResponseData.fromJson(data)),
      ),
    );
  }
}

class ResponseData {
  final int districtId;
  final String districtName;
  final List<CustomerData> results2;

  ResponseData({
    required this.districtId,
    required this.districtName,
    required this.results2,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      districtId: json['district_id'],
      districtName: json['district_name'],
      results2: List<CustomerData>.from(
        json['results2'].map((data) => CustomerData.fromJson(data)),
      ),
    );
  }
}

class CustomerData {
  final int customerId;
  final List<HistoryOrder> orders;

  CustomerData({
    required this.customerId,
    required this.orders,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      customerId: json['customer_id'],
      orders: List<HistoryOrder>.from(
        json['orders'].map((data) => HistoryOrder.fromJson(data)),
      ),
    );
  }
}

class OrderData {
  final int id;
  final SellerData seller;
  final CustomerData2 customer;
  final String dateCreated;
  final String dateDeliveryApproximate;
  final String datePayApproximate;
  final bool completed;
  final List<OrderPaymentHistory> orderPaymentHistory;
  final List<Tracking> tracking;
  final List<Item> items;

  OrderData({
    required this.id,
    required this.seller,
    required this.customer,
    required this.dateCreated,
    required this.dateDeliveryApproximate,
    required this.datePayApproximate,
    required this.completed,
    required this.orderPaymentHistory,
    required this.tracking,
    required this.items,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      seller: SellerData.fromJson(json['seller']),
      customer: CustomerData2.fromJson(json['customer']),
      dateCreated: json['date_created'],
      dateDeliveryApproximate: json['date_delivery_approximate'],
      datePayApproximate: json['date_pay_approximate'],
      completed: json['completed'],
      orderPaymentHistory: List<OrderPaymentHistory>.from(
        json['orderPaymentHistory']
            .map((data) => OrderPaymentHistory.fromJson(data)),
      ),
      tracking: List<Tracking>.from(
        json['tracking'].map((data) => Tracking.fromJson(data)),
      ),
      items: List<Item>.from(
        json['items'].map((data) => Item.fromJson(data)),
      ),
    );
  }
}

class SellerData {
  final int id;
  final String name;

  SellerData({
    required this.id,
    required this.name,
  });

  factory SellerData.fromJson(Map<String, dynamic> json) {
    return SellerData(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CustomerData2 {
  final int id;
  final String name;

  CustomerData2({
    required this.id,
    required this.name,
  });

  factory CustomerData2.fromJson(Map<String, dynamic> json) {
    return CustomerData2(
      id: json['id'],
      name: json['name'],
    );
  }
}
