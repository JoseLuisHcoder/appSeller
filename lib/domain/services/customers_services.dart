import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/customer_seller.dart';
import 'package:vendedor/domain/models/response/visit_item.dart';

class CustomerServices {
  Future<CustomerSeller?> getCustomerSeller() async {
    final idSeller = await secureStorage.readToken();
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/get_plan_visits/$idSeller'),
        headers: {'Accept': 'application/json'});

    if (resp.statusCode == 200) {
      final responseCustomerSeller =
          CustomerSeller.fromJson(jsonDecode(resp.body)["body"]);
      return responseCustomerSeller;
    }
    return null;
  }
}

final customerServices = CustomerServices();
