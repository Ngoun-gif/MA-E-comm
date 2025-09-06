import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // ✅ only import this

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;

  final List<String> bannerImages = [
    'assets/Cover.png',
    'assets/AMT-Push.jpg',
    'assets/Cover.png',
    'assets/Cover.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: bannerImages
              .map(
                (imgPath) => ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imgPath,
                  width: double.infinity,
                  fit: BoxFit.cover,
              ),
            ),
          )
              .toList(),
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerImages.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key
                    ? Colors.blueAccent
                    : Colors.grey[400],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
