import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;
  final int stock = 16;

  void increaseQuantity() {
    setState(() {
      if (quantity < stock) {
        quantity++;
      }
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Counter Container
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(40),
            color: Colors.grey.shade100,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: decreaseQuantity,
                child: const Icon(Icons.remove, size: 20, color: Colors.black),
              ),
              const SizedBox(width: 16),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: increaseQuantity,
                child: const Icon(Icons.add, size: 20, color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Stock Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Only ',
                style: const TextStyle(color: Colors.black, fontSize: 14),
                children: [
                  TextSpan(
                    text: '$stock items',
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' left!'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Don't miss it",
              style: TextStyle(color: Colors.black, fontSize: 14),
            )
          ],
        )
      ],
    );
  }
}
