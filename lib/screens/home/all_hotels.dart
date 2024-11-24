import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/all_json.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';

class AllHotels extends StatelessWidget {
  const AllHotels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        title: const Text("All Hotels"),
        backgroundColor: AppStyles.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.9
          ),
          itemCount: hotelList.length,
          itemBuilder: (context, index) {
            var singleHotel = hotelList[index];
            return HotelGridView(
              hotel: singleHotel,
              index: index
            );
          }
        ),
      ),
    );
  }
}

class HotelGridView extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final int index;
  const HotelGridView({super.key, required this.hotel, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        
        Navigator.pushNamed(context, AppRoutes.hotelDetail, arguments: {
          "index": index
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        // width: size.width*0.6,
        height: 350,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: AppStyles.primaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
      
              aspectRatio: 1.2,
              child: Container(
                
                decoration: BoxDecoration(
                  color: AppStyles.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/${hotel['image']}")
                  ),
                ),
              ),
            ),
      
            const SizedBox(height: 5,),
            Row(
              children: [
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    hotel['place'],
                    style: AppStyles.headLineStyle3.copyWith(color: AppStyles.kakiColor),
                  ),
                ),
                const SizedBox(width: 2,),
                Text("-", style: AppStyles.underscoreStyle.copyWith(color: AppStyles.kakiColor),),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    hotel['destination'],
                    style: AppStyles.headLineStyle3.copyWith(color: AppStyles.kakiColor),
                  ),
                ),
                
              ],
            ),
            const SizedBox(height: 5,),
            Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  "${hotel['price']}/Đêm",
                  style: AppStyles.headLineStyle3.copyWith(color: Colors.white),
                  ),
                ),
            
            
          ],
        ),
      ),
    );
  }
}