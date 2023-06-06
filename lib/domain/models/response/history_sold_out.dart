import 'package:vendedor/domain/models/response/brand_item.dart';

class HistorySoldOut {
  int? id;
  int? initialStock;
  String? dateOut;
  BrandItem? agency;

  HistorySoldOut({this.id, this.initialStock, this.dateOut, this.agency});

  HistorySoldOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initialStock = json['initial_stock'];
    dateOut = json['date_out'];
    agency = json['agency'] != null ? BrandItem.fromJson(json['agency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['initial_stock'] = initialStock;
    data['date_out'] = dateOut;
    if (agency != null) {
      data['agency'] = agency!.toJson();
    }
    return data;
  }
}
