// lib/services/product.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/product.dart';

class ProductService {
  // Fetch all products
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Config.productsUri());

      if (response.statusCode == 200) {
        return productModelFromJson(response.body);
      } else {
        throw Exception('Failed to load products: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Fetch categories
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(Config.categoriesUri());

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.cast<String>();
      } else {
        throw Exception(
          'Failed to load categories: HTTP ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Fetch products by category
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      final response = await http.get(Config.productsByCategoryUri(category));

      if (response.statusCode == 200) {
        return productModelFromJson(response.body);
      } else {
        throw Exception(
          'Failed to load products by category: HTTP ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
