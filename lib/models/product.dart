import 'dart:convert';

List<Product> productFromJson(String str) {
  try {
    final decoded = json.decode(str);
    if (decoded is List) {
      return List<Product>.from(decoded.map((x) => Product.fromJson(x)));
    } else {
      print('Error: Expected List but got ${decoded.runtimeType}');
      return [];
    }
  } catch (e) {
    print('Error parsing JSON: $e');
    print('Problematic JSON string: $str');
    return [];
  }
}

String productToJson(List<Product> data) {
  try {
    return json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  } catch (e) {
    print('Error converting to JSON: $e');
    return '[]';
  }
}

class Product {
  String id;
  String name;
  int price;
  String description;
  String category;
  String thumbnail;
  int productViews;
  DateTime createdAt;
  bool isFeatured;
  int userId;
  String userUsername;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.productViews,
    required this.createdAt,
    required this.isFeatured,
    required this.userId,
    required this.userUsername,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: _parseString(json["id"]),
        name: _parseString(json["name"]),
        price: _parseInt(json["price"]),
        description: _parseString(json["description"]),
        category: _parseString(json["category"]),
        thumbnail: _parseString(json["thumbnail"] ?? ""),
        productViews: _parseInt(json["product_views"]),
        createdAt: _parseDateTime(json["created_at"]),
        isFeatured: _parseBool(json["is_featured"]),
        userId: _parseInt(json["user_id"]),
        userUsername: _parseString(json["user_username"] ?? "Anonymous"),
      );
    } catch (e) {
      print('Error creating Product from JSON: $e');
      print('Problematic JSON: $json');
      return Product(
        id: '',
        name: 'Error loading product',
        price: 0,
        description: 'Error loading description',
        category: 'unknown',
        thumbnail: '',
        productViews: 0,
        createdAt: DateTime.now(),
        isFeatured: false,
        userId: 0,
        userUsername: 'Unknown',
      );
    }
  }

  // Helper methods for safe parsing
  static String _parseString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Error parsing date: $value');
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  static bool _parseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    if (value is int) return value != 0;
    return false;
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "product_views": productViews,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
        "user_username": userUsername,
      };
    } catch (e) {
      print('Error converting Product to JSON: $e');
      return {
        "id": "",
        "name": "Error",
        "price": 0,
        "description": "Error",
        "category": "error",
        "thumbnail": "",
        "product_views": 0,
        "created_at": DateTime.now().toIso8601String(),
        "is_featured": false,
        "user_id": 0,
        "user_username": "Unknown",
      };
    }
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price}';
  }
}