import 'package:vendedor/domain/models/response/history_orders.dart';

class CustomerSeller {
  final int quantityInRout;
  final int quantityNotInRout;
  final List<CustomerData> onRoute;
  final List<CustomerData> notInRoute;

  CustomerSeller({
    required this.quantityInRout,
    required this.quantityNotInRout,
    required this.onRoute,
    required this.notInRoute,
  });

  factory CustomerSeller.fromJson(Map<String, dynamic> json) {
    return CustomerSeller(
      quantityInRout: json['quantity_in_rout'],
      quantityNotInRout: json['quantity_not_in_rout'],
      onRoute: List<CustomerData>.from(
          json['on_route'].map((data) => CustomerData.fromJson(data))),
      notInRoute: List<CustomerData>.from(
        json['not_in_route'].map((data) => CustomerData.fromJson(data)),
      ),
    );
  }
}

class CustomerData {
  final CustomerVisits customerId;
  final bool visited;

  CustomerData({
    required this.customerId,
    required this.visited,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
        customerId: json['customer_id'], visited: json['visited']);
  }
}

class CustomerVisits {
  int id;
  Seller seller;
  String identification;
  String legalRepresentator;
  String socialReason;
  String phone;
  String birthday;
  String address;
  bool state;
  int isCredit;
  int paymentDeadline;
  int totalCreditLine;
  CustomerType customerType;
  CustomerCurrencyType customerCurrencyType;
  CustomerAgency customerAgency;
  CustomerPriceList customerPriceList;
  CustomerUbigeo customerUbigeo;

  CustomerVisits({
    required this.id,
    required this.seller,
    required this.identification,
    required this.legalRepresentator,
    required this.socialReason,
    required this.phone,
    required this.birthday,
    required this.address,
    required this.state,
    required this.isCredit,
    required this.paymentDeadline,
    required this.totalCreditLine,
    required this.customerType,
    required this.customerCurrencyType,
    required this.customerAgency,
    required this.customerPriceList,
    required this.customerUbigeo,
  });

  factory CustomerVisits.fromJson(Map<String, dynamic> json) {
    return CustomerVisits(
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
      customerType: CustomerType.fromJson(json['customer_type']),
      customerCurrencyType:
          CustomerCurrencyType.fromJson(json['customer_currency_type']),
      customerAgency: CustomerAgency.fromJson(json['customer_agency']),
      customerPriceList:
          CustomerPriceList.fromJson(json['customer_price_list']),
      customerUbigeo: CustomerUbigeo.fromJson(json['customer_ubigeo']),
    );
  }
}

class Seller {
  int id;
  String name;
  String lastName;
  String phone;
  String description;
  Agency agency;

  Seller({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.description,
    required this.agency,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      phone: json['phone'],
      description: json['description'],
      agency: Agency.fromJson(json['agency']),
    );
  }
}

class Agency {
  int id;
  String name;

  Agency({
    required this.id,
    required this.name,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'],
      name: json['name'],
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

class CustomerCurrencyType {
  int id;
  String currencySymbol;
  String isoCode;

  CustomerCurrencyType({
    required this.id,
    required this.currencySymbol,
    required this.isoCode,
  });

  factory CustomerCurrencyType.fromJson(Map<String, dynamic> json) {
    return CustomerCurrencyType(
      id: json['id'],
      currencySymbol: json['currency_symbol'],
      isoCode: json['iso_code'],
    );
  }
}

class CustomerAgency {
  int id;
  String name;
  String code;

  CustomerAgency({
    required this.id,
    required this.name,
    required this.code,
  });

  factory CustomerAgency.fromJson(Map<String, dynamic> json) {
    return CustomerAgency(
      id: json['id'],
      name: json['name'],
      code: json['code'],
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

class CustomerUbigeo {
  int id;
  String department;
  String province;
  String district;
  String zipCode;

  CustomerUbigeo({
    required this.id,
    required this.department,
    required this.province,
    required this.district,
    required this.zipCode,
  });

  factory CustomerUbigeo.fromJson(Map<String, dynamic> json) {
    return CustomerUbigeo(
      id: json['id'],
      department: json['department'],
      province: json['province'],
      district: json['district'],
      zipCode: json['zip_code'],
    );
  }
}
