// lib/models/product.dart
import 'dart:convert';

// Converts JSON string to List<ProductModel>
List<ProductModel> productModelFromJson(String str) {
  final List<dynamic> jsonList = json.decode(str);
  return jsonList.map((item) => ProductModel.fromJson(item)).toList();
}

// Converts List<ProductModel> to JSON string (for future use)
String productModelToJson(List<ProductModel> data) =>
    json.encode(data.map((x) => x.toJson()).toList());

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] ?? 0,
    title: json['title'] ?? 'Unknown Product',
    price: (json['price'] is num) ? json['price'].toDouble() : 0.0,
    description: json['description'] ?? '',
    category: json['category']?.toString() ?? 'unknown',
    image: json['image'] ?? '',
    rating: json['rating'] != null
        ? Rating.fromJson(json['rating'])
        : Rating(rate: 0.0, count: 0),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
    'rating': rating.toJson(),
  };
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: (json['rate'] is num) ? json['rate'].toDouble() : 0.0,
    count: json['count'] ?? 0,
  );

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};
}
