import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/base/widgets/ticket_view.dart';
import 'package:ticket_app_final/models/flight.dart';

class AllTickets extends StatelessWidget {
  const AllTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tickets"),
        backgroundColor: AppStyles.bgColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Kết nối tới Firestore để lắng nghe dữ liệu từ bộ sưu tập 'Flights'
        stream: FirebaseFirestore.instance.collection('Flights').snapshots(),
        builder: (context, snapshot) {
          // Hiển thị vòng tròn tải khi chờ dữ liệu
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Xử lý khi có lỗi
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Xử lý khi không có dữ liệu
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tickets found.'));
          }

          // Lấy danh sách vé từ Firestore
          final ticketsDocs = snapshot.data!.docs;

          // Ánh xạ dữ liệu từ Firestore thành danh sách `Flight`
          final List<Flight> flights = ticketsDocs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Flight.fromMap(data);
          }).toList();

          // Hiển thị danh sách vé
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return GestureDetector(
                onTap: () {
                  // Chuyển tới TicketScreen khi bấm vào vé
                  Navigator.pushNamed(
                    context,
                    AppRoutes.ticketScreen,
                    arguments: {
                      "index": index,          // Chỉ số vé được chọn
                      "flightList": flights,   // Toàn bộ danh sách vé
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TicketView(
                    ticket: flight,
                    wholeScreen: true,
                    isColor: false,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
