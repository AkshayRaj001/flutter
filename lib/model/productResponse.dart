


class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String? image;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}


class ProductResponse {
  final String message;
  final List<Product> products;

  ProductResponse({
    required this.message,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> productItems = productList.map((i) => Product.fromJson(i)).toList();

    return ProductResponse(
      message: json['message'],
      products: productItems,
    );
  }
}
