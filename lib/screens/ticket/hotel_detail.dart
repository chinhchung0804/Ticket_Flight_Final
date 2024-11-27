import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/controller/text_expansion_controller.dart';
import 'package:ticket_app_final/models/hotels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HotelDetail extends StatelessWidget {
  const HotelDetail({super.key});

  // Hàm để lưu khách sạn đã đặt vào Firestore (collection 'bookHotel' là subcollection của User)
  Future<void> _bookHotel(Hotel hotel, BuildContext context) async {
    try {
      // Lấy người dùng hiện tại
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to book a hotel.')),
        );
        return;
      }

      // Lấy instance của Firestore
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      // Thêm dữ liệu vào subcollection 'bookHotel' của người dùng
      await _firestore.collection('Users')
          .doc(user.uid)
          .collection('bookHotel')  // Đây là subcollection
          .add({
        'destination': hotel.destination,
        'detail': hotel.detail,
        'image': hotel.image,
        'images': hotel.images,
        'place': hotel.place,
        'price': hotel.price,
        'bookedAt': Timestamp.now(),  // Ghi nhận thời gian đặt
      });

      // Hiển thị thông báo thành công
      print('Hotel booked successfully!');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Booking Success'),
          content: const Text('Hotel has been booked successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.offNamed(AppRoutes.allHotels);  // Chuyển đến trang Tickets
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Nếu có lỗi, hiển thị thông báo lỗi
      print('Error booking hotel: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy arguments từ ModalRoute
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments == null || !arguments.containsKey('index') || !arguments.containsKey('hotelList')) {
      return Scaffold(
        body: const Center(
          child: Text("Invalid data. Please try again."),
        ),
      );
    }

    final int index = arguments['index'];
    final List<Hotel> hotelList = arguments['hotelList'];
    final Hotel hotel = hotelList[index];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(hotel.place),
      //   backgroundColor: AppStyles.primaryColor,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      body: CustomScrollView(
        slivers: [
          // Hình ảnh và tiêu đề
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(hotel.place, style: const TextStyle(fontSize: 16)),
              background: hotel.image.isNotEmpty
                  ? Image.asset(
                      'assets/images/${hotel.image}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.error, color: Colors.red)),
                    )
                  : const Center(child: Text("No image available")),
            ),
          ),
          // Thông tin chi tiết
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ExpandedTextWidget(
                    text: hotel.detail,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                hotel.images.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hotel.images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/${hotel.images[index]}',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "No additional images available.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Price: ${(hotel.price.toStringAsFixed(3))}/Đêm", 
                    style: AppStyles.headLineStyle3.copyWith(fontSize: 24),
                  ),
                ),
                
                // Nút Book Now
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Gọi hàm để lưu khách sạn vào collection 'bookHotel' của người dùng
                      _bookHotel(hotel, context);
                    },
                    child: const Text(
                      'Book Now',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.ticketOrange,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedTextWidget extends StatelessWidget {
  final String text;
  ExpandedTextWidget({super.key, required this.text});
  final TextExpansionController controller = Get.put(TextExpansionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        var textWidget = Text(
        text,
        maxLines: controller.isExpanded.value?null:3,
        overflow: controller.isExpanded.value?TextOverflow.visible:TextOverflow.ellipsis,
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget,
          GestureDetector(
            onTap: () {
              controller.toggleExpansion();
            },
            child: Text(
              controller.isExpanded.value?"Less":"More",
              style: AppStyles.textStyle.copyWith(
                color: AppStyles.primaryColor
              ),
            ),
          )
        ],
      );
    });
  }
}
