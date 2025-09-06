// home_screen.dart
import 'package:flutter/material.dart';
import 'widgets/banner_widget.dart';
import 'widgets/product_widget.dart';
import 'widgets/category_widget.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_drawer_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> specialOffers = [
    {'name': 'Mango Juice', 'price': '2.50', 'image': 'assets/mango.jpg', 'rating': 4, 'isFavorite': false},
    {'name': 'Coca-Cola', 'price': '1.50', 'image': 'assets/coke.jpg', 'rating': 5, 'isFavorite': false},
    {'name': 'Sprite', 'price': '2.50', 'image': 'assets/sprite.jpg', 'rating': 4, 'isFavorite': false},
  ];

  final List<Map<String, dynamic>> newProducts = [
    {'name': 'Fresh Juice', 'price': '2.50', 'image': 'assets/fresh_juice.jpg', 'rating': 4, 'isFavorite': false},
    {'name': 'Yogurt', 'price': '2.50', 'image': 'assets/yogurt.jpg', 'rating': 5, 'isFavorite': false},
    {'name': 'Red Bull', 'price': '2.50', 'image': 'assets/red_bull.jpg', 'rating': 3, 'isFavorite': false},
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Vegetables', 'icon': Icons.local_florist},
    {'name': 'Fast Food', 'icon': Icons.fastfood},
    {'name': 'Foods', 'icon': Icons.local_dining},
    {'name': 'Drinks', 'icon': Icons.local_drink},
    {'name': 'Fruits', 'icon': Icons.local_grocery_store},
  ];

  void _handleFavoriteTap(List<Map<String, dynamic>> list, int index) {
    setState(() {
      list[index]['isFavorite'] = !list[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(), // ✅ Replaced
      drawer: const MainDrawerBarCustom(), // ✅ Replaced
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerWidget(),
            const SizedBox(height: 20),
            _buildSectionHeader("Shop By Categories", () {
              debugPrint("Tapped on 'See All' Categories");
            }),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return CategoryItem(
                    name: item['name'],
                    icon: item['icon'],
                    onTap: () => debugPrint("Tapped on ${item['name']}"),
                  );
                },
              ),
            ),

            const SizedBox(height: 0),
            _buildSectionHeader("Special Offers", () {
              debugPrint("Tapped on 'See All' Special Offers");
            }),

            const SizedBox(height: 10),

            // New Products Section
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newProducts.length,
              itemBuilder: (context, index) {
                final item = newProducts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ProductCard(
                    name: item['name'],
                    price: item['price'],
                    image: item['image'],
                    rating: item['rating'],
                    isFavorite: item['isFavorite'],
                    onAddToCart: () =>
                        debugPrint("Added ${item['name']} to cart"),
                    onFavoriteTap: () => _handleFavoriteTap(newProducts, index),
                    onTap: () {},
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildSectionHeader("New Products", () {
              debugPrint("Tapped on 'See All' New Products");
            }),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final item = newProducts[index];
                return ProductCard(
                  name: item['name'],
                  price: item['price'],
                  image: item['image'],
                  rating: item['rating'],
                  isFavorite: item['isFavorite'],
                  onAddToCart: () => debugPrint("Added ${item['name']} to cart"),
                  onFavoriteTap: () => _handleFavoriteTap(newProducts, index), onTap: () {  },
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        TextButton(onPressed: onSeeAll, child: const Text("See All")),
      ],
    );
  }
}