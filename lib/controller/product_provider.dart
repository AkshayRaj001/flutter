import 'dart:convert';
import 'package:ecommerce/controller/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/productResponse.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  String? _error;
  bool _isLoading = false;

  List<Product> get products => _products;
  String? get error => _error;
  bool get isLoading => _isLoading; 
   String API = urlglobal().urlff();


  Future<String?> _getTokenFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); 
  }

  Future<void> fetchProducts() async {
    _isLoading = true; 
    notifyListeners(); 

    final String? token = await _getTokenFromPreferences(); 
    if (token == null) {
      _error = 'No token found';
      _isLoading = false; 
      notifyListeners();
      return;
    }

    final url = API+'api/products/list.php'; 
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
        final productResponse = ProductResponse.fromJson(jsonResponse);
        _products = productResponse.products;
        _error = null; 
      } else {
        _error = 'Failed to load products';
      }
    } catch (error) {
      _error = 'An error occurred: $error';
    } finally {
      _isLoading = false; 
      notifyListeners(); 
    }
  }
}
