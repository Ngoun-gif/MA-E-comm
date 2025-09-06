// lib/widgets/main_app_bar.dart
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(""),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Handle search
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications), // 🔔 Changed to notifications
          onPressed: () {
            // Handle notifications
          },
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.menu), // ☰ Hamburger icon
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Open drawer
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}