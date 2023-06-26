import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/visit_item.dart';

class VisitServices {
  Future<CustomerVisit?> getVisitCustomerInfo(int idCustomer) async {
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/Customer/description/$idCustomer'),
        headers: {'Accept': 'application/json'});

    if (resp.statusCode == 200) {
      final responseVisitInfo = CustomerVisit.fromJson(jsonDecode(resp.body));
      return responseVisitInfo;
    }
    return null;
  }

  Future<Map<String, dynamic>> startVisit(int customerId) async {
    final idSeller = await secureStorage.readToken();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "seller_id": idSeller,
      "x_y_geo_initial": "asdada"
    };

    final resp = await http.post(
        Uri.parse('${Environment.baseUrl}/Seller/start_visit/$customerId'),
        headers: headers,
        body: jsonEncode(body));

    final response = jsonDecode(resp.body);

    return response["status"];
  }

  Future<Map<String, dynamic>> finishVisit(int customerId) async {
    final idSeller = await secureStorage.readToken();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "seller_id": idSeller,
      "x_y_geo_final": "string",
      "visit_state": "string",
      "visit_result": "string",
      "observations": "string"
    };

    final resp = await http.post(
        Uri.parse('${Environment.baseUrl}/Seller/finish_visit/$customerId'),
        headers: headers,
        body: jsonEncode(body));

    final response = jsonDecode(resp.body);

    return response["status"];
  }
}

final visitServices = VisitServices();
