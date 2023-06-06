import 'dart:convert';
import 'dart:developer';
import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/domain/models/response/login_response.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<LoginResponse> login(
      {required String email, required String password}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'email': email, 'password': password};

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/Customer/login'),
      headers: headers,
      body: jsonEncode(body),
    );
    log(resp.body);
    return LoginResponse.fromJson(jsonDecode(resp.body));
  }
}

final authServices = AuthServices();
