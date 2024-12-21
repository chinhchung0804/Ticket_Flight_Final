import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/media.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/models/flight.dart';

class TicketPromotion extends StatelessWidget {
  const TicketPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Flights').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: AppStyles.headLineStyle2.copyWith(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No tickets found.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final ticketsDocs = snapshot.data!.docs;

        final List<Flight> allFlights = ticketsDocs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Flight.fromMap(data);
        }).toList();

        // Lọc danh sách để loại bỏ các fromName trùng lặp
        final List<Flight> uniqueFlights = [];
        final Set<String> seenFromNames = {};

        for (var flight in allFlights) {
          if (!seenFromNames.contains(flight.fromName)) {
            uniqueFlights.add(flight);
            seenFromNames.add(flight.fromName);
          }
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cột bên trái
            Flexible(
              flex: 2, // Tỷ lệ kích thước giữa các cột
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                height: 435,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AppMedia.gheNgoi),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Giảm giá 20% khi đặt vé sớm cho chuyến bay này. Đừng bỏ lỡ!",
                      style: AppStyles.headLineStyle2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 15), // Khoảng cách giữa hai cột

            // Cột bên phải
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Danh sách chuyến bay
                  Container(
                    height: 300, // Chiều cao cố định cho danh sách
                    decoration: BoxDecoration(
                      color: const Color(0xFF3AB8B8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        // Dòng tiêu đề
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "MÃ CODE",
                            style: AppStyles.headLineStyle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Danh sách chuyến bay
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(15),
                            itemCount: uniqueFlights.length,
                            itemBuilder: (context, index) {
                              final flight = uniqueFlights[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${flight.fromCode} : ${flight.fromName}",
                                          style:
                                              AppStyles.headLineStyle2.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15), // Khoảng cách giữa các phần

                  // Card "Take Love"
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35),
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEC6545),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Take Love",
                          style: AppStyles.headLineStyle2
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: "😍", style: TextStyle(fontSize: 32)),
                            TextSpan(
                                text: "🥰", style: TextStyle(fontSize: 45)),
                            TextSpan(
                                text: "😘", style: TextStyle(fontSize: 32)),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
