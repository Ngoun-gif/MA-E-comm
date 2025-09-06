// lib/screens/main_page/main_page_screen.dart
import 'package:flutter/material.dart';

// Import your custom widgets
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_drawer_bar.dart';
import '../../widgets/main_bottom_bar.dart';

// Import screens
import '../home/home_screen.dart';
import '../category/category_screen.dart';
import '../favorite/favorite_screen.dart';
import '../profile/profile_screen.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: MainBottomBar( // ✅ Not const (has onTap)
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}