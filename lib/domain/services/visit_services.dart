import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:http/http.dart' as http;
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
}

final visitServices = VisitServices();
