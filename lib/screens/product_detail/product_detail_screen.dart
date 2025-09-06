// lib/screens/product_detail/product_detail_screen.dart
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Get product data from arguments
    final Map<String, dynamic> product =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
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
                  child: Image.asset(
                    product['image'],
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ✅ Name + Rating + Price
            Text(
              product['name'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                        (index) => Icon(
                      index < product['rating']
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.orange,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "(${product['rating'].toString()}.0)",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ✅ Price + Buttons
            Text(
              "\$${product['price']}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Add To Cart"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Buy Now"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Description
            const Text(
              "Descriptions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Mango juice is a sweet and tangy beverage made by extracting "
                  "the liquid from mangoes, often diluted with water to achieve "
                  "a desired consistency...",
              style: TextStyle(color: Colors.black87, height: 1.5),
            ),
            const SizedBox(height: 20),

            // ✅ Related Products
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Related Products",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See All"),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final related = [
                    {'name': 'Fresh Juice', 'price': '2.50', 'image': 'assets/fresh_juice.jpg'},
                    {'name': 'Yogurt', 'price': '2.50', 'image': 'assets/yogurt.jpg'},
                    {'name': 'Red Bull', 'price': '2.50', 'image': 'assets/red_bull.jpg'},
                  ][index];

                  return Container(
                    width: 140,
                    height: 2000,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              related['image']!,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              related['name']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$${related['price']}"),
                                Icon(Icons.shopping_cart, size: 16, color: Colors.blue),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
