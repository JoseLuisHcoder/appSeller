import 'package:vendedor/domain/models/response/history_orders.dart';

class ShoppingCart {
  int id;
  Customer customer;
  DateTime creationDate;
  DateTime reservationTimeExpire;
  List<CartProduct> shoppingCartItems;

  ShoppingCart({
    required this.id,
    required this.customer,
    required this.creationDate,
    required this.reservationTimeExpire,
    required this.shoppingCartItems,
  });

  factory ShoppingCart.fromJson(Map<String, dynamic> json) {
    return ShoppingCart(
      id: json['id'],
      customer: Customer.fromJson(json['customer']),
      creationDate: DateTime.parse(json['creation_date']),
      reservationTimeExpire: DateTime.parse(json['reservation_time_expire']),
      shoppingCartItems: List<CartProduct>.from(
          json["shoppingCartItems"].map((x) => CartProduct.fromJson(x))),
    );
  }
}

class CartProduct {
  int id;
  CartProductSingle product;
  int quantity;
  int totalQuantity;
  double initialTotalPrice;
  double promotionalTotalPrice;
  int quantityGifts;
  Map<String, dynamic>? promotionsApplied;
  bool favorite;
  bool saved;

  CartProduct(
      {required this.id,
      required this.product,
      required this.quantity,
      required this.totalQuantity,
      required this.initialTotalPrice,
      required this.promotionalTotalPrice,
      required this.quantityGifts,
      required this.favorite,
      required this.saved,
      this.promotionsApplied});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      product: CartProductSingle.fromJson(json['product']),
      id: json['id'],
      quantity: json['quantity'],
      totalQuantity: json['total_quantity'],
      initialTotalPrice: json['initial_total_price'] is int
          ? json['initial_total_price'].toDouble()
          : json['initial_total_price'],
      promotionalTotalPrice: json['promotional_total_price'] is int
          ? json['promotional_total_price'].toDouble()
          : json['promotional_total_price'],
      quantityGifts: json['quantity_gifts'],
      favorite: json['favorite'] ?? false,
      saved: json['saved'] ?? false,
      promotionsApplied: json['promotions_applied'] != null
          ? json['promotions_applied']
          : null,
    );
  }

  @override
  bool operator ==(other) {
    return other is Product && other.id == product.id;
  }

  @override
  int get hashCode => product.id.hashCode;
}

class CartProductSingle {
  int id;
  String name;
  String description;
  String? sku;
  List<ProductImage> productImage;

  CartProductSingle({
    required this.id,
    required this.name,
    required this.description,
    this.sku,
    this.productImage = const [],
  });

  factory CartProductSingle.fromJson(Map<String, dynamic> json) {
    final List<dynamic> productImagesJson = json['product_image'];

    final List<ProductImage> productImages = productImagesJson.map((imageData) {
      return ProductImage(
        id: imageData['id'],
        urlPath: imageData['url_path'],
        description: imageData['description'],
        label: imageData['label'],
      );
    }).toList();

    return CartProductSingle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sku: json['sku'],
      productImage: productImages,
    );
  }
}

/*CartProductSingle parseToCartProductSingle(Product product) {
  return CartProductSingle(
    id: product.id,
    name: product.name,
    description: product.description,
    sku: product.sku,
    productPrice: product.productPrice,
    productImage: product.productImage,
  );
}*/

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
