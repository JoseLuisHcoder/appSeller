import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/product.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> searchProductsByWord(String searchWord) async {
    final idCustomer = await secureStorage.readToken();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"search_word": searchWord};

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/Product/search_filter/$idCustomer'),
      headers: headers,
      body: jsonEncode(body),
    );
    final response = jsonDecode(resp.body);
    if (response['status']['code'] == 200 && response['body']['quantity'] > 0) {
      final List<dynamic> productsDTO = response['body']['productsFiltered'];
      final List<Product> products =
          productsDTO.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      return [];
    }
  }
}

final searchServices = SearchServices();
