import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<String> colors;
  final String? selectedColor;

  const ColorSelector({
    required this.colors,
    this.selectedColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: colors.map((color) {
        return ChoiceChip(
          label: Text(color),
          selected: selectedColor == color,
          onSelected: (selected) {
            // Handle color selection
          },
        );
      }).toList(),
    );
  }
}