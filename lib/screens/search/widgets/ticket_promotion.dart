import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/media.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';

class TicketPromotion extends StatelessWidget {
  const TicketPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: size.width*0.42,
                height: 475,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 1,
                      spreadRadius: 2
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            AppMedia.gheNgoi
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Giảm giá 20% khi đặt vé sớm cho chuyến bay này. Đừng bỏ lỡ!",
                      style: AppStyles.headLineStyle2,
                    )
                  ],
                ),
              ),

              Column(
                children: [
                  Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            width: size.width*0.44,
                            height: 230,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3AB8B8),
                              borderRadius: BorderRadius.circular(18)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Giảm giá\ncho khảo sát",
                                  style: AppStyles.headLineStyle2.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  "Hãy tham gia khảo sát về dịch vụ của chúng tôi và nhận được giảm giá",
                                  style: AppStyles.headLineStyle2.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  
                          Positioned(
                            right: -45,
                            top: -45,
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 18,
                                  color: AppStyles.circleColor
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        width: size.width*0.44,
                        height: 230,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEC6545),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                            "Take Love",
                            style: AppStyles.headLineStyle2
                                .copyWith(color: Colors.white),
                          )),
                          const SizedBox(height: 20,),
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "😍", style: TextStyle(fontSize: 32)),
                              TextSpan(
                                  text: "🥰", style: TextStyle(fontSize: 45)),
                              TextSpan(
                                  text: "😘", style: TextStyle(fontSize: 32))
                            ]),
                          )
                        ],
                      ),
                      )
                ],
              )
            ],
          );
  }
}