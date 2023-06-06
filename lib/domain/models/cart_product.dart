import 'package:vendedor/domain/models/product.dart';
import 'package:vendedor/domain/models/response/brand_item.dart';
import 'package:vendedor/domain/models/response/product_image.dart';
import 'package:vendedor/domain/models/response/product_price.dart';
import 'package:flutter/material.dart';

class CartProduct {
  CartProductSingle product;
  int quantity;

  CartProduct({required this.product, required this.quantity});

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
  ProductPrice productPrice;
  List<ProductImage> productImage;

  CartProductSingle({
    required this.id,
    required this.name,
    required this.description,
    this.sku,
    this.productImage = const [],
    required this.productPrice,
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

    ProductPrice productPrice;
    if (json['product_price'] != null) {
      productPrice = (ProductPrice.fromJson(json['product_price']));
    } else {
      productPrice =
          ProductPrice(id: 1, price: 10, agencyPriceList: BrandItem());
    }

    return CartProductSingle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sku: json['sku'],
      productPrice: productPrice,
      productImage: productImages,
    );
  }
}

CartProductSingle parseToCartProductSingle(Product product) {
  return CartProductSingle(
    id: product.id,
    name: product.name,
    description: product.description,
    sku: product.sku,
    productPrice: product.productPrice,
    productImage: product.productImage,
  );
}
