import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/media.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/base/widgets/app_double_text.dart';
import 'package:ticket_app_final/base/widgets/heading_text.dart';
import 'package:ticket_app_final/base/widgets/ticket_view.dart';
import 'package:ticket_app_final/screens/home/widgets/hotel.dart';
import 'package:ticket_app_final/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'package:ticket_app_final/screens/profile/profile.dart';
import 'package:ticket_app_final/screens/search/search_screen.dart';
import 'package:ticket_app_final/screens/ticket/ticket_screen.dart';
import 'package:ticket_app_final/models/flight.dart'; // Import your Flight model
import 'package:ticket_app_final/models/hotels.dart';  // Import your Hotel model

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            _buildHomePage(context),
            const SearchScreen(),
            const TicketScreen(),
            const ProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onItemTapped,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: const Color(0xFF526400),
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
              label: "Tickets",
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "Profile",
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 40),
        // Header Section
        _buildHeader(),
        const SizedBox(height: 25),
        // Search Bar
        _buildSearchBar(),
        const SizedBox(height: 40),
        // Upcoming Flights Section
        AppDoubleText(
          bigText: 'Upcoming Flights',
          smallText: 'View all',
          func: () => Navigator.pushNamed(context, AppRoutes.allTickets),
        ),
        const SizedBox(height: 20),
        // Stream for Flights
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('flights').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No flights available."));
            }

            var flightList = snapshot.data!.docs.map((doc) {
              return Flight.fromFirestore(doc.data() as Map<String, dynamic>);
            }).toList();

            return _buildHorizontalList(
              items: flightList,
              builder: (flight) => TicketView(ticket: flight), // Ensure TicketView is compatible with Flight model
              onTap: (index) => Navigator.pushNamed(
                context,
                AppRoutes.ticketScreen,
                arguments: {"index": index},
              ),
            );
          },
        ),
        const SizedBox(height: 40),
        // Hotels Section
        AppDoubleText(
          bigText: 'Hotels',
          smallText: 'View all',
          func: () => Navigator.pushNamed(context, AppRoutes.allHotels),
        ),
        const SizedBox(height: 20),
        // Stream for Hotels
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No hotels available."));
            }

            var hotelList = snapshot.data!.docs.map((doc) {
              return Hotel.fromFirestore(doc.data() as Map<String, dynamic>);
            }).toList();

            return _buildHorizontalList(
              items: hotelList,
              builder: (hotel) => Hotel(hotel: hotel), // Ensure Hotel widget is compatible with Hotel model
              onTap: (index) => Navigator.pushNamed(
                context,
                AppRoutes.hotelDetail,
                arguments: {"index": index},
              ),
            );
          },
        ),
      ],
    );
  }

  // Header Section Widget
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, guy", style: AppStyles.headLineStyle3),
            const SizedBox(height: 5),
            const HeadingText(text: "Book Tickets", isColor: false),
          ],
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(AppMedia.logo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF4F6FD),
      ),
      child: Row(
        children: const [
          Icon(
            FluentSystemIcons.ic_fluent_search_regular,
            color: Color(0xFFBFC205),
          ),
          SizedBox(width: 10),
          Text(
            "Search",
            style: TextStyle(fontSize: 16, color: Color(0xFFBFC205)),
          ),
        ],
      ),
    );
  }

  // Horizontal List Builder
  Widget _buildHorizontalList<T>({
    required List<T> items,
    required Widget Function(T) builder,
    required Function(int) onTap,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.take(3).map((item) {
          final index = items.indexOf(item);
          return GestureDetector(
            onTap: () => onTap(index),
            child: builder(item),
          );
        }).toList(),
      ),
    );
  }
}
