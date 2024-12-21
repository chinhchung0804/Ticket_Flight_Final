import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/controller/text_expansion_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_app_final/models/order.dart';
import 'package:ticket_app_final/models/book_hotel.dart';

class TicketOrderScreen extends StatefulWidget {
  const TicketOrderScreen({super.key});

  @override
  _TicketOrderScreenState createState() => _TicketOrderScreenState();
}

class _TicketOrderScreenState extends State<TicketOrderScreen> {
  Stream<List<orders>> fetchOrderBookingsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('orders')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => orders.fromFirestore(doc))
            .toList());
  }

  Stream<List<BookHotel>> fetchHotelBookingsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('bookHotel')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BookHotel.fromFirestore(doc))
            .toList());
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
            Navigator.pushNamed(context, AppRoutes.homePage);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StreamBuilder<List<orders>>(
            stream: fetchOrderBookingsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Failed to load flight bookings.'));
              }

              final orderBookings = snapshot.data ?? [];

              if (orderBookings.isEmpty) {
                return const Center(child: Text('No flight bookings found.'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      ),
                    );
                  }).toList(),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          StreamBuilder<List<BookHotel>>(
            stream: fetchHotelBookingsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Failed to load hotel bookings.'));
              }

              final hotelBookings = snapshot.data ?? [];

              if (hotelBookings.isEmpty) {
                return const Center(child: Text('No hotel bookings found.'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        leading: hotel.image.isNotEmpty
                            ? Image.asset(
                                'assets/images/${hotel.image}',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported),
                              )
                            : const Icon(Icons.image_not_supported),
                        title: Text(hotel.destination,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Place: ${hotel.place}'),
                            Text('Adults: ${hotel.adults.toStringAsFixed(0)}'),
                            Text('Beds: ${hotel.beds.toStringAsFixed(0)}'),
                            Text('Children: ${hotel.children.toStringAsFixed(0)}'),
                            Text('Price: ${hotel.price.toStringAsFixed(3)} VND'),
                            Text('Booked At: $bookedAtFormatted'),
                            ExpandedTextWidget(text: hotel.detail),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  }).toList(),
                ],
              );
            },
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            maxLines: controller.isExpanded.value ? null : 3,
            overflow: controller.isExpanded.value
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: controller.toggleExpansion,
            child: Text(
              controller.isExpanded.value ? "Less" : "More",
              style: AppStyles.textStyle
                  .copyWith(color: AppStyles.primaryColor),
            ),
          )
        ],
      );
    });
  }
}
