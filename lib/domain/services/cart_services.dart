import 'dart:convert';
import 'dart:developer';

import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/cart_product.dart';
import 'package:vendedor/domain/models/response/close_cart.dart';
import 'package:http/http.dart' as http;

class CartServices {
  Future<int> addShopingCart(
      {required String idCustomer,
      required int idProduct,
      required int quantity}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"product_id": idProduct, "quantity": quantity};

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/ShoppingCart/$idCustomer'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (resp.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(resp.body);
      int cartId = json['body']['shoppingCartItemDTO']['id'];
      return cartId;
    }
    return -1;
  }

  Future<bool> removeQuantityShopingCart(
      {required String idCustomer,
      required int idProduct,
      required int quantity}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"product_id": idProduct, "quantity": quantity};

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/ShoppingCart/$idCustomer'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<ShoppingCart?> getCartByCustomer(int idCustomer) async {
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/ShoppingCart/customer/$idCustomer'),
        headers: {'Accept': 'application/json'});
    log(resp.body);
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      final cartItems = body["body"]['shoppingCart'];
      ShoppingCart cartProducts = ShoppingCart.fromJson(cartItems);
      secureStorage.persistenCartId(body["id"].toString());
      return cartProducts;
    } else {
      secureStorage.persistenCartId("-1");
      return null;
    }
  }

  Future<ResponseOrder?> closeCart(
      int idCustomer, int? seller, String? address) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "seller_id": seller ?? 2,
      "address": address ?? 'calle miraflores'
    };

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/OrderCustomer/$idCustomer'),
      headers: headers,
      body: jsonEncode(body),
    );

    log(resp.body);
    if (resp.statusCode == 200) {
      final responseBody = jsonDecode(resp.body);
      final responseCart = ResponseOrder.fromJson(responseBody['body']['data']);
      return responseCart;
    } else {
      return null;
    }
  }
}

final cartServices = CartServices();
