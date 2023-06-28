import 'dart:convert';

import 'package:vendedor/data/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/visit_item.dart';
import 'package:geolocator/geolocator.dart';

class VisitServices {
  Future<CustomerVisit?> getVisitCustomerInfo(int idCustomer) async {
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/Customer/description/$idCustomer'),
        headers: headers);

    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body)["body"]["customerDescription"];
      final responseVisitInfo = CustomerVisit.fromJson(json);
      return responseVisitInfo;
    }
    return null;
  }

  Future<Map<String, dynamic>> startVisit(int customerId) async {
    final token = await secureStorage.readUserToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final idSeller = await secureStorage.readToken();
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
    final token = await secureStorage.readUserToken();
    Position position = await _determinePosition();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map<String, dynamic> body = {
      "seller_id": idSeller,
      "x_y_geo_final": "${position.latitude},${position.longitude}",
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

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
