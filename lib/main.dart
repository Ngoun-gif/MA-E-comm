import 'package:flutter/material.dart';
import 'routes.dart';

// Screens
import 'screens/splash/splash_screen.dart';
import 'screens/product_detail/product_detail_screen.dart';
import 'screens/main_page/main_page_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Shop',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.main: (context) => const MainPageScreen(),
        AppRoutes.productDetail: (context) => const ProductDetailScreen(),
      },
    );
  }
}
