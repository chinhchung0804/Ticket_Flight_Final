import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/widgets/text_style_fourth.dart';
import 'package:ticket_app_final/base/widgets/text_style_third.dart';

class AppColumnTextLayout extends StatelessWidget {
  final String topText;
  final String bottomText;
  final CrossAxisAlignment alignment;
  final bool? isColor;

  const AppColumnTextLayout({
    super.key,
    required this.topText,
    required this.bottomText,
    required this.alignment,
    this.isColor = true, // Mặc định là true
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        TextStyleThird(
          text: topText,
          isColor: isColor ?? true, // Sử dụng giá trị từ isColor
          color: isColor == true ? Colors.white : Colors.black, // Màu dựa trên isColor
        ),
        const SizedBox(
          height: 5,
        ),
        TextStyleFourth(
          text: bottomText,
          isColor: isColor ?? true, // Sử dụng giá trị từ isColor
          color: isColor == true ? Colors.white70 : Colors.grey, // Màu dựa trên isColor
        ),
      ],
    );
  }
}
