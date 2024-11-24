import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/utils/all_json.dart';
import 'package:ticket_app_final/controller/text_expansion_controller.dart';
import 'package:get/get.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  late int index=0;

  @override
  void didChangeDependencies() {
    if(ModalRoute.of(context)!.settings.arguments!=null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      index = args['index'];
    }
      super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyles.primaryColor
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              // title: Text(hotelList[index]["place"]),
              background: Stack(
                children: [
                  Positioned.fill(child: Image.asset("assets/images/${hotelList[index]["image"]}",
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        hotelList[index]["place"],
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          shadows: [ 
                            Shadow(
                              blurRadius: 10.0,
                              color: AppStyles.primaryColor,
                              offset: const Offset(2.0, 2.0)
                            )
                          ]
                        ),
                      )
                    ),
                  )
                ],
              )
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ExpandedTextWidget(
                  text: hotelList[index]["detail"]
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "More image",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              SizedBox(
                height: 200.0,
                child: ListView.builder(
                  itemCount: hotelList[index]["images"].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, imagesIndex) {
                  return Container(
                    margin: const EdgeInsets.all(16.0),
                    color: Colors.red,
                    child: Image.asset(
                      "assets/images/${hotelList[index]["images"][imagesIndex]}"
                    )
                  );
                }),
              )
            ]
          ))
        ],
      )
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
        maxLines: controller.isExpanded.value?null:3,
        overflow: controller.isExpanded.value?TextOverflow.visible:TextOverflow.ellipsis,
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
              controller.isExpanded.value?"Less":"More",
              style: AppStyles.textStyle.copyWith(
                color: AppStyles.primaryColor
              ),
            ),
          )
        ],
      );
    });
  }
}