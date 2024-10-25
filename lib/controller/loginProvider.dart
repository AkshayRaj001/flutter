import 'package:ecommerce/controller/url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/loginResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

class AuthProvider with ChangeNotifier {
  String? _token;
LoginResponse? _loginResponse;
  String? get token => _token;
 LoginResponse? get loginResponse => _loginResponse;
  String API = urlglobal().urlff();
  Future<void> login(String username, String password) async {
  
    final url = API+'api/auth/login.php'; 
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
       String responseBody = response.body;
       if (responseBody.contains("Connected successfully")) {
          responseBody = responseBody.replaceFirst("Connected successfully", "");
        }
      final Map<String, dynamic> data = jsonDecode(responseBody);
      final loginResponse = LoginResponse.fromJson(data);
      _loginResponse = loginResponse;
      _token = loginResponse.token;

   
      await _saveTokenToLocalStorage(_token!);
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> _saveTokenToLocalStorage(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> loadTokenFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }
}
