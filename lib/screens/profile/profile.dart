import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/media.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/widgets/app_column_text_layout.dart';
import 'package:ticket_app_final/base/widgets/heading_text.dart';
import 'package:ticket_app_final/base/widgets/text_style_third.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: AppStyles.bgColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const Padding(padding: EdgeInsets.only(top: 40)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: 
                      AssetImage(AppMedia.logo),
                        fit: BoxFit.cover,
                  )
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingText(text: "Book Tickets", isColor: false,),
                    Text("Đà Nẵng", style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500
                    ),),
                    const SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppStyles.profileLocationColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppStyles.profileTextColor,
                            ),
                            child: const Icon(
                              FluentSystemIcons.ic_fluent_shield_filled,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text("Premium status", style: TextStyle(color: AppStyles.profileTextColor, fontWeight: FontWeight.w500),)
                        ],
                      )
                    )
                  ],
                ),
                Expanded(child: Container(
                  
                )),
                Text("Edit", style: TextStyle(
                  color: AppStyles.primaryColor, 
                  fontWeight: FontWeight.w300
                ),)
              ],
            ),
            const SizedBox(height: 8,),
            Divider(color: Colors.grey.shade300,),
      
            Stack(
              children: [
                Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor,
                    borderRadius: BorderRadius.circular(18) 
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(
                          FluentSystemIcons.ic_fluent_lightbulb_filament_filled,
                          color: AppStyles.primaryColor,
                          size: 27,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextStyleThird(
                            text: "Bạn có một giải thưởng mới", 
                            isColor: null,
                          ), 
                          Text(
                            "Bạn có 50 chuyến bay trong một năm",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.8)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: -40,
                  right: -45,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 18, color: const Color(0xFF264CD2))
                    ),
                ))
              ],
            ),
            const SizedBox(height: 25,),
            Text("Dặm tích lũy", style: AppStyles.headLineStyle2,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: AppStyles.bgColor
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  Text("192802", style: TextStyle(
                    fontSize: 45, 
                    color: AppStyles.textColor,
                    fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 25,),
                  //row-text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [
                      Text(
                        "Dặm tích lũy",
                        style: AppStyles.headLineStyle4.copyWith(fontSize: 16),
                      ),
                      Text(
                        "16/7",
                        style: AppStyles.headLineStyle4.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Divider(color: Colors.grey.shade300,),
                  const SizedBox(height: 8,),
                  // row-column
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppColumnTextLayout(
                        topText: "23 402", 
                        bottomText: "Dặm", 
                        alignment: CrossAxisAlignment.start,
                        isColor: false,
                      ),
                      AppColumnTextLayout(
                        topText: "Hãng hàng không CO", 
                        bottomText: "Nhận được từ", 
                        alignment: CrossAxisAlignment.end,
                        isColor: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppColumnTextLayout(
                        topText: "24", 
                        bottomText: "Dặm", 
                        alignment: CrossAxisAlignment.start,
                        isColor: false,
                      ),
                      AppColumnTextLayout(
                        topText: "McDoanal's", 
                        bottomText: "Nhận được từ", 
                        alignment: CrossAxisAlignment.end,
                        isColor: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppColumnTextLayout(
                        topText: "52 340", 
                        bottomText: "Dặm", 
                        alignment: CrossAxisAlignment.start,
                        isColor: false,
                      ),
                      AppColumnTextLayout(
                        topText: "DBestech", 
                        bottomText: "Nhận được từ", 
                        alignment: CrossAxisAlignment.end,
                        isColor: false,
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
      
                    },
                    child: Text(
                      "Làm thế nào để có thêm dặm",
                      style: AppStyles.textStyle.copyWith(
                        color: AppStyles.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}