import 'package:flutter/material.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({super.key});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int selectedIndex = 0;

  final List<String> imageUrls = [
    'https://m.media-amazon.com/images/I/711IoMiPz4L._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71yZl1kHZcL._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/618a+A7U12L._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71FxonibS2L._SL1500_.jpg',
    'https://m.media-amazon.com/images/I/710N8weaVGL._SL1500_.jpg'
  ];

  void previousImage() {
    setState(() {
      selectedIndex = (selectedIndex - 1 + imageUrls.length) % imageUrls.length;
    });
  }

  void nextImage() {
    setState(() {
      selectedIndex = (selectedIndex + 1) % imageUrls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Image Viewer
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey.shade100,
              child: Image.network(
                imageUrls[selectedIndex],
                fit: BoxFit.contain,
              ),
            ),
            // Left Arrow
            Positioned(
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Colors.black54),
                onPressed: previousImage,
              ),
            ),
            // Right Arrow
            Positioned(
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 24, color: Colors.black54),
                onPressed: nextImage,
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Thumbnails Row
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Image.network(
                    imageUrls[index],
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
