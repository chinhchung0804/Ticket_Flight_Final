import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app_final/base/res/media.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/base/widgets/app_double_text.dart';
import 'package:ticket_app_final/base/widgets/heading_text.dart';
import 'package:ticket_app_final/base/widgets/ticket_view.dart';
import 'package:ticket_app_final/controller/bottom_nav_controller.dart';
import 'package:ticket_app_final/models/flight.dart';
import 'package:ticket_app_final/models/hotels.dart';
import 'package:ticket_app_final/screens/home/widgets/hotel_widget.dart';
import 'package:ticket_app_final/screens/search/search_screen.dart';
import 'package:ticket_app_final/screens/ticket/ticket_order_screen.dart';
import 'package:ticket_app_final/screens/profile/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<Map<String, dynamic>> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return {};

    final doc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
    return doc.data() ?? {};
  }

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
            const TicketOrderScreen(),
            ProfileScreen(userId: FirebaseAuth.instance.currentUser!.uid),
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

  // Home Page Content
  Widget _buildHomePage(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data ?? {};
        final name = userData['name'] ?? 'Guest';  // Default to 'Guest' if name is not found

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 40),
            _buildHeader(name), // Display the user's name
            const SizedBox(height: 25),
            _buildSearchBar(),
            const SizedBox(height: 40),
            AppDoubleText(
              bigText: 'Upcoming Flights',
              smallText: 'View all',
              func: () => Navigator.pushNamed(context, AppRoutes.allTickets),
            ),
            const SizedBox(height: 20),
            _buildFlightStream(context),  // Display the flight list
            const SizedBox(height: 40),
            AppDoubleText(
              bigText: 'Hotels',
              smallText: 'View all',
              func: () => Navigator.pushNamed(context, AppRoutes.allHotels),
            ),
            const SizedBox(height: 20),
            _buildHotelStream(context),  // Display the hotel list
          ],
        );
      },
    );
  }

  // Header Section Widget
  Widget _buildHeader(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, $name", style: AppStyles.headLineStyle3),
            const SizedBox(height: 5),
            Text("Welcome to our Travel app", style: AppStyles.headLineStyle4),
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
      child: const Row(
        children: [
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

  // Flight Stream
  Widget _buildFlightStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Flights').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No flights available."));
        }

        var flightList = snapshot.data!.docs.map((doc) {
          return Flight.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        return _buildHorizontalList(
          items: flightList,
          builder: (flight) => TicketView(ticket: flight),
          onTap: (index) => Navigator.pushNamed(
            context,
            AppRoutes.ticketScreen,
            arguments: {
              'index': index,
              'flightList': flightList,
            },
          ),
        );
      },
    );
  }

  // Hotel Stream
  Widget _buildHotelStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Hotels').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No hotels available."));
        }

        var hotelList = snapshot.data!.docs.map((doc) {
          return Hotel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        return _buildHorizontalList(
          items: hotelList,
          builder: (hotel) => HotelWidget(hotel: hotel),
          onTap: (index) => Navigator.pushNamed(
            context,
            AppRoutes.hotelDetail,
            arguments: {
              'index': index,
              'hotelList': hotelList,
            },
          ),
        );
      },
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

