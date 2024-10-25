class OrdersResponse {
  List<Order> orders;

  OrdersResponse({required this.orders});

 
  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      orders: List<Order>.from(json['orders'].map((order) => Order.fromJson(order))),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}

class Order {
  int id;
  String total;
  String address;
  String latitude;
  String longitude;
  String createdAt;
  List<OrderItem> items;

  Order({
    required this.id,
    required this.total,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.items,
  });


  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      total: json['total'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
      items: List<OrderItem>.from(json['items'].map((item) => OrderItem.fromJson(item))),
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  int productId;
  int quantity;
  String price;
  String productName;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.productName,
  });


  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      productName: json['product_name'],
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'product_name': productName,
    };
  }
}
