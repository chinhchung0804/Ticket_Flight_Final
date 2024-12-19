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

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
   String? selectedDate;
  String? discountCode; // Mã giảm giá
  double totalPrice = 0.0; // Tổng tiền vé
  List<String> selectedSeats = []; // Danh sách ghế đã chọn

  // Hàm thêm vé vào Firestore
  Future<void> _addTicketToUserOrders(Flight flight, BuildContext context) async {
  try {
    // Lấy thông tin người dùng đã đăng nhập
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to book tickets.')),
      );
      return;
    }

    // Kiểm tra ngày bay và ghế ngồi đã chọn
    if (selectedDate == null || selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date and at least one seat.')),
      );
      return;
    }

    // Tạo dữ liệu vé
    final ticketData = {
      'from': flight.fromName,
      'to': flight.toName,
      'departureTime': flight.departureTime,
      'flyingTime': flight.flyingTime,
      'date': selectedDate,
      'flightNumber': selectedSeats,
      'discountCode': discountCode ?? '',
      'price': totalPrice,
      'bookingTime': Timestamp.now(), // Thời gian đặt vé
    };

    // Lưu vào subcollection "orders" của người dùng trong Firestore
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('orders')
        .add(ticketData);

    // Thông báo khi lưu thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket booked successfully!')),
    );

    // Điều hướng về màn hình chính hoặc màn hình thành công (tuỳ chọn)
    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to book ticket: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu từ arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null ||
        !args.containsKey('index') ||
        !args.containsKey('flightList')) {
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

          // Chi tiết vé với các trường tùy chọn
          Container(
            decoration: BoxDecoration(
              color: AppStyles.ticketColor,
              borderRadius: BorderRadius.circular(21),
            ),
            child: Column(
              children: [
                _buildTicketDetails(flight),
                _buildDatePicker(),
                _buildSeatPicker(flight),
                _buildDiscountField(flight),
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
                bottomText: "Từ",
                topText: flight.fromName,
                alignment: CrossAxisAlignment.start,
                isColor: false,
              ),
              const Spacer(),
              AppColumnTextLayout(
                bottomText: "Thời gian khởi hành",
                topText: flight.departureTime,
                alignment: CrossAxisAlignment.center,
                isColor: false,
              ),
              const Spacer(),
              AppColumnTextLayout(
                bottomText: "Đến",
                topText: flight.toName,
                alignment: CrossAxisAlignment.end,
                isColor: false,
              ),
            ],
          ),
        ),
        const Row(
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
      ],
    );
  }

  // Hàm tạo picker cho ngày bay
  Widget _buildDatePicker() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Chọn ngày", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Màu nền của button
            foregroundColor: Colors.black, // Màu chữ và icon
            side: const BorderSide(color: Colors.grey), // Viền
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );

            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate.toString().split(' ')[0];
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate ?? "Chọn ngày",
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ],
    ),
  );
}

   Widget _buildSeatPicker(Flight flight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Chọn chỗ ngồi", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 55,
              itemBuilder: (context, index) {
                final seatNumber = (index + 1).toString();
                final isSelected = selectedSeats.contains(seatNumber);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedSeats.remove(seatNumber);
                      } else {
                        selectedSeats.add(seatNumber);
                      }
                      _updateTotalPrice(flight); // Cập nhật tổng tiền khi chọn/bỏ ghế
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blueGrey : Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      seatNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            selectedSeats.isNotEmpty
                ? "Chọn chỗ ngồi: ${selectedSeats.join(", ")}"
                : "Chưa chọn chỗ ngồi",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _updateTotalPrice(Flight flight) {
    setState(() {
      totalPrice = flight.price * selectedSeats.length; // Giá vé * số ghế
      if (discountCode != null && discountCode == "DISCOUNT20") {
        totalPrice *= 0.8; // Áp dụng giảm 10%
      }
    });
  }

  // Hàm tạo nút mua vé
   void _applyDiscount(Flight flight) {
    setState(() {
      _updateTotalPrice(flight); // Cập nhật lại tổng tiền khi nhập mã giảm giá
    });
  }

   // Widget nhập mã giảm giá
  Widget _buildDiscountField(Flight flight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nhập mã giảm giá", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: "Nhập mã giảm giá của bạn",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (value) {
              discountCode = value.trim();
              _applyDiscount(flight); // Áp dụng chiết khấu khi nhập mã giảm giá
            },
          ),
        ],
      ),
    );
  }

  // Nút mua vé
  Widget _buildBuyButton(Flight flight, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          if (selectedSeats.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Vui lòng chọn ít nhất 1 chỗ ngồi')),
            );
            return;
          }
          _addTicketToUserOrders(flight, context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          'Đặt vé với ${totalPrice.toStringAsFixed(3)}đ',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}