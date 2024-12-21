import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/app_routes.dart';
import 'package:ticket_app_final/controller/text_expansion_controller.dart';
import 'package:ticket_app_final/models/hotels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  int selectedBeds = 1;
  int selectedAdults = 1;
  int selectedChildren = 0;
  double updatedPrice = 0;
  bool isBooking = false; // Trạng thái đặt phòng

  @override
  void initState() {
    super.initState();
    updatedPrice = 0;
  }

  void updatePrice(double? basePrice) {
    setState(() {
      if (basePrice == null) {
        updatedPrice = 0;
        return;
      }
      double extraCost = 0;
      extraCost += (selectedBeds - 1) * basePrice * 0.25;
      extraCost += (selectedAdults - 1) * basePrice * 0.1667;
      extraCost += selectedChildren * basePrice * 0.125;
      updatedPrice = basePrice + extraCost;
    });
  }

  Future<void> _bookHotel(Hotel hotel, BuildContext context) async {
    if (isBooking) return; // Ngăn chặn việc đặt nhiều lần

    setState(() {
      isBooking = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng đăng nhập để đặt phòng.')),
        );
        return;
      }

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      await _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('bookHotel')
          .add({
        'destination': hotel.destination,
        'detail': hotel.detail,
        'image': hotel.image,
        'images': hotel.images,
        'place': hotel.place,
        'price': updatedPrice,
        'beds': selectedBeds,
        'adults': selectedAdults,
        'children': selectedChildren,
        'bookedAt': Timestamp.now(),
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Đặt thành công'),
          content: const Text('Khách sạn đã được đặt thành công!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.offNamed(AppRoutes.allHotels);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi đặt phòng: $e')),
      );
    } finally {
      setState(() {
        isBooking = false; // Mở khóa trạng thái
      });
    }
  }

  void _showTicketDetails(Hotel hotel) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Chi tiết vé',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildDropdownRow(
                    context,
                    setModalState,
                    title: 'Số giường:',
                    icon: Icons.bed,
                    value: selectedBeds,
                    onChanged: (value) {
                      setModalState(() {
                        selectedBeds = value!;
                        updatePrice(hotel.price ?? 0);
                      });
                    },
                  ),
                  _buildDropdownRow(
                    context,
                    setModalState,
                    title: 'Số người lớn:',
                    icon: Icons.person,
                    value: selectedAdults,
                    onChanged: (value) {
                      setModalState(() {
                        selectedAdults = value!;
                        updatePrice(hotel.price ?? 0);
                      });
                    },
                  ),
                  _buildDropdownRow(
                    context,
                    setModalState,
                    title: 'Số trẻ em:',
                    icon: Icons.child_care,
                    value: selectedChildren,
                    max: 5,
                    onChanged: (value) {
                      setModalState(() {
                        selectedChildren = value!;
                        updatePrice(hotel.price ?? 0);
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Xác nhận'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDropdownRow(BuildContext context, StateSetter setModalState,
      {required String title,
      required IconData icon,
      required int value,
      int max = 5,
      required ValueChanged<int?> onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        DropdownButton<int>(
          value: value,
          items: List.generate(
            max,
            (index) => DropdownMenuItem(
              value: index + (title == 'Số trẻ em:' ? 0 : 1),
              child: Text('${index + (title == 'Số trẻ em:' ? 0 : 1)}'),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments == null ||
        !arguments.containsKey('index') ||
        !arguments.containsKey('hotelList')) {
      return Scaffold(
        body: const Center(
          child: Text("Invalid data. Please try again."),
        ),
      );
    }

    final int index = arguments['index'];
    final List<Hotel> hotelList = arguments['hotelList'];
    final Hotel hotel = hotelList[index];
    if (updatedPrice == 0) updatedPrice = hotel.price ?? 0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(hotel.place, style: const TextStyle(fontSize: 16)),
              background: hotel.image.isNotEmpty
                  ? Image.asset(
                      'assets/images/${hotel.image}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                              child: Icon(Icons.error, color: Colors.red)),
                    )
                  : const Center(child: Text("No image available")),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ExpandedTextWidget(
                text: hotel.detail,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Hình ảnh thêm",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            hotel.images.isNotEmpty
                ? SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hotel.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/${hotel.images[index]}',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "No additional images available.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
            const SizedBox(height: 20),
          ])),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Giá từ: ${updatedPrice.toStringAsFixed(3)}đ/Đêm",
                    style: AppStyles.headLineStyle3.copyWith(fontSize: 24),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _showTicketDetails(hotel);
                          },
                          child: const Text(
                            'Chi tiết vé',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: isBooking ? null : () => _bookHotel(hotel, context),
                          child: isBooking
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text(
                                  'Đặt vé',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isBooking ? Colors.grey : Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedTextWidget extends StatelessWidget {
  final String text;
  ExpandedTextWidget({super.key, required this.text});
  final TextExpansionController controller = Get.put(TextExpansionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            maxLines: controller.isExpanded.value ? null : 3,
            overflow: controller.isExpanded.value
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: controller.toggleExpansion,
            child: Text(
              controller.isExpanded.value ? "Less" : "More",
              style: AppStyles.textStyle.copyWith(
                color: AppStyles.primaryColor,
              ),
            ),
          )
        ],
      );
    });
  }
}
