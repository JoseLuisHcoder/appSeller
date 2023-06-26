class HistoryOrder {
  OrderDetails order;
  List<Tracking> tracking;
  List<Item> items;

  HistoryOrder(
      {required this.order, required this.tracking, required this.items});

  factory HistoryOrder.fromJson(Map<String, dynamic> json) {
    return HistoryOrder(
      order: OrderDetails.fromJson(json['order']),
      tracking: List<Tracking>.from(
          json['tracking'].map((x) => Tracking.fromJson(x))),
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
    );
  }
}

class OrderDetails {
  int id;
  Seller seller;
  Customer customer;
  DateTime dateCreated;
  DateTime dateDeliveryApproximate;
  DateTime datePayApproximate;
  bool completed;
  List<OrderPaymentHistory> orderPaymentHistory;

  OrderDetails({
    required this.id,
    required this.seller,
    required this.customer,
    required this.dateCreated,
    required this.dateDeliveryApproximate,
    required this.datePayApproximate,
    required this.completed,
    required this.orderPaymentHistory,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      seller: Seller.fromJson(json['seller']),
      customer: Customer.fromJson(json['customer']),
      dateCreated: DateTime.parse(json['date_created']),
      dateDeliveryApproximate:
          DateTime.parse(json['date_delivery_approximate']),
      datePayApproximate: DateTime.parse(json['date_pay_approximate']),
      completed: json['completed'],
      orderPaymentHistory: List<OrderPaymentHistory>.from(
          json['orderPaymentHistory']
              .map((historyJson) => OrderPaymentHistory.fromJson(historyJson))),
    );
  }
}

class OrderPaymentHistory {
  final int id;
  final double partialAmount;
  final String dueDate;
  final bool paymentCompleted;

  OrderPaymentHistory({
    required this.id,
    required this.partialAmount,
    required this.dueDate,
    required this.paymentCompleted,
  });

  factory OrderPaymentHistory.fromJson(Map<String, dynamic> json) {
    dynamic partialAmount = json['partial_amount'];
    if (partialAmount is int) {
      partialAmount = partialAmount.toDouble(); // Convierte int a double
    }

    return OrderPaymentHistory(
      id: json['id'],
      partialAmount: partialAmount,
      dueDate: json['due_date'],
      paymentCompleted: json['payment_completed'],
    );
  }
}

class Seller {
  int id;
  String name;
  String lastName;
  String? phone;
  String? description;
  dynamic agency;

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
        agency: json["agency"]);
  }
}

class Customer {
  int id;
  String identification;
  String legalRepresentator;
  String socialReason;
  String? phone;
  String? birthday;
  String address;
  bool state;
  int isCredit;
  int paymentDeadline;
  int totalCreditLine;
  CustomerType customerType;
  CustomerAgency customerAgency;
  CustomerPriceList customerPriceList;

  Customer({
    required this.id,
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
    required this.customerAgency,
    required this.customerPriceList,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      identification: json['identification'],
      legalRepresentator: json['legal_representator'],
      socialReason: json['social_reason'],
      phone: json['phone'],
      birthday: json['birthday'],
      address: json['address'],
      state: json['state'],
      isCredit: json['is_credit'],
      paymentDeadline: json['payment_deadline'],
      totalCreditLine: json['total_credit_line'] ?? 0,
      customerType: CustomerType.fromJson(json['customer_type']),
      customerAgency: CustomerAgency.fromJson(json['customer_agency']),
      customerPriceList:
          CustomerPriceList.fromJson(json['customer_price_list']),
    );
  }
}

