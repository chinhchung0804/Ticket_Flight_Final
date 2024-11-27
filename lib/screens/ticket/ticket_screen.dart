import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/widgets/app_layout_build_widget.dart';
import 'package:ticket_app_final/base/widgets/big_circle.dart';
import 'package:ticket_app_final/base/widgets/ticket_view.dart';
import 'package:ticket_app_final/base/widgets/app_column_text_layout.dart';
import 'package:ticket_app_final/models/flight.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  // Hàm thêm vé vào Firestore
  Future<void> _addTicketToUserOrders(Flight flight, BuildContext context) async {
    try {
      // Lấy người dùng hiện tại
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to book tickets.')),
        );
        return;
      }

      // Thời gian đặt vé
      final bookingTime = Timestamp.now();

      // Dữ liệu của vé
      final ticketData = {
        'from': flight.fromName,
        'to': flight.toName,
        'flightNumber': flight.Number,
        'date': flight.date,
        'departureTime': flight.departureTime,
        'flyingTime': flight.flyingTime,
        'price': flight.price,
        'bookingTime': bookingTime,
      };

      // Lưu vé vào subcollection "orders" của người dùng
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('orders')
          .add(ticketData);

      // Thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket added to your orders successfully!')),
      );
    } catch (e) {
      // Thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book ticket: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu từ arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null || !args.containsKey('index') || !args.containsKey('flightList')) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Ticket Details"),
          backgroundColor: AppStyles.bgColor,
        ),
        body: const Center(
          child: Text('No flight data found.'),
        ),
      );
    }

    final int index = args['index'];
    final List<Flight> flightList = args['flightList'];
    final Flight flight = flightList[index];

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        title: const Text("Ticket Details"),
        backgroundColor: AppStyles.bgColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Hiển thị vé
          TicketView(
            ticket: flight,
            wholeScreen: true,
            isColor: false,
          ),
          const SizedBox(height: 24),

          // Chi tiết vé
          Container(
            decoration: BoxDecoration(
              color: AppStyles.ticketColor,
              borderRadius: BorderRadius.circular(21),
            ),
            child: Column(
              children: [
                _buildTicketDetails(flight),
                _buildBarcodeSection(flight.Number),
                _buildBuyButton(flight, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo chi tiết vé
  Widget _buildTicketDetails(Flight flight) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
          child: Row(
            children: [
              AppColumnTextLayout(
                topText: flight.fromName,
                bottomText: "From",
                alignment: CrossAxisAlignment.start,
                isColor: false,
              ),
              const Spacer(),
              AppColumnTextLayout(
                topText: flight.toName,
                bottomText: "To",
                alignment: CrossAxisAlignment.end,
                isColor: false,
              ),
            ],
          ),
        ),
        Row(
          children: [
            BigCircle(isRight: false, isColor: true),
            Expanded(
              child: AppLayoutBuildWidget(
                randomDivider: 16,
                width: 6,
                isColor: true,
              ),
            ),
            BigCircle(isRight: true, isColor: true),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
          child: Row(
            children: [
              AppColumnTextLayout(
                topText: flight.Number,
                bottomText: "Flight Number",
                alignment: CrossAxisAlignment.start,
                isColor: false,
              ),
              const Spacer(),
              AppColumnTextLayout(
                topText: flight.date,
                bottomText: "Date",
                alignment: CrossAxisAlignment.end,
                isColor: false,
              ),
            ],
          ),
        ),
        Row(
          children: [
            BigCircle(isRight: false, isColor: true),
            Expanded(
              child: AppLayoutBuildWidget(
                randomDivider: 16,
                width: 6,
                isColor: true,
              ),
            ),
            BigCircle(isRight: true, isColor: true),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
          child: Row(
            children: [
              AppColumnTextLayout(
                topText: flight.flyingTime,
                bottomText: "Flying Time",
                alignment: CrossAxisAlignment.start,
                isColor: false,
              ),
              const Spacer(),
              AppColumnTextLayout(
                topText: flight.departureTime,
                bottomText: "Departure Time",
                alignment: CrossAxisAlignment.end,
                isColor: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Hàm tạo mã vạch
  Widget _buildBarcodeSection(String flightNumber) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppStyles.ticketColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(21),
          bottomRight: Radius.circular(21),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BarcodeWidget(
          height: 120,
          data: flightNumber,
          barcode: Barcode.code128(),
          drawText: false,
          color: AppStyles.textColor,
          width: double.infinity,
          errorBuilder: (context, error) => Center(child: Text(error)),
        ),
      ),
    );
  }

  // Hàm tạo nút mua vé
  Widget _buildBuyButton(Flight flight, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          _addTicketToUserOrders(flight, context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Buy Ticket for ${flight.price.toStringAsFixed(3)}đ',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
