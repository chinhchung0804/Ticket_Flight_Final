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
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final String? departure = arguments?['departure']?.trim();
    final String? arrival = arguments?['arrival']?.trim();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tickets"),
        backgroundColor: AppStyles.bgColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Flights').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tickets found.'));
          }

          final ticketsDocs = snapshot.data!.docs;

          final List<Flight> allFlights = ticketsDocs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Flight.fromMap(data);
          }).toList();

          // Lọc danh sách theo departure và arrival
          final List<Flight> filteredFlights =
              (departure != null && arrival != null)
                  ? allFlights.where((flight) {
                      final flightFromCode =
                          flight.fromCode.trim().toLowerCase();
                      final flightToCode = flight.toCode.trim().toLowerCase();
                      final inputDeparture = departure.trim().toLowerCase();
                      final inputArrival = arrival.trim().toLowerCase();

                      return flightFromCode == inputDeparture &&
                          flightToCode == inputArrival;
                    }).toList()
                  : allFlights;

          if (filteredFlights.isEmpty) {
            return const Center(
                child: Text('No tickets match your search criteria.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredFlights.length,
            itemBuilder: (context, index) {
              final flight = filteredFlights[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.ticketScreen,
                    arguments: {
                      "index": index,
                      "flightList": filteredFlights,
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TicketView(
                    ticket: flight,
                    wholeScreen: true,
                    isColor: false,
                    hideDetails: false,
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
