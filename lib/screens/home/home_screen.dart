import 'package:flutter/material.dart';
import 'widgets/banner_widget.dart';
import 'widgets/product_widget.dart';
import 'widgets/category_widget.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_drawer_bar.dart';
import 'product_provider.dart';
import '../../models/product.dart';
import '../product_detail/product_detail_screen.dart'; // Import the product detail screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> _categoriesFuture;

  // New futures for clean-label sections
  late Future<List<ProductModel>> _mensClothingFuture;
  late Future<List<ProductModel>> _jeweleryFuture;
  late Future<List<ProductModel>> _electronicsFuture;
  late Future<List<ProductModel>> _womensClothingFuture;

  @override
  void initState() {
    super.initState();

    _categoriesFuture = ProductProvider.fetchCategories();

    // Fetch products by exact API category name for clean-labeled sections
    _mensClothingFuture = ProductProvider.fetchProductsByCategory(
      "men's clothing",
    );
    _jeweleryFuture = ProductProvider.fetchProductsByCategory("jewelery");
    _electronicsFuture = ProductProvider.fetchProductsByCategory("electronics");
    _womensClothingFuture = ProductProvider.fetchProductsByCategory(
      "women's clothing",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const MainDrawerBarCustom(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerWidget(),
            const SizedBox(height: 20),

            // 🔹 SHOP BY CATEGORIES — UNCHANGED (RAW API NAMES + ICONS)
            _buildSectionHeader("Shop By Categories", () {
              debugPrint("Tapped on 'See All' Categories");
            }),
            const SizedBox(height: 10),
            FutureBuilder<List<String>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading categories: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No categories found');
                } else {
                  final categories = snapshot.data!;
                  return SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final name = categories[index];

                        IconData icon;
                        if (name == "men's clothing") {
                          icon = Icons.male;
                        } else if (name == "jewelery") {
                          icon = Icons.diamond;
                        } else if (name == "electronics") {
                          icon = Icons.phone_iphone;
                        } else if (name == "women's clothing") {
                          icon = Icons.female;
                        } else {
                          icon = Icons.local_florist;
                        }

                        return CategoryItem(
                          name: name,
                          icon: icon,
                          onTap: () {
                            debugPrint('Tapped category: $name');
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            // 🔹 MEN — Clean label, raw data source
            _buildSectionHeader("Men", () {
              debugPrint("Tapped on 'Men' section");
            }),
            const SizedBox(height: 10),
            FutureBuilder<List<ProductModel>>(
              future: _mensClothingFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error loading men\'s clothing: ${snapshot.error}',
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No products available');
                } else {
                  final products = snapshot.data!;
                  return SizedBox(
                    height: 220, // Adjust height as needed
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return SizedBox(
                          width: 120, // Adjust width as needed
                          child: ProductCard(
                            name: product.title,
                            price: product.price,
                            image: product.image,
                            rating: product.rating.rate,
                            isFavorite: false,
                            onAddToCart: () =>
                                debugPrint("Added ${product.title} to cart"),
                            onFavoriteTap: () => debugPrint(
                                "Toggled favorite on ${product.title}"),
                            onTap: () {
                              // Navigate to product detail screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(),
                                  settings: RouteSettings(arguments: product),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            // 🔹 JEWELRY — Clean label, raw data source
            _buildSectionHeader("Jewelry", () {
              debugPrint("Tapped on 'Jewelry' section");
            }),
            const SizedBox(height: 10),
            FutureBuilder<List<ProductModel>>(
              future: _jeweleryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading jewelery: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No products available');
                } else {
                  final products = snapshot.data!;
                  return SizedBox(
                    height: 220, // Adjust height as needed
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return SizedBox(
                          width: 120, // Adjust width as needed
                          child: ProductCard(
                            name: product.title,
                            price: product.price,
                            image: product.image,
                            rating: product.rating.rate,
                            isFavorite: false,
                            onAddToCart: () =>
                                debugPrint("Added ${product.title} to cart"),
                            onFavoriteTap: () => debugPrint(
                                "Toggled favorite on ${product.title}"),
                            onTap: () {
                              // Navigate to product detail screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(),
                                  settings: RouteSettings(arguments: product),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            // 🔹 ELECTRONICS — Clean label, raw data source
            _buildSectionHeader("Electronics", () {
              debugPrint("Tapped on 'Electronics' section");
            }),
            const SizedBox(height: 10),
            FutureBuilder<List<ProductModel>>(
              future: _electronicsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading electronics: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No products available');
                } else {
                  final products = snapshot.data!;
                  return SizedBox(
                    height: 220, // Adjust height as needed
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return SizedBox(
                          width: 120, // Adjust width as needed
                          child: ProductCard(
                            name: product.title,
                            price: product.price,
                            image: product.image,
                            rating: product.rating.rate,
                            isFavorite: false,
                            onAddToCart: () =>
                                debugPrint("Added ${product.title} to cart"),
                            onFavoriteTap: () => debugPrint(
                                "Toggled favorite on ${product.title}"),
                            onTap: () {
                              // Navigate to product detail screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(),
                                  settings: RouteSettings(arguments: product),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            // 🔹 WOMEN — Clean label, raw data source
            _buildSectionHeader("Women", () {
              debugPrint("Tapped on 'Women' section");
            }),
            const SizedBox(height: 10),
            FutureBuilder<List<ProductModel>>(
              future: _womensClothingFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error loading women\'s clothing: ${snapshot.error}',
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No products available');
                } else {
                  final products = snapshot.data!;
                  return SizedBox(
                    height: 220, // Adjust height as needed
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return SizedBox(
                          width: 120, // Adjust width as needed
                          child: ProductCard(
                            name: product.title,
                            price: product.price,
                            image: product.image,
                            rating: product.rating.rate,
                            isFavorite: false,
                            onAddToCart: () =>
                                debugPrint("Added ${product.title} to cart"),
                            onFavoriteTap: () => debugPrint(
                                "Toggled favorite on ${product.title}"),
                            onTap: () {
                              // Navigate to product detail screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(),
                                  settings: RouteSettings(arguments: product),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
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
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(onPressed: onSeeAll, child: const Text("See All")),
      ],
    );
  }
}