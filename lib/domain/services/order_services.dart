import 'dart:convert';
import 'dart:developer';

import 'package:vendedor/data/endpoints.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/history_orders.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  Future<List<HistoryOrder>?> getOrdersByCustomer(int idCustomer) async {
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/OrderCustomer/customer/$idCustomer'),
        headers: {'Accept': 'application/json'});
    log(resp.body);
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      final historyOrderItems = body['body'];
      List<HistoryOrder> historyOrders =
          List.generate(historyOrderItems.length, (index) {
        var x = historyOrderItems[index];
        return HistoryOrder.fromJson(x);
      });
      return historyOrders;
    } else {
      return null;
    }
  }

  Future<HistoryOrder?> getLatestOrderByCustomer() async {
    String? idCustomer = await secureStorage.readToken();
    if (idCustomer == null) return null;
    final resp = await http.get(
        Uri.parse('${Environment.baseUrl}/OrderCustomer/customer/$idCustomer'),
        headers: {'Accept': 'application/json'});
    log(resp.body);
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      final historyOrderItems = body['body'];
      if (historyOrderItems.isNotEmpty) {
        int maxId = 0;
        Map<String, dynamic>? latestOrderJson;

        for (int i = 0; i < historyOrderItems.length; i++) {
          Map<String, dynamic>? orderJson = historyOrderItems[i];

          if (orderJson != null) {
            int orderId = orderJson['order']['id'];

            if (orderId > maxId) {
              maxId = orderId;
              latestOrderJson = orderJson;
            }
          }
        }

        if (latestOrderJson != null) {
          return HistoryOrder.fromJson(latestOrderJson);
        }
      }
    }
    return null;
  }

  Future<bool> completeOrder(
      {required int idOrderCustomer,
      required int rate,
      required String comment}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"rate": rate, "comment": comment};

    http.Response resp = await http.post(
      Uri.parse(
          '${Environment.baseUrl}/OrderCustomer/complete/$idOrderCustomer'),
      headers: headers,
      body: jsonEncode(body),
    );
    log(resp.toString());

    if (resp.statusCode == 302) {
      //print('response.headers:' + response.headers.toString());
      if (resp.headers.containsKey("location")) {
        Uri redirectUri =
            Uri.parse('http://20.195.190.125${resp.headers["location"]!}');
        final getResponse = await http.get(redirectUri);
        if (getResponse.statusCode == 200) {
          return true;
        }
        return false;
      }
    }

    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> cancelOrder({
    required int idOrderCustomer,
    required int complaintReasonId,
    required String description,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "complaint_reason_id": complaintReasonId,
      "description": description
    };

    http.Response resp = await http.post(
      Uri.parse('${Environment.baseUrl}/OrderCustomer/cancel/$idOrderCustomer'),
      headers: headers,
      body: jsonEncode(body),
    );
    print(resp.body);

    if (resp.statusCode == 302) {
      //print('response.headers:' + response.headers.toString());
      if (resp.headers.containsKey("location")) {
        Uri redirectUri =
            Uri.parse('http://20.195.190.125${resp.headers["location"]!}');
        final getResponse = await http.get(redirectUri);
        if (getResponse.statusCode == 200) {
          return true;
        }
        return false;
      }
    }

    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> devolutionOrder({
    required int devolutionReasonId,
    required String description,
    required int idOrderCustomer,
    required String photo,
    required String dateReturn,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "devolution_reason_id": devolutionReasonId,
      "description": description,
      "photo": photo,
      "date_return": dateReturn
    };

    http.Response resp = await http.post(
      Uri.parse(
          '${Environment.baseUrl}/OrderCustomer/devolution/$idOrderCustomer'),
      headers: headers,
      body: jsonEncode(body),
    );
    print(resp.body);

    if (resp.statusCode == 302) {
      //print('response.headers:' + response.headers.toString());
      if (resp.headers.containsKey("location")) {
        Uri redirectUri =
            Uri.parse('http://20.195.190.125${resp.headers["location"]!}');
        final getResponse = await http.get(redirectUri);
        if (getResponse.statusCode == 200) {
          return true;
        }
        return false;
      }
    }

    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }
}

final orderServices = OrderServices();
