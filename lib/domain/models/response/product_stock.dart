import 'package:vendedor/domain/models/response/brand_item.dart';

class ProductStock {
  int? id;
  int? actualStock;
  int? totalStock;
  BrandItem? agencyStockList;

  ProductStock(
      {this.id, this.actualStock, this.totalStock, this.agencyStockList});

  ProductStock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actualStock = json['actual_stock'];
    totalStock = json['total_stock'];
    agencyStockList = json['agencyStockList'] != null
        ? new BrandItem.fromJson(json['agencyStockList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['actual_stock'] = this.actualStock;
    data['total_stock'] = this.totalStock;
    if (this.agencyStockList != null) {
      data['agencyStockList'] = this.agencyStockList!.toJson();
    }
    return data;
  }
}
