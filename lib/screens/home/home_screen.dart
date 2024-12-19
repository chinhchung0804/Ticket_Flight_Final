import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:ticket_app_final/base/res/media.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/base/widgets/app_double_text.dart';
import 'package:ticket_app_final/base/widgets/image_helper.dart';
import 'package:ticket_app_final/controller/bottom_nav_controller.dart';
import 'package:ticket_app_final/models/popular_location.dart';
import 'package:ticket_app_final/screens/search/search_screen.dart';
import 'package:ticket_app_final/screens/ticket/ticket_order_screen.dart';
import 'package:ticket_app_final/screens/profile/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<Map<String, dynamic>> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return {};

    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
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

  Widget _buildItemCategory(
      Widget icon, Color color, Function() onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: icon,
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(title)
        ],
      ),
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
        final name = userData['name'] ?? 'Guest';

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              _buildHeader(name),
              const SizedBox(height: 30),
              _buildSearchBar(context),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildItemCategory(
                      ImageHelper.loadFromAsset(
                        'assets/images/hotel.jpg',
                        width: 80,
                        height: 80,
                      ),
                      const Color(0xffFE9C5E),
                      () =>
                          Navigator.of(context).pushNamed(AppRoutes.allHotels),
                      'Hotels',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildItemCategory(
                      ImageHelper.loadFromAsset(
                        'assets/images/flights.png',
                        width: 80,
                        height: 80,
                      ),
                      const Color(0xffF77777),
                      () =>
                          Navigator.of(context).pushNamed(AppRoutes.allTickets),
                      'Flights',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              AppDoubleText(
                bigText: 'Popular Destinations',
                smallText: 'See all',
                func: () => Navigator.pushNamed(context, AppRoutes.allHotels),
              ),
              const SizedBox(height: 20),
              _buildPopularLocationStream(context),
            ],
          ),
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
  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
       onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
    },
      child: Container(
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
      ),
    );
  }

  Widget _buildPopularLocationStream(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('PopularLocations').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        debugPrint("Error fetching PopularLocations: ${snapshot.error}");
        return const Center(child: Text("An error occurred while fetching data."));
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(child: Text("No popular locations available."));
      }

      // Chuyển đổi dữ liệu từ Firestore thành danh sách các đối tượng PopularLocations
      final List<PopularLocations> locations = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Xử lý dữ liệu bị thiếu bằng cách cung cấp giá trị mặc định
        return PopularLocations(
          name: data['name'] ?? 'Unknown Location',
          image: data['image'] ?? '',
          description: data['description'] ?? '',
          images: List<String>.from(data['images'] ?? []),
          airport: data['airport'] ?? 'Unknown',
        );
      }).toSet().toList(); // Loại bỏ trùng lặp nếu cần

      return ListView.builder(
        shrinkWrap: true, // Cho phép ListView vừa với nội dung
        physics: const NeverScrollableScrollPhysics(), // Tránh xung đột cuộn
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.locationDetail,
              arguments: {
                'index': index,
                'locations': locations,
              },
            ),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Stack(
                children: [
                  // Hình ảnh địa điểm
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: location.image.isNotEmpty
                        ? Image.asset(
                            'assets/images/${location.image}',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 80),
                          )
                        : Container(
                            height: 200,
                            color: Colors.grey,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 80),
                            ),
                          ),
                  ),

                  // Tên địa điểm nằm trên hình ảnh
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        location.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
    return Expanded(
      child: SingleChildScrollView(
        child: Row(
          children: items.take(3).map((item) {
            final index = items.indexOf(item);
            return GestureDetector(
              onTap: () => onTap(index),
              child: builder(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}
