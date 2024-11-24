import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/media.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/all_json.dart'; // Import dữ liệu
import 'package:ticket_app_final/base/widgets/app_column_text_layout.dart';
import 'package:ticket_app_final/base/widgets/app_layout_build_widget.dart';
import 'package:ticket_app_final/base/widgets/ticket_view.dart';
import 'package:ticket_app_final/screens/search/widgets/app_ticket_tabs.dart';
import 'package:ticket_app_final/screens/ticket/widgets/ticket_positined_circle.dart';

// Thêm các hàm Firebase
Future<void> addTicketData() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  for (var ticket in ticketList) {
    await _firestore.collection('Flights').add({
      'from': ticket['from'],
      'to': ticket['to'],
      'flying_time': ticket['flying_time'],
      'date': ticket['date'],
      'thoi_gian_khoi_hanh': ticket['thoi_gian_khoi_hanh'],
      'Number': ticket['Number'],
    });
  }

  print("Ticket data added successfully!");
}

Future<void> addHotelData() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  for (var hotel in hotelList) {
    await _firestore.collection('Hotels').add({
      'image': hotel['image'],
      'place': hotel['place'],
      'destination': hotel['destination'],
      'price': hotel['price'],
      'detail': hotel['detail'],
      'images': hotel['images'],
    });
  }

  print("Hotel data added successfully!");
}

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
} 

class _TicketScreenState extends State<TicketScreen> {
  late int ticketIndex = 0;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      ticketIndex = args["index"];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        title: const Text("Tickets"),
        backgroundColor: AppStyles.bgColor,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            children: [
              const AppTicketTabs(
                firstTab: "Upcoming",
                secondTab: "Previous",
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: TicketView(ticket: ticketList[ticketIndex], isColor: true),
              ),
              const SizedBox(height: 1,), 
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                color: AppStyles.ticketColor,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppColumnTextLayout(
                            topText: "Flutter DB", 
                            bottomText: "Passenger", 
                            alignment: CrossAxisAlignment.start,
                            isColor: true,
                        ),
                        AppColumnTextLayout(
                            topText: "5221 36869", 
                            bottomText: "Passport", 
                            alignment: CrossAxisAlignment.end,
                            isColor: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const AppLayoutBuildWidget(randomDivider: 15, width: 5, isColor: false),
                    const SizedBox(height: 20,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppColumnTextLayout(
                            topText: "2465 658494046865", 
                            bottomText: "NUmber of E-ticket", 
                            alignment: CrossAxisAlignment.start,
                            isColor: true,
                        ),
                        AppColumnTextLayout(
                            topText: "B46859", 
                            bottomText: "Booking code", 
                            alignment: CrossAxisAlignment.end,
                            isColor: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const AppLayoutBuildWidget(randomDivider: 15, width: 5, isColor: false),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppMedia.logoVisa,
                                  scale: 3,
                                ), 
                                Text(" *** 24462", style: AppStyles.headLineStyle3,)
                              ],
                            ),
                            Text("Payment method", style: AppStyles.headLineStyle4,)
                          ]
                        ),
                        const AppColumnTextLayout(
                            topText: "1.000.000d",
                            bottomText: "Price", 
                            alignment: CrossAxisAlignment.end,
                            isColor: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 1,), 
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppStyles.ticketColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(21),
                    bottomRight: Radius.circular(21),
                  )
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BarcodeWidget(
                      height: 70,
                      data: "https://dbestech.com", 
                      barcode: Barcode.code128(),
                      drawText: false,
                      color: AppStyles.textColor,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              // Thêm nút để gọi hàm addTicketData và addHotelData
              ElevatedButton(
                onPressed: () {
                  addTicketData();  // Thêm dữ liệu vé máy bay vào Firestore
                  addHotelData();   // Thêm dữ liệu khách sạn vào Firestore
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Dữ liệu đã được thêm vào Firestore!')),
                  );
                },
                child: Text('Add Data to Firestore'),
              ),
            ],
          ),
          const TicketPositinedCircle(pos: true),
          const TicketPositinedCircle(pos: null),
        ],
      ),
    );
  }
}
