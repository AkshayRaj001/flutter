
import 'dart:convert';
import 'package:ecommerce/controller/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/registerResponse.dart';

class RegisterProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _message;
ApiResponse? _apiResponse;
  bool get isLoading => _isLoading;
  String? get message => _message;
 ApiResponse? get registerResponse => _apiResponse;
  String API = urlglobal().urlff();
  Future<void> registerUser(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final url = API+'api/auth/register.php';  // Replace with your API URL
    final body = jsonEncode({
      'username': name,
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
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