class CustomerPayment {
  final int id;
  final CurrencyType currencyType;
  final int creditLine;

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

class Country {
  final int id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CurrencyType {
  final int id;
  final Country country;
  final String currencySymbol;
  final String isoCode;

  CurrencyType({
    required this.id,
    required this.country,
    required this.currencySymbol,
    required this.isoCode,
  });

  factory CurrencyType.fromJson(Map<String, dynamic> json) {
    return CurrencyType(
      id: json['id'],
      country: Country.fromJson(json['country']),
      currencySymbol: json['currency_simbol'],
      isoCode: json['iso_code'],
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

  CustomerCountry({required this.id, required this.name});

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

  CustomerIdentification(
      {required this.id, required this.identificationNumber});

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

  CustomerAgency({required this.id, required this.name});

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

  CustomerPriceList({required this.id, required this.name});

  factory CustomerPriceList.fromJson(Map<String, dynamic> json) {
    return CustomerPriceList(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Tracking {
  int id;
  OrderDelivery orderDelivery;
  DeliveryState deliveryState;
  DateTime dateCompleted;

  Tracking({
    required this.id,
    required this.orderDelivery,
    required this.deliveryState,
    required this.dateCompleted,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) {
    return Tracking(
      id: json['id'],
      orderDelivery: OrderDelivery.fromJson(json['orderDelivery']),
      deliveryState: DeliveryState.fromJson(json['deliveryState']),
      dateCompleted: DateTime.parse(json['date_completed']),
    );
  }
}

class OrderDelivery {
  int id;
  int orderCustomerId;
  String address;
  bool isPrioritary;
  DateTime? approximatedDeliveryDate;
  dynamic orderCustomer;
  dynamic deliveryStateHistorys;

  OrderDelivery({
    required this.id,
    required this.orderCustomerId,
    required this.address,
    required this.isPrioritary,
    this.approximatedDeliveryDate,
    this.orderCustomer,
    this.deliveryStateHistorys,
  });

  factory OrderDelivery.fromJson(Map<String, dynamic> json) {
    return OrderDelivery(
      id: json['id'],
      orderCustomerId: json['order_customer_id'],
      address: json['address'],
      isPrioritary: json['is_prioritary'],
      approximatedDeliveryDate: json['approximated_delivery_date'] != null
          ? DateTime.parse(json['approximated_delivery_date'])
          : null,
      orderCustomer: json['orderCustomer'],
      deliveryStateHistorys: json['deliveryStateHistorys'],
    );
  }
}

class DeliveryState {
  int id;
  String name;
  String description;
  dynamic deliveryStateHistorys;

  DeliveryState({
    required this.id,
    required this.name,
    required this.description,
    this.deliveryStateHistorys,
  });

  factory DeliveryState.fromJson(Map<String, dynamic> json) {
    return DeliveryState(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      deliveryStateHistorys: json['deliveryStateHistorys'],
    );
  }
}

class Item {
  int id;
  Product product;
  int quantity;
  int totalQuantity;
  double initialTotalPrice;
  double promotionalTotalPrice;
  int quantityGifts;
  PromotionApplied? promotionsApplied;

  Item({
    required this.id,
    required this.product,
    required this.quantity,
    required this.totalQuantity,
    required this.initialTotalPrice,
    required this.promotionalTotalPrice,
    required this.quantityGifts,
    this.promotionsApplied,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    var initalPrice = 0.0;
    if (json['initial_total_price'] is int) {
      initalPrice = json['initial_total_price'].toDouble();
    } else {
      initalPrice = json['initial_total_price'];
    }
    var promotionalTotalPrice_ = 0.0;
    if (json['promotional_total_price'] is int) {
      promotionalTotalPrice_ = json['promotional_total_price'].toDouble();
    } else {
      promotionalTotalPrice_ = json['promotional_total_price'];
    }

    return Item(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      totalQuantity: json['total_quantity'],
      initialTotalPrice: initalPrice,
      promotionalTotalPrice: promotionalTotalPrice_,
      quantityGifts: json['quantity_gifts'],
      promotionsApplied: json['promotions_applied'] == null
          ? null
          : PromotionApplied.fromJson(json['promotions_applied']),
    );
  }
}

class PromotionApplied {
  int id;
  List<dynamic> bonusItems;
  List<dynamic> gitItems;
  List<dynamic> discountItems;

  PromotionApplied(
      {required this.id,
      required this.bonusItems,
      required this.gitItems,
      required this.discountItems});

  factory PromotionApplied.fromJson(Map<String, dynamic> json) {
    return PromotionApplied(
      id: json['id'],
      bonusItems: json['bonus_item'] ?? [],
      gitItems: json['git_items'] ?? [],
      discountItems: json['discount_items'] ?? [],
    );
  }
}

class Product {
  List<ProductImage> productImage;
  int id;
  String name;
  String description;
  String sku;

  Product({
    required this.productImage,
    required this.id,
    required this.name,
    required this.description,
    required this.sku,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productImage: List<ProductImage>.from(
          json['product_image'].map((x) => ProductImage.fromJson(x))),
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sku: json['sku'],
    );
  }
}

class CategoryItem {
  int id;
  String name;
  String description;

  CategoryItem(
      {required this.id, required this.name, required this.description});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class ProductImage {
  int id;
  String urlPath;
  String description;
  String label;

  ProductImage(
      {required this.id,
      required this.urlPath,
      required this.description,
      required this.label});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      urlPath: json['urlPath'] ?? " ",
      description: json['description'] ?? " ",
      label: json['label'] ?? " ",
    );
  }
}
