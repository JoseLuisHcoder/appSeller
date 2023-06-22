import 'package:vendedor/domain/models/response/cart_from_seller.dart';
import 'package:vendedor/domain/models/response/history_orders.dart';

class OrderCustomerSeller {
  int ordersCompleted;
  int ordersNotCompleted;
  List<Response> response;

  OrderCustomerSeller({
    required this.ordersCompleted,
    required this.ordersNotCompleted,
    required this.response,
  });

  factory OrderCustomerSeller.fromJson(Map<String, dynamic> json) {
    return OrderCustomerSeller(
      ordersCompleted: json['orders_completed'],
      ordersNotCompleted: json['orders_not_completed'],
      response: List<Response>.from(
          json['response'].map((x) => Response.fromJson(x))),
    );
  }
}

class Response {
  int ubiGeoId;
  String ubiGeoName;
  List<Results2> results2;

  Response({
    required this.ubiGeoId,
    required this.ubiGeoName,
    required this.results2,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      ubiGeoId: json['ubi_geo_id'],
      ubiGeoName: json['ubi_geo_name'].toString(),
      results2: List<Results2>.from(
          json['results2'].map((x) => Results2.fromJson(x))),
    );
  }
}

class Results2 {
  int customerId;
  String customerName;
  String orderAddress;
  DateTime lastDayVisit;
  bool visited;
  List<OrderElement> orders;

  Results2({
    required this.customerId,
    required this.customerName,
    required this.orderAddress,
    required this.lastDayVisit,
    required this.visited,
    required this.orders,
  });

  factory Results2.fromJson(Map<String, dynamic> json) {
    return Results2(
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      orderAddress: json['order_address'],
      lastDayVisit: DateTime.parse(json['last_day_visit']),
      visited: json['visited'],
      orders: List<OrderElement>.from(
          json['orders'].map((x) => OrderElement.fromJson(x))),
    );
  }
}

class OrderElement {
  OrderOrder order;
  List<Tracking> tracking;
  List<Item> items;

  OrderElement({
    required this.order,
    required this.tracking,
    required this.items,
  });

  factory OrderElement.fromJson(Map<String, dynamic> json) {
    return OrderElement(
      order: OrderOrder.fromJson(json['order']),
      tracking: List<Tracking>.from(
          json['tracking'].map((x) => Tracking.fromJson(x))),
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
    );
  }
}

class DiscountItem {
  int id;
  int percentagePriceDiscount;

  DiscountItem({
    required this.id,
    required this.percentagePriceDiscount,
  });

  factory DiscountItem.fromJson(Map<String, dynamic> json) {
    return DiscountItem(
      id: json['id'],
      percentagePriceDiscount: json['percentage_price_discount'],
    );
  }
}

class GiftItemElement {
  int id;
  GiftItemGiftItem giftItem;
  int quantityProductGift;

  GiftItemElement({
    required this.id,
    required this.giftItem,
    required this.quantityProductGift,
  });

  factory GiftItemElement.fromJson(Map<String, dynamic> json) {
    return GiftItemElement(
      id: json['id'],
      giftItem: GiftItemGiftItem.fromJson(json['gift_item']),
      quantityProductGift: json['quantity_product_gift'],
    );
  }
}

class GiftItemGiftItem {
  int id;
  String name;
  int stock;

  GiftItemGiftItem({
    required this.id,
    required this.name,
    required this.stock,
  });

  factory GiftItemGiftItem.fromJson(Map<String, dynamic> json) {
    return GiftItemGiftItem(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
    );
  }
}

class OrderOrder {
  int id;
  Seller seller;
  Customer customer;
  DateTime dateCreated;
  DateTime dateDeliveryApproximate;
  DateTime datePayApproximate;
  DateTime lastDateVisit;
  bool visited;
  bool completed;
  bool onRoute;
  int finalPrice;
  List<Item> orderCustomerItems;

  OrderOrder({
    required this.id,
    required this.seller,
    required this.customer,
    required this.dateCreated,
    required this.dateDeliveryApproximate,
    required this.datePayApproximate,
    required this.lastDateVisit,
    required this.visited,
    required this.completed,
    required this.onRoute,
    required this.finalPrice,
    required this.orderCustomerItems,
  });

  factory OrderOrder.fromJson(Map<String, dynamic> json) {
    return OrderOrder(
      id: json['id'],
      seller: Seller.fromJson(json['seller']),
      customer: Customer.fromJson(json['customer']),
      dateCreated: DateTime.parse(json['date_created']),
      dateDeliveryApproximate:
          DateTime.parse(json['date_delivery_approximate']),
      datePayApproximate: DateTime.parse(json['date_pay_approximate']),
      lastDateVisit: DateTime.parse(json['last_date_visit']),
      visited: json['visited'],
      completed: json['completed'],
      onRoute: json['on_route'],
      finalPrice: json['final_price'],
      orderCustomerItems: List<Item>.from(
          json['orderCustomerItems'].map((x) => Item.fromJson(x))),
    );
  }
}

class Customer {
  int id;
  Seller seller;
  String identification;
  String legalRepresentator;
  String socialReason;
  String? phone;
  dynamic birthday;
  String address;
  bool state;
  int isCredit;
  int paymentDeadline;
  int? totalCreditLine;
  int ubiGeoId;
  CustomerType customerType;
  CustomerCurrencyType customerCurrencyType;
  CustomerAgency customerAgency;
  CustomerAgency customerPriceList;
  CustomerUbigeo customerUbigeo;

