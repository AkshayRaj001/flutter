import 'package:ecommerce/pages/home.dart';
import 'package:ecommerce/pages/order.dart';
import 'package:flutter/material.dart';
import 'cart.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    Order(),
    ProductListScreen(),
    Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 60,
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0
                            ? Icons.home
                            : index == 1
                                ? Icons.shopify_outlined
                                : index == 2
                                    ? Icons.shopping_cart_outlined
                                    : Icons.person,
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                      if (_currentIndex == index) ...[
                        SizedBox(height: 4),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 6,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
