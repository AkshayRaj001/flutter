import 'package:ecommerce/controller/cart_provider.dart';
import 'package:ecommerce/controller/checkout_provider.dart';
import 'package:ecommerce/controller/loginProvider.dart';
import 'package:ecommerce/controller/order_provider.dart';
import 'package:ecommerce/controller/product_provider.dart';

import 'package:ecommerce/pages/LoginPage.dart';
import 'package:ecommerce/pages/RegitrationPage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/RegisterProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUpScreen(),
      ),
    );
  }
}
