import 'dart:convert';

import 'package:vendedor/domain/models/product.dart';
import 'package:vendedor/domain/models/response/brand_item.dart';
import 'package:vendedor/domain/models/response/product_image.dart';
import 'package:vendedor/domain/models/response/product_price.dart';
import 'package:vendedor/domain/models/response/product_stock.dart';

class ProductPromotions {
  int id;
  String name;
  String description;
  String sku;
  CategoryItem categoryItem;
  BrandItem brandItem;
  List<HistorySoldOut> historySoldOut;
  ProductStock productStock;
  ProductPrice productPrice;
  bool favorite;
  List<ProductImage> productImage;
  List<PromotionsBonus> promotionsBonus;
  List<dynamic> promotionsDiscount;
  List<dynamic> promotionsGift;

  ProductPromotions({
    required this.id,
    required this.name,
    required this.description,
    required this.sku,
    required this.categoryItem,
    required this.brandItem,
    required this.historySoldOut,
    required this.productStock,
    required this.productPrice,
    required this.favorite,
    required this.productImage,
    required this.promotionsBonus,
    required this.promotionsDiscount,
    required this.promotionsGift,
  });

  factory ProductPromotions.fromJson(Map<String, dynamic> json) =>
      ProductPromotions(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        sku: json["sku"],
        categoryItem: CategoryItem.fromJson(json["category_item"]),
        brandItem: BrandItem.fromJson(json["brand_item"]),
        historySoldOut: List<HistorySoldOut>.from(
            json["history_sold_out"].map((x) => HistorySoldOut.fromJson(x))),
        productStock: ProductStock.fromJson(json["product_stock"]),
        productPrice: ProductPrice.fromJson(json["product_price"]),
        favorite: json["favorite"],
        productImage: List<ProductImage>.from(
            json["product_image"].map((x) => ProductImage.fromJson(x))),
        promotionsBonus: List<PromotionsBonus>.from(
            json["promotionsBonus"].map((x) => PromotionsBonus.fromJson(x))),
        promotionsDiscount:
            List<dynamic>.from(json["promotionsDiscount"].map((x) => x)),
        promotionsGift:
            List<dynamic>.from(json["promotionsGift"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "sku": sku,
        "category_item": categoryItem.toJson(),
        "brand_item": brandItem.toJson(),
        "history_sold_out":
            List<dynamic>.from(historySoldOut.map((x) => x.toJson())),
        "product_stock": productStock.toJson(),
        "product_price": productPrice.toJson(),
        "favorite": favorite,
        "product_image":
            List<dynamic>.from(productImage.map((x) => x.toJson())),
        "promotionsBonus":
            List<dynamic>.from(promotionsBonus.map((x) => x.toJson())),
        "promotionsDiscount":
            List<dynamic>.from(promotionsDiscount.map((x) => x)),
        "promotionsGift": List<dynamic>.from(promotionsGift.map((x) => x)),
      };

  Product toProduct() {
    return Product(
        id: id,
        name: name,
        description: description,
        productPrice: productPrice,
        productImage: productImage,
        sku: sku,
        brandItem: brandItem,
        productStock: productStock);
  }
}

class CategoryItem {
  int id;
  String name;
  String description;

  CategoryItem({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class HistorySoldOut {
  int id;
  int initialStock;
  DateTime dateOut;
  BrandItem agency;

  HistorySoldOut({
    required this.id,
    required this.initialStock,
    required this.dateOut,
    required this.agency,
  });

  factory HistorySoldOut.fromJson(Map<String, dynamic> json) => HistorySoldOut(
        id: json["id"],
        initialStock: json["initial_stock"],
        dateOut: DateTime.parse(json["date_out"]),
        agency: BrandItem.fromJson(json["agency"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "initial_stock": initialStock,
        "date_out": dateOut.toIso8601String(),
        "agency": agency.toJson(),
      };
}

class ProductP {
  List<ProductImage> productImage;
  int id;
  String name;
  String description;
  String sku;

  ProductP({
    required this.productImage,
    required this.id,
    required this.name,
    required this.description,
    required this.sku,
  });

  factory ProductP.fromJson(Map<String, dynamic> json) => ProductP(
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

class PromotionsBonus {
  int id;
  ProductP productPurchased;
  ProductP productBonus;
  int nPurchasedItems;
  int mBonusItems;
  int quantityApplied;

  PromotionsBonus({
    required this.id,
    required this.productPurchased,
    required this.productBonus,
    required this.nPurchasedItems,
    required this.mBonusItems,
    required this.quantityApplied,
  });

  factory PromotionsBonus.fromJson(Map<String, dynamic> json) =>
      PromotionsBonus(
        id: json["id"],
        productPurchased: ProductP.fromJson(json["productPurchased"]),
        productBonus: ProductP.fromJson(json["productBonus"]),
        nPurchasedItems: json["n_purchased_items"],
        mBonusItems: json["m_bonus_items"],
        quantityApplied: json["quantity_applied"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productPurchased": productPurchased.toJson(),
        "productBonus": productBonus.toJson(),
        "n_purchased_items": nPurchasedItems,
        "m_bonus_items": mBonusItems,
        "quantity_applied": quantityApplied,
      };
}
