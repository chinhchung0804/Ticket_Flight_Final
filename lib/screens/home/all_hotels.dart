import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/models/hotels.dart';

class AllHotels extends StatelessWidget {
  const AllHotels({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy điều kiện tìm kiếm từ arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final String? searchDestination = arguments?['destination']?.trim();

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        title: const Text(
          "All Hotels",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppStyles.bgColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: searchDestination == null
              ? FirebaseFirestore.instance.collection('Hotels').snapshots()
              : FirebaseFirestore.instance
                  .collection('Hotels')
                  .where('destination', isEqualTo: searchDestination)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No hotels match your search.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            // Lấy danh sách Hotel từ Firestore
            final hotelList = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Hotel.fromMap(data);
            }).toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              itemCount: hotelList.length,
              itemBuilder: (context, index) {
                return HotelGridView(
                  hotel: hotelList[index],
                  index: index,
                  hotelList: hotelList,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class HotelGridView extends StatelessWidget {
  final Hotel hotel;
  final int index;
  final List<Hotel> hotelList;

  const HotelGridView({
    super.key,
    required this.hotel,
    required this.index,
    required this.hotelList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.hotelDetail,
          arguments: {
            "index": index,
            "hotelList": hotelList,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
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
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/${hotel.image}"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${hotel.place} - ${hotel.destination}",
              style: AppStyles.headLineStyle3
                  .copyWith(color: AppStyles.kakiColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              "Giá từ: ${hotel.price.toStringAsFixed(3)}đ/Đêm",
              style: AppStyles.headLineStyle3.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}