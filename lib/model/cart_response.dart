class CartResponse {
  String message;
  List<CartItem> cart;

  CartResponse({required this.message, required this.cart});

  
  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      message: json['message'],
      cart: List<CartItem>.from(json['cart'].map((item) => CartItem.fromJson(item))),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'cart': cart.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem {
  int id;
  int productId;
  int quantity;
  String createdAt;
  String productName;
  String price;
  String? image;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.productName,
    required this.price,
    this.image,
  });

  
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      productName: json['product_name'],
      price: json['price'],
      image: json['image'], 
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'created_at': createdAt,
      'product_name': productName,
      'price': price,
      'image': image,
    };
  }
}
