import 'package:vendedor/domain/models/response/brand_item.dart';

class ProductPrice {
  int id;
  int price;
  BrandItem agencyPriceList;

  ProductPrice(
      {required this.id, required this.price, required this.agencyPriceList});

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
        id: json['id'],
        price: json['price'],
        agencyPriceList: BrandItem.fromJson(json['agencyPriceList']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    if (this.agencyPriceList != null) {
      data['agencyPriceList'] = this.agencyPriceList!.toJson();
    }
    return data;
  }
}
