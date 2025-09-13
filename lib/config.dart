// lib/config.dart
class Config {
  static const String host = 'fakestoreapi.com';
  static const String productsPath = '/products';

  static Uri productsUri() => Uri.https(host, productsPath);
  static Uri categoriesUri() => Uri.https(host, '$productsPath/categories');
  static Uri productsByCategoryUri(String category) =>Uri.https(host, '$productsPath/category/$category');
}
