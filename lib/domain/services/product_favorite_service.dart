import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/data/secure_storage.dart';

import '../models/response/product_favorite.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ProductFavoriteServices {
  Future<ResponseFavorite?> postFavorite({required int idProduct}) async {
    final customerId = await secureStorage.readToken();
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map<String, dynamic> body = {"customer_id": customerId};

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/Product/mark_Favorite/$idProduct'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (resp.statusCode == 201) {
      if (resp.headers.containsKey("location")) {
        final body = await jsonDecode(resp.body);
        final responseFavorite =
            ResponseFavorite.fromJson(body['body']['favorite']);

        return responseFavorite;
      } else {
        return null;
      }
    }
  }
}

final productFavoriteServices = ProductFavoriteServices();
