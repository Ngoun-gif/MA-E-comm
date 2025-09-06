// lib/widgets/custom_drawer.dart
import 'package:flutter/material.dart';

class MainDrawerBarCustom extends StatelessWidget {
  const MainDrawerBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 200,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/2.jpg'),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ngoun',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(thickness: 1),
                _buildDrawerItem(
                  icon: Icons.favorite_border,
                  label: 'Favorite',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(thickness: 1),
                _buildDrawerItem(
                  icon: Icons.settings,
                  label: 'Setting',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(thickness: 1),
                _buildDrawerItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(thickness: 1),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Version 2.0.1',
              style: TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(icon, color: Colors.black87, size: 20),
      title: Text(label, style: const TextStyle(fontSize: 12)),
      onTap: onTap,
    );
  }
}