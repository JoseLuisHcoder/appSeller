import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/data/secure_storage.dart';

import 'package:vendedor/domain/models/response/product_promotions.dart';

import 'package:http/http.dart' as http;

class ProductPromotionsServices {
  Future<List<ProductPromotions>?> getProductsPromotions() async {
    final idCustomer = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/Promotion/product/$idCustomer'),
        headers: {'Accept': 'application/json'});
    // log(resp.body);
    final response = jsonDecode(resp.body);
    if (response['status']['code'] == 200) {
      final List<dynamic> productsDTO = response['body']['productsCustomerDTO'];
      final List<ProductPromotions> products =
          productsDTO.map((json) => ProductPromotions.fromJson(json)).toList();
      return products;
    } else {
      return null;
    }
  }
}

final productPromotion = ProductPromotionsServices();
