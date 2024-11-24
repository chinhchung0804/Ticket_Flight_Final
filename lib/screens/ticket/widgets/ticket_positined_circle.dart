import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';

class TicketPositinedCircle extends StatelessWidget {
  final bool? pos;
  const TicketPositinedCircle({super.key, this.pos});

  @override
  Widget build(BuildContext context) {
    return Positioned(
            left: pos==true ? 22 : null,
            right: pos==true ? null : 22,
            top: 250,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: AppStyles.textColor)
              ),
              child: CircleAvatar(
                maxRadius: 4,
                backgroundColor: AppStyles.textColor,
              )
            ),
           
          );
  }
}