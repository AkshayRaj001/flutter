import 'dart:convert';
import 'package:ecommerce/controller/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/order_response.dart'; 

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  String? _error;
  
  List<Order> get orders => _orders;
  String? get error => _error;
    String API = urlglobal().urlff();
  

  
  Future<String?> _getTokenFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchOrders() async {
    final String? token = await _getTokenFromPreferences(); 
    if (token == null) {
      _error = 'No token found';
      notifyListeners();
      return;
    }

    final url = API+'api/orders/list.php'; 
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        String responseBody = response.body;
        if (responseBody.contains("Connected successfully")) {
          responseBody = responseBody.replaceFirst("Connected successfully", "");
        }
        
        final jsonResponse = json.decode(responseBody);
        final ordersResponse = OrdersResponse.fromJson(jsonResponse); 
        _orders = ordersResponse.orders;
        notifyListeners();
      } else {
        _error = 'Failed to load orders';
        notifyListeners();
      }
    } catch (error) {
      _error = 'An error occurred: $error';
      notifyListeners();
    }
  }
}
