
import 'dart:convert';
import 'package:ecommerce/controller/url.dart';
import 'package:ecommerce/model/cart_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/registerResponse.dart';


class CartProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<CartItem> _cartItem = [];
  List<CartItem> get cartItems => _cartItem;
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
    return prefs.getString('token'); }


  Future<void> addCart( {required int productid,required int quantity }) async {
     final String? token = await _getTokenFromPreferences(); 
    if (token == null) {
      _error = 'No token found';
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();

    final url = API + 'api/cart/add.php';  
    final body = jsonEncode({
     "product_id":productid.toString(),
     "quantity":quantity.toString()
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
   Future<void> fetchProducts() async {
    final String? token = await _getTokenFromPreferences(); 
    if (token == null) {
      _error = 'No token found';
      notifyListeners();
      return;
    }

    final url = 'https://globosoft.co.uk/ecommerce-api/api/cart/view.php'; // Your API endpoint
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
        final cartResponse = CartResponse.fromJson(jsonResponse);
        _cartItem = cartResponse.cart;
        notifyListeners();
      } else {
        _error = 'Failed to load products';
        notifyListeners();
      }
    } catch (error) {
      _error = 'An error occurred: $error';
      notifyListeners();
    }
  }
}
