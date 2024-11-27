import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/models/hotels.dart'; // Import model Hotel

class HotelWidget extends StatelessWidget {
  final Hotel hotel; // Sử dụng đối tượng Hotel thay vì Map
  const HotelWidget({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width * 0.6,
      height: 320,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppStyles.primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần hình ảnh
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppStyles.primaryColor,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/${hotel.image}"),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Tên địa điểm
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              hotel.place,
              style: AppStyles.headLineStyle1.copyWith(color: AppStyles.kakiColor),
            ),
          ),

          const SizedBox(height: 5),

          // Điểm đến
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              hotel.destination,
              style: AppStyles.headLineStyle3.copyWith(color: Colors.white),
            ),
          ),

          const SizedBox(height: 5),

          // Giá
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "${hotel.price.toStringAsFixed(3)}/Đêm",
              style: AppStyles.headLineStyle1.copyWith(color: AppStyles.kakiColor),
            ),
          ),
        ],
      ),
    );
  }
}
