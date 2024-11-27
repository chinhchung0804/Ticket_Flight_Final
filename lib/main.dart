import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemChrome
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/login/signup.dart';
import 'package:ticket_app_final/screens/home/all_hotels.dart';
import 'package:ticket_app_final/screens/home/all_tickets.dart';
import 'package:ticket_app_final/screens/home/home_screen.dart';
import 'package:ticket_app_final/screens/ticket/hotel_detail.dart';
import 'package:ticket_app_final/screens/ticket/ticket_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
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
    return MaterialApp(
      title: 'Ticket App',
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      initialRoute: AppRoutes.homeSignUp, // Trang bắt đầu
      onGenerateRoute: _generateRoute,
    );
  }

  // Custom Theme Configuration
  ThemeData _buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto', // Cài đặt font mặc định (nếu cần)
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 16),
        bodySmall: TextStyle(fontSize: 14),
      ),
    );
  }

  // Generate Routes Dynamically
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case AppRoutes.homeSignUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.ticketScreen:
        return MaterialPageRoute(
          builder: (_) => const TicketScreen(),
          settings: settings,
        );
      case AppRoutes.allTickets:
        return MaterialPageRoute(builder: (_) => const AllTickets());
      case AppRoutes.allHotels:
        return MaterialPageRoute(builder: (_) => const AllHotels());
      case AppRoutes.hotelDetail:
        return MaterialPageRoute(
          builder: (_) => const HotelDetail(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }
}
