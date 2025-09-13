import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../home/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Get the real ProductModel object
    final ProductModel product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              debugPrint("Added ${product.title} to cart");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 220,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {
                        debugPrint("Toggled favorite on ${product.title}");
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ✅ Title
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // ✅ Rating
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                        (index) => Icon(
                      index < product.rating.rate.floor() ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "(${product.rating.rate.toStringAsFixed(1)} from ${product.rating.count} reviews)",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ✅ Price
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),

            // ✅ Category
            Text(
              product.category.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Description
            Text(
              product.description,
              style: const TextStyle(
                color: Colors.black87,
                height: 1.5,
                fontSize: 15,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // ✅ Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      debugPrint("Added ${product.title} to cart");
                    },
                    child: const Text("Add To Cart"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("Bought ${product.title}");
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Buy Now"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Related Products
            const Text(
              "Related Products",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<ProductModel>>(
              future: ProductProvider.fetchRelatedProducts(product.category, product.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Failed to load related products');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No related products found');
                } else {
                  final related = snapshot.data!;
                  return SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: related.length,
                      itemBuilder: (context, index) {
                        final item = related[index];
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.network(
                                    item.image,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      height: 100,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.image_not_supported, size: 30, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\$${item.price.toStringAsFixed(2)}"),
                                      IconButton(
                                        icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                                        onPressed: () {
                                          debugPrint("Added ${item.title} to cart");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}