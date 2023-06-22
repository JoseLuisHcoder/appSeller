import 'package:vendedor/domain/models/response/history_orders.dart';

class CartSeller {
  int sellerId;
  String sellerName;
  List<Response> response;

  CartSeller({
    required this.sellerId,
    required this.sellerName,
    required this.response,
  });

  factory CartSeller.fromJson(Map<String, dynamic> json) {
    return CartSeller(
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
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
      ubiGeoName: json['ubi_geo_name'],
      results2: List<Results2>.from(
          json['results2'].map((x) => Results2.fromJson(x))),
    );
  }
}

class Results2 {
  int customerId;
  String customerName;
  List<ShoppingCartLive> shoppingCart;

  Results2({
    required this.customerId,
    required this.customerName,
    required this.shoppingCart,
  });

  factory Results2.fromJson(Map<String, dynamic> json) {
    return Results2(
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      shoppingCart: List<ShoppingCartLive>.from(json['shopping_cart']
          .map((x) => ShoppingCartLive.fromJson(x['shopping_cart']))),
    );
  }
}

class ShoppingCartLive {
  int id;
  Customer customer;
  LastProductAdded lastProductAdded;
  List<ShoppingCartItem> shoppingCartItems;
  DateTime creationDate;
  DateTime lastModifiedDate;
  DateTime reservationTimeExpire;

  ShoppingCartLive({
    required this.id,
    required this.customer,
    required this.lastProductAdded,
    required this.shoppingCartItems,
    required this.creationDate,
    required this.lastModifiedDate,
    required this.reservationTimeExpire,
  });

  factory ShoppingCartLive.fromJson(Map<String, dynamic> json) {
    return ShoppingCartLive(
      id: json['id'],
      customer: Customer.fromJson(json['customer']),
      lastProductAdded: LastProductAdded.fromJson(json['last_product_added']),
      shoppingCartItems: List<ShoppingCartItem>.from(
          json['shopping_cart_items'].map((x) => ShoppingCartItem.fromJson(x))),
      creationDate: DateTime.parse(json['creation_date']),
      lastModifiedDate: DateTime.parse(json['last_modified_date']),
      reservationTimeExpire: DateTime.parse(json['reservation_time_expire']),
    );
  }
}

class LastProductAdded {
  List<ProductImage> productImage;
  int id;
  String name;
  String description;
  String sku;

  LastProductAdded({
    required this.productImage,
    required this.id,
    required this.name,
    required this.description,
    required this.sku,
  });

  factory LastProductAdded.fromJson(Map<String, dynamic> json) {
    return LastProductAdded(
      productImage: List<ProductImage>.from(
          json['product_image'].map((x) => ProductImage.fromJson(x))),
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sku: json['sku'],
    );
  }
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

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      urlPath: json['url_path'],
      description: json['description'],
      label: json['label'],
    );
  }
}

class ShoppingCartItem {
  int id;
  Product product;
  int quantity;
  int totalQuantity;
  double initialTotalPrice;
  double promotionalTotalPrice;
  int quantityGifts;
  PromotionsApplied? promotionsApplied;

  ShoppingCartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.totalQuantity,
    required this.initialTotalPrice,
    required this.promotionalTotalPrice,
    required this.quantityGifts,
    this.promotionsApplied,
  });

  factory ShoppingCartItem.fromJson(Map<String, dynamic> json) {
    return ShoppingCartItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      totalQuantity: json['total_quantity'],
      initialTotalPrice: json['initial_total_price'].toDouble(),
      promotionalTotalPrice: json['promotional_total_price'].toDouble(),
      quantityGifts: json['quantity_gifts'],
      promotionsApplied: json['promotions_applied'] == null
          ? null
          : PromotionsApplied.fromJson(json['promotions_applied']),
    );
  }
}

class PromotionsApplied {
  dynamic id;
  dynamic name;

  PromotionsApplied({
    required this.id,
    required this.name,
  });

  factory PromotionsApplied.fromJson(Map<String, dynamic> json) {
    return PromotionsApplied(
      id: json['id'],
      name: json['name'],
    );
  }
}
