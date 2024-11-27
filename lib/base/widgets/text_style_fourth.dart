import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';

class TextStyleFourth extends StatelessWidget {
  final String text;
  final TextAlign align;
  final bool isColor; // Changed nullable to non-nullable
  final Color color;

  const TextStyleFourth({
    super.key,
    required this.text,
    this.align = TextAlign.start,
    this.isColor = false, // Default value remains false
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: AppStyles.headLineStyle4.copyWith(
        color: isColor ? Colors.white : AppStyles.headLineStyle4.color,
      ),
    );
  }
}
