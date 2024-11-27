import 'package:flutter/material.dart';
import 'package:ticket_app_final/base/res/style/app_style.dart';
import 'package:ticket_app_final/base/widgets/app_column_text_layout.dart';
import 'package:ticket_app_final/base/widgets/app_layout_build_widget.dart';
import 'package:ticket_app_final/base/widgets/big_circle.dart';
import 'package:ticket_app_final/base/widgets/big_dot.dart';
import 'package:ticket_app_final/base/widgets/text_style_fourth.dart';
import 'package:ticket_app_final/base/widgets/text_style_third.dart';
import 'package:ticket_app_final/models/flight.dart';

class TicketView extends StatelessWidget {
  final Flight ticket;
  final bool wholeScreen;
  final bool isColor;

  const TicketView({
    super.key,
    required this.ticket,
    this.wholeScreen = false,
    this.isColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      height: 180,
      child: Container(
        margin: EdgeInsets.only(right: wholeScreen ? 0 : 16),
        child: Column(
          children: [
            // Phần vé màu xanh (thông tin điểm khởi hành và đến)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isColor ? AppStyles.ticketColor : AppStyles.ticketBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                ),
              ),
              child: Column(
                children: [
                  // Icon điểm khởi hành -> điểm đến
                  Row(
                    children: [
                      TextStyleThird(
                        text: ticket.fromCode,
                        isColor: true,
                      ),
                      Expanded(child: Container()),
                      BigDot(isColor: isColor),
                      Expanded(
                        child: Stack(
                          children: [
                            const SizedBox(
                              height: 24,
                              child: AppLayoutBuildWidget(randomDivider: 6),
                            ),
                            Center(
                              child: Transform.rotate(
                                angle: 1.57,
                                child: Icon(
                                  Icons.local_airport_rounded,
                                  color: isColor
                                      ? AppStyles.planeSecondColor
                                      : Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      BigDot(isColor: isColor),
                      Expanded(child: Container()),
                      TextStyleThird(
                        text: ticket.toCode,
                        isColor: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  // Tên điểm khởi hành -> điểm đến và thời gian bay
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextStyleFourth(
                          text: ticket.fromName,
                          isColor: true,
                        ),
                      ),
                      Expanded(child: Container()),
                      TextStyleFourth(
                        text: ticket.flyingTime,
                        isColor: true,
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        width: 100,
                        child: TextStyleFourth(
                          text: ticket.toName,
                          isColor: true,
                          align: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Phần vé (đường gạch ngang)
            Container(
              color: isColor ? AppStyles.ticketColor : AppStyles.ticketOrange,
              child: Row(
                children: [
                  BigCircle(isRight: false, isColor: isColor),
                  Expanded(
                    child: AppLayoutBuildWidget(
                      randomDivider: 16,
                      width: 6,
                      isColor: true,
                    ),
                  ),
                  BigCircle(isRight: true, isColor: isColor),
                ],
              ),
            ),

            // Phần vé màu cam (chi tiết ngày bay và mã chuyến bay)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isColor ? AppStyles.ticketColor : AppStyles.ticketOrange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(isColor ? 0 : 21),
                  bottomRight: Radius.circular(isColor ? 0 : 21),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppColumnTextLayout(
                        topText: "Ngày",
                        bottomText: ticket.date,
                        alignment: CrossAxisAlignment.start,
                        isColor: true,
                      ),
                      AppColumnTextLayout(
                        topText: "Thời gian khởi hành",
                        bottomText: ticket.departureTime,
                        alignment: CrossAxisAlignment.center,
                        isColor: true,
                      ),
                      AppColumnTextLayout(
                        topText: "Số",
                        bottomText: ticket.Number,
                        alignment: CrossAxisAlignment.end,
                        isColor: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
