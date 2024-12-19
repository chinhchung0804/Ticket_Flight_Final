import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/controller/text_expansion_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app_final/models/popular_location.dart';

class LocationDetail extends StatelessWidget {
  const LocationDetail({super.key});

  // Hàm để lưu địa điểm yêu thích vào Firestore (chung cho tất cả khách hàng)
  Future<void> _favoriteLocation(
      PopularLocations location, BuildContext context) async {
    try {
      // Lấy instance của Firestore
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      // Thêm dữ liệu vào collection 'favoriteLocations'
      await _firestore.collection('PopularLocations').add({
        'name': location.name,
        'description': location.description,
        'image': location.image,
        'images': location.images,
        'airport': location.airport,
      });
    } catch (e) {
      // Nếu có lỗi, hiển thị thông báo lỗi
      print('Error saving location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy arguments từ ModalRoute
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments == null ||
        !arguments.containsKey('index') ||
        !arguments.containsKey('locations')) {
      return Scaffold(
        body: const Center(
          child: Text("Invalid data. Please try again."),
        ),
      );
    }

    final int index = arguments['index'];
    final List<PopularLocations> locations = arguments['locations'];
    final PopularLocations location = locations[index];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hình ảnh và tiêu đề
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
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
              background: location.image.isNotEmpty
                  ? Image.asset(
                      'assets/images/${location.image}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                              child: Icon(Icons.error, color: Colors.red)),
                    )
                  : const Center(child: Text("No image available")),
            ),
          ),

          // Thông tin chi tiết
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ExpandedTextWidget(
                    text: location.description,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Hình ảnh thêm",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                location.images.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: location.images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/${location.images[index]}',
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Sân bay: ${location.airport}",
                    style: AppStyles.headLineStyle3.copyWith(fontSize: 20),
                  ),
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
      var textWidget = Text(
        text,
        maxLines: controller.isExpanded.value ? null : 3,
        overflow: controller.isExpanded.value
            ? TextOverflow.visible
            : TextOverflow.ellipsis,
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget,
          GestureDetector(
            onTap: () {
              controller.toggleExpansion();
            },
            child: Text(
              controller.isExpanded.value ? "Less" : "More",
              style:
                  AppStyles.textStyle.copyWith(color: AppStyles.primaryColor),
            ),
          )
        ],
      );
    });
  }
}
