import 'package:flutter/material.dart';
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

  // Hàm xử lý tìm kiếm
  void _findTickets() {
    final departure = _departureController.text.trim();
    final arrival = _arrivalController.text.trim();

    if (departure.isEmpty || arrival.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both departure and arrival locations!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Chuyển đến màn hình "AllTickets" và truyền tham số
    Navigator.pushNamed(
      context,
      AppRoutes.allTickets,
      arguments: {'departure': departure, 'arrival': arrival},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: Stack(
        children: [
          // Nội dung chính
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              const SizedBox(height: 40),
              // Tiêu đề
              Text(
                "Bạn đang tìm kiếm gì?",
                style: AppStyles.headLineStyle1.copyWith(fontSize: 35),
              ),
              const SizedBox(height: 20),
              // Tabs All Tickets / Hotels
              const AppTicketTabs(
                firstTab: "All Tickets",
                secondTab: "Hotels",
              ),
              const SizedBox(height: 25),

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
                  'Tìm kiếm vé',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),

              // Upcoming Flights
              AppDoubleText(
                bigText: 'Upcoming Flights',
                smallText: 'View all',
                func: () {
                  Navigator.pushNamed(context, AppRoutes.allTickets);
                },
              ),
              const SizedBox(height: 15),

              // Khuyến mãi vé máy bay
              const TicketPromotion(),
            ],
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
