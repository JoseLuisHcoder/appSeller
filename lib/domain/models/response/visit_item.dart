class CustomerVisit {
  int id;
  CustomerItem customerItem;
  String name;
  String businessName;
  DateTime lastVisit;
  String scoring;
  List<Tag> tags;
  String description;
  List<Order> orders;
  DateTime creationDateShoppingCart;
  int dailySalesGoal;
  int achievedSalesGoal;

  CustomerVisit({
    required this.id,
    required this.customerItem,
    required this.name,
    required this.businessName,
    required this.lastVisit,
    required this.scoring,
    required this.tags,
    required this.description,
    required this.orders,
    required this.creationDateShoppingCart,
    required this.dailySalesGoal,
    required this.achievedSalesGoal,
  });

  factory CustomerVisit.fromJson(Map<String, dynamic> json) {
    return CustomerVisit(
      id: json['id'],
      customerItem: CustomerItem.fromJson(json['customerItem']),
      name: json['name'],
      businessName: json['business_name'],
      lastVisit: DateTime.parse(json['last_visit']),
      scoring: json['scoring'],
      tags: List<Tag>.from(json['tags'].map((x) => Tag.fromJson(x))),
      description: json['description'],
      orders: List<Order>.from(json['orders'].map((x) => Order.fromJson(x))),
      creationDateShoppingCart:
          DateTime.parse(json['creation_date_shoppingcart']),
      dailySalesGoal: json['daily_sales__goal'],
      achievedSalesGoal: json['achieved_sales_goal'],
    );
  }
}

class CustomerItem {
  int id;
  String name;
  String lastName;
  String phone;
  String email;
  bool state;
  CustomerType customerType;
  CustomerCountry customerCountry;
  CustomerIdentification customerIdentification;
  CustomerAgency customerAgency;
  CustomerPriceList customerPriceList;
  CustomerPayment customerPayment;

  CustomerItem({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.state,
    required this.customerType,
    required this.customerCountry,
    required this.customerIdentification,
    required this.customerAgency,
    required this.customerPriceList,
    required this.customerPayment,
  });

  factory CustomerItem.fromJson(Map<String, dynamic> json) {
    return CustomerItem(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      state: json['state'],
      customerType: CustomerType.fromJson(json['customer_type']),
      customerCountry: CustomerCountry.fromJson(json['customer_country']),
      customerIdentification:
          CustomerIdentification.fromJson(json['customer_identification']),
      customerAgency: CustomerAgency.fromJson(json['customer_agency']),
      customerPriceList: CustomerPriceList.fromJson(json['customer_pricelist']),
      customerPayment: CustomerPayment.fromJson(json['customerPayment']),
    );
  }
}

class CustomerType {
  int id;
  String name;
  String description;
  int minMonthlySpent;

  CustomerType({
    required this.id,
    required this.name,
    required this.description,
    required this.minMonthlySpent,
  });

  factory CustomerType.fromJson(Map<String, dynamic> json) {
    return CustomerType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      minMonthlySpent: json['min_monthly_spent'],
    );
  }
}

class CustomerCountry {
  int id;
  String name;

  CustomerCountry({
    required this.id,
    required this.name,
  });

  factory CustomerCountry.fromJson(Map<String, dynamic> json) {
    return CustomerCountry(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CustomerIdentification {
  int id;
  String identificationNumber;

  CustomerIdentification({
    required this.id,
    required this.identificationNumber,
  });

  factory CustomerIdentification.fromJson(Map<String, dynamic> json) {
    return CustomerIdentification(
      id: json['id'],
      identificationNumber: json['identification_number'],
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

class CustomerPriceList {
  int id;
  String name;

  CustomerPriceList({
    required this.id,
    required this.name,
  });

  factory CustomerPriceList.fromJson(Map<String, dynamic> json) {
    return CustomerPriceList(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CustomerPayment {
  int id;
  CurrencyType currencyType;
  int creditLine;

  CustomerPayment({
    required this.id,
    required this.currencyType,
    required this.creditLine,
  });

  factory CustomerPayment.fromJson(Map<String, dynamic> json) {
    return CustomerPayment(
      id: json['id'],
      currencyType: CurrencyType.fromJson(json['currencyType']),
      creditLine: json['credit_line'],
    );
  }
}

class CurrencyType {
  int id;
  CustomerCountry country;
  String currencySymbol;
  String isoCode;

  CurrencyType({
    required this.id,
    required this.country,
    required this.currencySymbol,
    required this.isoCode,
  });

  factory CurrencyType.fromJson(Map<String, dynamic> json) {
    return CurrencyType(
      id: json['id'],
      country: CustomerCountry.fromJson(json['country']),
      currencySymbol: json['currency_simbol'],
      isoCode: json['iso_code'],
    );
  }
}

class Tag {
  int id;
  String tagName;

  Tag({
    required this.id,
    required this.tagName,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      tagName: json['tag_name'],
    );
  }
}

class Order {
  int id;
  Seller seller;
  CustomerItem customer;
  DateTime dateCreated;
  DateTime dateDeliveryApproximate;
  DateTime datePayApproximate;
  bool completed;
  List<OrderPaymentHistory> orderPaymentHistory;

  Order({
    required this.id,
    required this.seller,
    required this.customer,
    required this.dateCreated,
    required this.dateDeliveryApproximate,
    required this.datePayApproximate,
    required this.completed,
    required this.orderPaymentHistory,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      seller: Seller.fromJson(json['seller']),
      customer: CustomerItem.fromJson(json['customer']),
      dateCreated: DateTime.parse(json['date_created']),
      dateDeliveryApproximate:
          DateTime.parse(json['date_delivery_approximate']),
      datePayApproximate: DateTime.parse(json['date_pay_approximate']),
      completed: json['completed'],
      orderPaymentHistory: List<OrderPaymentHistory>.from(
          json['orderPaymentHistory']
              .map((x) => OrderPaymentHistory.fromJson(x))),
    );
  }
}

class Seller {
  int id;
  String name;
  String lastName;
  String phone;
  String description;

  Seller({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.description,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      phone: json['phone'],
      description: json['description'],
    );
  }
}

class OrderPaymentHistory {
  int id;
  double partialAmount;
  DateTime dueDate;
  bool paymentCompleted;

  OrderPaymentHistory({
    required this.id,
    required this.partialAmount,
    required this.dueDate,
    required this.paymentCompleted,
  });

  factory OrderPaymentHistory.fromJson(Map<String, dynamic> json) {
    return OrderPaymentHistory(
      id: json['id'],
      partialAmount: json['partial_amount'],
      dueDate: DateTime.parse(json['due_date']),
      paymentCompleted: json['payment_completed'],
    );
  }
}
