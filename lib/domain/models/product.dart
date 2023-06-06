import 'package:vendedor/domain/models/response/brand_item.dart';
import 'package:vendedor/domain/models/response/category_item.dart';
import 'package:vendedor/domain/models/response/history_sold_out.dart';
import 'package:vendedor/domain/models/response/product_image.dart';
import 'package:vendedor/domain/models/response/product_price.dart';
import 'package:vendedor/domain/models/response/product_stock.dart';

class Product {
  int id;
  String name;
  String description;
  String? sku;
  CategoryItem? categoryItem;
  BrandItem? brandItem;
  List<HistorySoldOut>? historySoldOut;
  ProductStock? productStock;
  bool isFavorite;
  ProductPrice productPrice;
  List<ProductImage> productImage;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      this.sku,
      this.categoryItem,
      this.brandItem,
      this.historySoldOut,
      this.isFavorite = false,
      this.productStock,
      required this.productPrice,
      required this.productImage});

  factory Product.fromJson(Map<String, dynamic> json) {
    final categoryItem_ = json['category_item'] != null
        ? CategoryItem.fromJson(json['category_item'])
        : null;
    final brandItem_ = json['brand_item'] != null
        ? BrandItem.fromJson(json['brand_item'])
        : null;
    List<HistorySoldOut>? historySoldOut_;
    if (json['historySoldOut'] != null) {
      historySoldOut_ = <HistorySoldOut>[];
      json['historySoldOut'].forEach((v) {
        historySoldOut_!.add(HistorySoldOut.fromJson(v));
      });
    }
    var productPrice = ProductPrice.fromJson(json['product_price']);
    var productImage = <ProductImage>[];
    if (json['product_image'] != null) {
      json['product_image'].forEach((v) {
        productImage.add(ProductImage.fromJson(v));
      });
    }

    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        sku: json['sku'],
        categoryItem: categoryItem_,
        brandItem: brandItem_,
        historySoldOut: historySoldOut_,
        isFavorite: json['isFavorite'] ?? false,
        productStock: ProductStock.fromJson(json['product_stock']),
        productPrice: productPrice,
        productImage: productImage);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (categoryItem != null) {
      data['category_item'] = categoryItem!.toJson();
    }
    if (brandItem != null) {
      data['brand_item'] = brandItem!.toJson();
    }
    if (historySoldOut != null) {
      data['history_sold_out'] =
          historySoldOut!.map((v) => v.toJson()).toList();
    }
    if (productStock != null) {
      data['product_stock'] = productStock!.toJson();
    }
    if (productPrice != null) {
      data['product_price'] = productPrice.toJson();
    }
    if (productImage != null) {
      data['product_image'] = productImage.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sku'] = this.sku;
    return data;
  }
}
