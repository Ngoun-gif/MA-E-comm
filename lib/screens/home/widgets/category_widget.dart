import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4),
              ],
            ),
            child: Icon(icon, size: 24, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
