
import 'dart:convert';
import 'package:ecommerce/controller/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/registerResponse.dart';


class CheckoutProvider extends ChangeNotifier {
  bool _isLoading = false;
  
  String? _message;
   String? _error;
ApiResponse? _apiResponse;
  bool get isLoading => _isLoading;
  String? get message => _message;
 ApiResponse? get cartResponse => _apiResponse;
 String? get error => _error;
 String API = urlglobal().urlff();


  Future<String?> _getTokenFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  Future<void> addCart( {required String address }) async {
     final String? token = await _getTokenFromPreferences();
    if (token == null) {
      _error = 'No token found';
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();

    final url = API + 'api/checkout/checkout.php';  
    final body = jsonEncode({
    "address": address,
  "latitude": "40.712776",
  "longitude": "-74.005974"
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

    if (response.statusCode == 200) {
       
        String responseBody = response.body;

    
        if (responseBody.contains("Connected successfully")) {
          responseBody = responseBody.replaceFirst("Connected successfully", "");
        }

    
        final jsonResponse = json.decode(responseBody);
        _apiResponse = ApiResponse.fromJson(jsonResponse);
        _message = _apiResponse?.message;
      } else {
        _message = 'Error: ${response.statusCode}';
      }
    } catch (error) {
      _message = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
}
