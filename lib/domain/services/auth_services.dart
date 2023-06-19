import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:vendedor/data/endpoints.dart';

class AuthServices {
  Future<int?> login({required String email, required String password}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'user': email, 'password': password};

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/Seller/login_seller'),
      headers: headers,
      body: jsonEncode(body),
    );
    final response = jsonDecode(resp.body);
    log(resp.body);
    if (response['status']['code'] == 200) {
      return response["body"]["seller_id"];
    }
    return null;
  }
}

final authServices = AuthServices();