  Customer({
    required this.id,
    required this.seller,
    required this.identification,
    required this.legalRepresentator,
    required this.socialReason,
    this.phone,
    this.birthday,
    required this.address,
    required this.state,
    required this.isCredit,
    required this.paymentDeadline,
    this.totalCreditLine,
    required this.ubiGeoId,
    required this.customerType,
    required this.customerCurrencyType,
    required this.customerAgency,
    required this.customerPriceList,
    required this.customerUbigeo,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      seller: Seller.fromJson(json['seller']),
      identification: json['identification'],
      legalRepresentator: json['legal_representator'],
      socialReason: json['social_reason'],
      phone: json['phone'],
      birthday: json['birthday'],
      address: json['address'],
      state: json['state'],
      isCredit: json['is_credit'],
      paymentDeadline: json['payment_deadline'],
      totalCreditLine: json['total_credit_line'],
      ubiGeoId: json['ubi_geo_id'],
      customerType: CustomerType.fromJson(json['customer_type']),
      customerCurrencyType:
          CustomerCurrencyType.fromJson(json['customer_currency_type']),
      customerAgency: CustomerAgency.fromJson(json['customer_agency']),
      customerPriceList: CustomerAgency.fromJson(json['customer_price_list']),
      customerUbigeo: CustomerUbigeo.fromJson(json['customer_ubigeo']),
    );
  }
}

class CustomerAgency {
  int id;
  String name;

  CustomerAgency({
    required this.id,
    required this.name,
  });

  factory CustomerAgency.fromJson(Map<String, dynamic> json) {
    return CustomerAgency(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CustomerCurrencyType {
  int id;
  String name;

  CustomerCurrencyType({
    required this.id,
    required this.name,
  });

  factory CustomerCurrencyType.fromJson(Map<String, dynamic> json) {
    return CustomerCurrencyType(
      id: json['id'],
      name: json['iso_code'],
    );
  }
}

class CustomerName {
  int id;
  String firstName;
  String lastName;

  CustomerName({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory CustomerName.fromJson(Map<String, dynamic> json) {
    return CustomerName(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

class CustomerType {
  int id;
  String name;

  CustomerType({
    required this.id,
    required this.name,
  });

  factory CustomerType.fromJson(Map<String, dynamic> json) {
    return CustomerType(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CustomerUbigeo {
  int id;
  String name;

  CustomerUbigeo({
    required this.id,
    required this.name,
  });

  factory CustomerUbigeo.fromJson(Map<String, dynamic> json) {
    return CustomerUbigeo(
      id: json['id'],
      name: json['u_geo_nombre'],
    );
  }
}

class Address {
  int id;
  String name;
  String address;
  String reference;

  Address({
    required this.id,
    required this.name,
    required this.address,
    required this.reference,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      reference: json['reference'],
    );
  }
}

class Seller {
  int id;
  String sellerName;
  String? phone;
  bool? state;

  Seller({
    required this.id,
    required this.sellerName,
    this.phone,
    this.state,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      sellerName: json['name'],
      phone: json['phone'],
      state: json['state'],
    );
  }
}

class SellerCode {
  int id;
  String name;

  SellerCode({
    required this.id,
    required this.name,
  });

  factory SellerCode.fromJson(Map<String, dynamic> json) {
    return SellerCode(
      id: json['id'],
      name: json['name'],
    );
  }
}

class SellerName {
  int id;
  String firstName;
  String lastName;

  SellerName({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory SellerName.fromJson(Map<String, dynamic> json) {
    return SellerName(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

class SocialReason {
  int id;
  String name;

  SocialReason({
    required this.id,
    required this.name,
  });

  factory SocialReason.fromJson(Map<String, dynamic> json) {
    return SocialReason(
      id: json['id'],
      name: json['name'],
    );
  }
}

class UbiGeoName {
  int id;
  String name;
  UbiGeo ubiGeo;

  UbiGeoName({
    required this.id,
    required this.name,
    required this.ubiGeo,
  });

  factory UbiGeoName.fromJson(Map<String, dynamic> json) {
    return UbiGeoName(
      id: json['id'],
      name: json['name'],
      ubiGeo: UbiGeo.fromJson(json['ubi_geo']),
    );
  }
}

class UbiGeo {
  int id;
  String name;
  UbiGeoType ubiGeoType;

  UbiGeo({
    required this.id,
    required this.name,
    required this.ubiGeoType,
  });

  factory UbiGeo.fromJson(Map<String, dynamic> json) {
    return UbiGeo(
      id: json['id'],
      name: json['name'],
      ubiGeoType: UbiGeoType.fromJson(json['ubi_geo_type']),
    );
  }
}

class UbiGeoType {
  int id;
  String name;

  UbiGeoType({
    required this.id,
    required this.name,
  });

  factory UbiGeoType.fromJson(Map<String, dynamic> json) {
    return UbiGeoType(
      id: json['id'],
      name: json['name'],
    );
  }
}

class OrderPaymentHistory {
  int id;
  int amountPaid;
  DateTime paymentDate;
  PaymentMethod paymentMethod;
  String reference;

  OrderPaymentHistory({
    required this.id,
    required this.amountPaid,
    required this.paymentDate,
    required this.paymentMethod,
    required this.reference,
  });

  factory OrderPaymentHistory.fromJson(Map<String, dynamic> json) {
    return OrderPaymentHistory(
      id: json['id'],
      amountPaid: json['amount_paid'],
      paymentDate: DateTime.parse(json['payment_date']),
      paymentMethod: PaymentMethod.fromJson(json['payment_method']),
      reference: json['reference'],
    );
  }
}

class PaymentMethod {
  int id;
  String name;

  PaymentMethod({
    required this.id,
    required this.name,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
    );
  }
}
