import 'package:vendedor/domain/models/response/history_orders.dart';

class ResponseFavorite {
  int id;
  Customer customer;
  Product product;
  DateTime date;

  ResponseFavorite({
    required this.id,
    required this.customer,
    required this.product,
    required this.date,
  });

  factory ResponseFavorite.fromJson(Map<String, dynamic> json) =>
      ResponseFavorite(
        id: json["id"],
        customer: Customer.fromJson(json["customer"]),
        product: Product.fromJson(json["product"]),
        date: DateTime.parse(json["date"]),
      );
}

class CustomerAgency {
  int id;
  String name;

  CustomerAgency({
    required this.id,
    required this.name,
  });

  factory CustomerAgency.fromJson(Map<String, dynamic> json) => CustomerAgency(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class CustomerIdentification {
  int id;
  String identificationNumber;

  CustomerIdentification({
    required this.id,
    required this.identificationNumber,
  });

  factory CustomerIdentification.fromJson(Map<String, dynamic> json) =>
      CustomerIdentification(
        id: json["id"],
        identificationNumber: json["identification_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identification_number": identificationNumber,
      };
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

  factory CustomerPayment.fromJson(Map<String, dynamic> json) =>
      CustomerPayment(
        id: json["id"],
        currencyType: CurrencyType.fromJson(json["currencyType"]),
        creditLine: json["credit_line"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currencyType": currencyType.toJson(),
        "credit_line": creditLine,
      };
}

class CurrencyType {
  int id;
  CustomerAgency country;
  String currencySimbol;
  String isoCode;

  CurrencyType({
    required this.id,
    required this.country,
    required this.currencySimbol,
    required this.isoCode,
  });

  factory CurrencyType.fromJson(Map<String, dynamic> json) => CurrencyType(
        id: json["id"],
        country: CustomerAgency.fromJson(json["country"]),
        currencySimbol: json["currency_simbol"],
        isoCode: json["iso_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country.toJson(),
        "currency_simbol": currencySimbol,
        "iso_code": isoCode,
      };
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

  factory CustomerType.fromJson(Map<String, dynamic> json) => CustomerType(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        minMonthlySpent: json["min_monthly_spent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "min_monthly_spent": minMonthlySpent,
      };
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productImage: List<ProductImage>.from(
            json["product_image"].map((x) => ProductImage.fromJson(x))),
        id: json["id"],
        name: json["name"],
        description: json["description"],
        sku: json["sku"],
      );

  Map<String, dynamic> toJson() => {
        "product_image":
            List<dynamic>.from(productImage.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "description": description,
        "sku": sku,
      };
}

class ProductImage {
  int id;
  String urlPath;
  String description;
  String label;

  ProductImage({
    required this.id,
    required this.urlPath,
    required this.description,
    required this.label,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        urlPath: json["url_path"],
        description: json["description"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url_path": urlPath,
        "description": description,
        "label": label,
      };
}
