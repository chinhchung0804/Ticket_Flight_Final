import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';

class TextStyleThird extends StatelessWidget {
  final String text;
  final bool? isColor;
  const TextStyleThird({super.key, required this.text, this.isColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: isColor==null? AppStyles.headLineStyle3.copyWith(color: Colors.white):AppStyles.headLineStyle3,
    );
  }
}