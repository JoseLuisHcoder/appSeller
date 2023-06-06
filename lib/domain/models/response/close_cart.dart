class ResponseOrder {
  final int id;
  final Seller seller;
  final Customer customer;
  final DateTime dateCreated;
  final DateTime dateDeliveryApproximate;
  final DateTime datePayApproximate;
  final bool completed;

  ResponseOrder({
    required this.id,
    required this.seller,
    required this.customer,
    required this.dateCreated,
    required this.dateDeliveryApproximate,
    required this.datePayApproximate,
    required this.completed,
  });

  factory ResponseOrder.fromJson(Map<String, dynamic> json) {
    return ResponseOrder(
      id: json['id'],
      seller: Seller.fromJson(json['seller']),
      customer: Customer.fromJson(json['customer']),
      dateCreated: DateTime.parse(json['date_created']),
      dateDeliveryApproximate:
          DateTime.parse(json['date_delivery_approximate']),
      datePayApproximate: DateTime.parse(json['date_pay_approximate']),
      completed: json['completed'],
    );
  }
}

class Seller {
  final int id;
  final String name;
  final String lastName;
  final String phone;
  final String description;

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

class Customer {
  final int id;
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final bool state;
  final CustomerType customerType;
  final CustomerCountry customerCountry;
  final CustomerIdentification customerIdentification;
  final CustomerAgency customerAgency;
  final CustomerPriceList customerPriceList;

  Customer({
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
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
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
    );
  }
}

class CustomerType {
  final int id;
  final String name;
  final String description;
  final int minMonthlySpent;

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
  final int id;
  final String name;

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
  final int id;
  final String identificationNumber;

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
  final int id;
  final String name;

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
  final int id;
  final String name;

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
