import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/base/utils/firebase_data_transfer.dart';
import 'package:ticket_app_final/login/signup.dart';
import 'package:ticket_app_final/screens/home/all_hotels.dart';
import 'package:ticket_app_final/screens/home/all_tickets.dart';
import 'package:ticket_app_final/screens/home/home_screen.dart';
import 'package:ticket_app_final/screens/ticket/hotel_detail.dart';
import 'package:ticket_app_final/screens/ticket/location_detail.dart';
import 'package:ticket_app_final/screens/ticket/ticket_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
    debugPrint("Firebase Initialized Successfully!");
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }

  // Enable immersive mode to hide system UI (status bar and navigation bar)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ticket App',
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      initialRoute: AppRoutes.homeSignUp, // Initial page
      getPages: _getPages(), // List of routes
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const Scaffold(
          body: Center(
            child: Text(
              "Page not found",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  // Custom Theme Configuration
  ThemeData _buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 16),
        bodySmall: TextStyle(fontSize: 14),
      ),
    );
  }

  // List of routes for GetX
  List<GetPage> _getPages() {
    return [
      GetPage(name: AppRoutes.homeSignUp, page: () => const SignUp()),
      GetPage(name: AppRoutes.homePage, page: () => const HomeScreen()),
      GetPage(
        name: AppRoutes.ticketScreen,
        page: () => const TicketScreen(),
      ),
      GetPage(name: AppRoutes.allTickets, page: () => const AllTickets()),
      GetPage(name: AppRoutes.allHotels, page: () => const AllHotels()),
      GetPage(
        name: AppRoutes.locationDetail,
        page: () => const LocationDetail(),
      ),
      GetPage(
        name: AppRoutes.hotelDetail,
        page: () => const HotelDetail(),
      ),
    ];
  }
}
