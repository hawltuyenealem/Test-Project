import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final int reviewCount;

  const RatingWidget({
    required this.rating,
    required this.reviewCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < rating.floor() ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 20,
          );
        }),
        const SizedBox(width: 8),
        Text('($reviewCount)'),
      ],
    );
  }
}