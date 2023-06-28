import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/customer_seller.dart';
import 'package:vendedor/domain/models/response/visit_item.dart';

class CustomerServices {
  Future<CustomerSeller?> getCustomerSeller() async {
    final idSeller = await secureStorage.readToken();
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/Seller/get_plan_visits/$idSeller'),
        headers: headers);

    if (resp.statusCode == 200) {
      final responseCustomerSeller =
          CustomerSeller.fromJson(jsonDecode(resp.body)["body"]);

      return responseCustomerSeller;
    }
    return null;
  }
}

final customerServices = CustomerServices();
