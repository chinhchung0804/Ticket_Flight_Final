import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import DateFormat
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/controller/text_expansion_controller.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

import 'package:ticket_app_final/models/order.dart'; // Import Order model
import 'package:ticket_app_final/models/book_hotel.dart'; // Import BookHotel model

class TicketOrderScreen extends StatefulWidget {
  const TicketOrderScreen({super.key});

  @override
  _TicketOrderScreenState createState() => _TicketOrderScreenState();
}

class _TicketOrderScreenState extends State<TicketOrderScreen> {
  List<orders> orderBookings = [];
  List<BookHotel> hotelBookings = [];

  @override
  void initState() {
    super.initState();
    _fetchUserBookings();
  }

  // Lấy thông tin của người dùng đã đăng nhập
  Future<void> _fetchUserBookings() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to view your bookings.')),
        );
        return;
      }

      // Lấy dữ liệu từ Firestore cho các booking của người dùng
      final ordersSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('orders') // Collection con của người dùng
          .get();
      final hotelSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('bookHotel') // Subcollection cho hotel bookings
          .get();

      // Convert snapshot data to model objects
      final orderList =
          ordersSnapshot.docs.map((doc) => orders.fromFirestore(doc)).toList();
      final hotelList = hotelSnapshot.docs
          .map((doc) => BookHotel.fromFirestore(doc))
          .toList();

      setState(() {
        orderBookings = orderList;
        hotelBookings = hotelList;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load bookings: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to HomeScreen using the route name
            Navigator.pushNamed(context, AppRoutes.homePage);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Hiển thị vé máy bay đã đặt
          if (orderBookings.isNotEmpty) ...[
            const Text(
              'Flight Bookings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...orderBookings.map((order) {
              final bookedAtFormatted = DateFormat('dd/MM/yyyy HH:mm')
                  .format(order.bookingTime.toDate());
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text('${order.from} → ${order.to}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Flight Number: ${order.flightNumber}'),
                      Text('Date: ${order.date}'),
                      Text('Departure Time: ${order.departureTime}'),
                      Text('Flying Time: ${order.flyingTime}'),
                      Text('Price: ${order.price.toStringAsFixed(3)} VND'),
                      Text('Booked At: $bookedAtFormatted'),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () {
                    // Xử lý khi người dùng nhấn vào vé (hiển thị chi tiết vé, nếu cần)
                  },
                ),
              );
            }).toList(),
          ],

          // Hiển thị khách sạn đã đặt
          if (hotelBookings.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              'Hotel Bookings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...hotelBookings.map((hotel) {
              final bookedAtFormatted = DateFormat('dd/MM/yyyy HH:mm')
                  .format(hotel.bookedAt.toDate());
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: Image.asset('assets/images/${hotel.image}',
                      width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(hotel.destination,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Place: ${hotel.place}'),
                      Text('Price: ${hotel.price.toStringAsFixed(3)} VND'),
                      Text('Booked At: $bookedAtFormatted'),
                      ExpandedTextWidget(text: ('Detail: ${hotel.detail}')),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () {
                    // Xử lý khi người dùng nhấn vào khách sạn (hiển thị chi tiết khách sạn, nếu cần)
                  },
                ),
              );
            }).toList(),
          ],
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
        maxLines: controller.isExpanded.value ? null : 3,
        overflow: controller.isExpanded.value
            ? TextOverflow.visible
            : TextOverflow.ellipsis,
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
              controller.isExpanded.value ? "Less" : "More",
              style:
                  AppStyles.textStyle.copyWith(color: AppStyles.primaryColor),
            ),
          )
        ],
      );
    });
  }
}
