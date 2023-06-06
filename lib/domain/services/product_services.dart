import 'dart:convert';
import 'dart:developer';
import 'package:vendedor/data/data.dart';
import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/product.dart';

import 'package:vendedor/domain/models/response/response_products_home.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  Future<List<Product>?> listProductsHomeCarousel() async {
    final idCustomer = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/Product/customer/$idCustomer'),
        headers: {'Accept': 'application/json'});
    // log(resp.body);
    final responseProductsHome =
        ResponseProductsHome.fromJson(jsonDecode(resp.body));

    productsList = responseProductsHome.listProducts;
    return responseProductsHome.listProducts;
  }

  Future<bool> addOrDeleteProductFavorite(int idProduct) async {
    final productIndex =
        productsList.indexWhere((product) => product.id == idProduct);

    if (productIndex != -1) {
      final tempProducts = List<Product>.from(productsList);
      tempProducts[productIndex].isFavorite =
          !tempProducts[productIndex].isFavorite;
      productsList = tempProducts;
      return true;
    }
    return false;
  }

  Future<List<Product>?> getProducts() async {
    await listProductsHomeCarousel();
    return productsList;
  }

  Future<List<Product>?> listProductsBestSellings() async {
    final idCustomer = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse(
            '${Environment.baseUrl}/Product/products_best_seller/$idCustomer'),
        headers: {'Accept': 'application/json'});
    // log(resp.body);
    final responseProductsHome =
        ResponseProductsHome.fromJson(jsonDecode(resp.body));

    productsList = responseProductsHome.listProducts;
    return responseProductsHome.listProducts;
  }

  Future<List<Product>?> getProductsBestSellings() async {
    await listProductsBestSellings();
    return productsList;
  }

  // Future<List<Product>?> listProductsMostLiked() async {
  //   final idCustomer = await secureStorage.readToken();
  //   final resp = await http.get(
  //       Uri.parse('${Environment.baseUrl}/Product/most_favorites/$idCustomer'),
  //       headers: {'Accept': 'application/json'});
  //   // log(resp.body);
  //   final response = jsonDecode(resp.body);
  //   if (response['status']['code'] == 200) {
  //     final List<dynamic> productsDTO = response['body']['productsCustomerDTO'];
  //     final List<Product> products =
  //         productsDTO.map((json) => ResponseProductsHome.fromJson(json));
  //   }
  // final responseProductsHome =
  //     ResponseProductsHome.fromJson(jsonDecode(resp.body));

  // productsList = responseProductsHome.listProducts;
  // return responseProductsHome.listProducts;
  // }

  // Future<List<Product>?> getProductsMostLiked() async {
  //   await listProductsMostLiked();
  //   return productsList;
  // }

  Future<List<Product>?> listProductsMostSeen() async {
    final idCustomer = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/Product/most_seen/$idCustomer'),
        headers: {'Accept': 'application/json'});
    log(resp.body);
    final responseProductsHome =
        ResponseProductsHome.fromJson(jsonDecode(resp.body));

    productsList = responseProductsHome.listProducts;
    return responseProductsHome.listProducts;
  }

  Future<List<Product>?> getProductsMostSeen() async {
    await listProductsMostSeen();
    return productsList;
  }
}

final productServices = ProductServices();
