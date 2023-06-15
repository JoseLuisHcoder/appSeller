import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/customer_seller.dart';
import 'package:vendedor/domain/models/response/visit_item.dart';

class CustomerServices {
  Future<List<CustomerSeller>?> getCustomerSeller() async {
    final idSeller = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse(
            '${Environment.baseUrl}/OrderCustomer/on_route/seller/$idSeller'),
        headers: {'Accept': 'application/json'});

    final respNot = await http.get(
        Uri.parse(
            '${Environment.baseUrl}/OrderCustomer/not_on_route/seller/$idSeller'),
        headers: {'Accept': 'application/json'});

    if (resp.statusCode == 200 && respNot.statusCode == 200) {
      final responseCustomerSeller =
          CustomerSeller.fromJson(jsonDecode(resp.body)["body"]);
      final responseCustomerSellerNot =
          CustomerSeller.fromJson(jsonDecode(respNot.body)["body"]);
      List<CustomerSeller> response = [
        responseCustomerSeller,
        responseCustomerSellerNot
      ];
      return response;
    }
    return null;
  }
}

final customerServices = CustomerServices();
