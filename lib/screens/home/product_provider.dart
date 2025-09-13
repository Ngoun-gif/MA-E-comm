import '../../services/product.dart';
import '../../models/product.dart';

class ProductProvider {
  // Fetch all products from API
  static Future<List<ProductModel>> fetchAllProducts() async {
    return ProductService().fetchProducts();
  }

  // Get first 6 products as "Special Offers"
  static Future<List<ProductModel>> fetchSpecialOffers() async {
    final all = await fetchAllProducts();
    return all.take(6).toList();
  }

  // Get next 6 products as "New Products"
  static Future<List<ProductModel>> fetchNewProducts() async {
    final all = await fetchAllProducts();
    return all.skip(6).take(6).toList();
  }

  // Fetch unique category names from API
  static Future<List<String>> fetchCategories() async {
    return ProductService().fetchCategories();
  }

  // Fetch products by exact category name (used for clean-labeled sections)
  static Future<List<ProductModel>> fetchProductsByCategory(
    String category,
  ) async {
    return ProductService().fetchProductsByCategory(category);
  }
  static Future<List<ProductModel>> fetchRelatedProducts(String category, int excludeId) async {
    final all = await fetchAllProducts();
    return all
        .where((p) => p.category == category && p.id != excludeId)
        .take(3)
        .toList();
  }
}
