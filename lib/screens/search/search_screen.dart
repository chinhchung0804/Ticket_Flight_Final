import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/base/widgets/app_double_text.dart';
import 'package:ticket_app_final/screens/home/home_screen.dart';
import 'package:ticket_app_final/screens/search/widgets/app_ticket_tabs.dart';
import 'package:ticket_app_final/screens/search/widgets/ticket_promotion.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Controllers cho ô nhập liệu
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Biến trạng thái tab
  bool isFirstTabSelected = true;

  // Hàm xử lý tìm kiếm
  void _findTickets() {
    final departure = _departureController.text.trim();
    final arrival = _arrivalController.text.trim();
    final location = _locationController.text.trim();

    if (isFirstTabSelected) {
      // Xử lý tìm kiếm All Tickets
      if (departure.isEmpty || arrival.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter both departure and arrival locations!"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      Navigator.pushNamed(
        context,
        AppRoutes.allTickets,
        arguments: {
          'departure': departure,
          'arrival': arrival,
        },
      );
    } else {
      // Xử lý tìm kiếm Hotels
      if (location.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a location!"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      Navigator.pushNamed(
        context,
        AppRoutes.allHotels,
        arguments: {
          'destination': location,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final listViewChildren = <Widget>[
      const SizedBox(height: 40),
      // Tiêu đề
      Text(
        "Bạn đang tìm kiếm gì?",
        style: AppStyles.headLineStyle1.copyWith(fontSize: 35),
      ),
      const SizedBox(height: 20),
      // Tabs All Tickets / Hotels
      AppTicketTabs(
        firstTab: "All Tickets",
        secondTab: "Hotels",
        onTabChanged: (isSelected) {
          setState(() {
            isFirstTabSelected = isSelected;
          });
        },
      ),
      const SizedBox(height: 25),

      // Hiển thị ô nhập liệu dựa trên tab được chọn
      if (isFirstTabSelected) ...[
        // Ô nhập địa điểm khởi hành
        TextField(
          controller: _departureController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.flight_takeoff_rounded),
            labelText: "Điểm khởi hành",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Ô nhập địa điểm đến
        TextField(
          controller: _arrivalController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.flight_land_rounded),
            labelText: "Điểm đến",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ] else ...[
        // Ô nhập địa điểm cho Hotels
        TextField(
  controller: _locationController,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.location_on),
    labelText: "Tìm địa điểm",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ỹ0-9\s]')), // Cho phép tiếng Việt, số và khoảng trắng
  ],
),
      ],
      const SizedBox(height: 25),

      // Nút tìm kiếm
      ElevatedButton(
        onPressed: _findTickets,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyles.findTicketColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Tìm kiếm',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      const SizedBox(height: 20),

      // Upcoming Flights
      AppDoubleText(
        bigText: 'Thông tin thêm',
        smallText: 'View all',
        func: () {
          Navigator.pushNamed(context, AppRoutes.allTickets);
        },
      ),
      const SizedBox(height: 15),

      // Khuyến mãi vé máy bay
      const TicketPromotion(),
    ];

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: listViewChildren,
          ),
          // Nút quay lại
          Positioned(
            top: 10,
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ
    _departureController.dispose();
    _arrivalController.dispose();
    super.dispose();
  }
}
