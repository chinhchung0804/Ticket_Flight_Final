import 'package:flutter/material.dart';

class TextStyleThird extends StatelessWidget {
  final String text;
  final bool isColor;
  final Color color; // Add color parameter

  const TextStyleThird({
    super.key,
    required this.text,
    required this.isColor,
    this.color = Colors.white, // Pass color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: isColor ? color : Colors.black, // Use color property
        fontSize: isColor ? 18 : 16, // Adjust based on isColor flag
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
