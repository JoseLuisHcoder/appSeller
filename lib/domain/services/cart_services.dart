import 'dart:convert';
import 'dart:developer';

import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/cart_product.dart';
import 'package:vendedor/domain/models/response/cart_from_seller.dart';
import 'package:vendedor/domain/models/response/close_cart.dart';
import 'package:http/http.dart' as http;
import 'package:vendedor/domain/models/response/order_customer_seller.dart';

class CartServices {
  Future<int> addShopingCart(
      {required String idCustomer,
      required int idProduct,
      required int quantity}) async {
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
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
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
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
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/ShoppingCart/customer/$idCustomer'),
        headers: headers);
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
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
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

  Future<CartSeller?> getCartBySeller() async {
    final idSeller = await secureStorage.readToken();
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/ShoppingCart/seller/$idSeller'),
        headers: headers);
    log(resp.body);
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      final cartItems = body["body"];
      CartSeller cartProducts = CartSeller.fromJson(cartItems);
      return cartProducts;
    } else {
      return null;
    }
  }

  Future<OrderCustomerSeller?> getOrderCustomerBySeller() async {
    final idSeller = await secureStorage.readToken();
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/OrderCustomer/seller/$idSeller'),
        headers: headers);
    log(resp.body);
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      final cartItems = body["body"];
      OrderCustomerSeller cartProducts =
          OrderCustomerSeller.fromJson(cartItems);
      return cartProducts;
    } else {
      return null;
    }
  }
}

final cartServices = CartServices();
