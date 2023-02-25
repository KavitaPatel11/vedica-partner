import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class TrasactionsCard extends StatelessWidget {
  final String dailyInterest;
  final String paymentType;
  final String date;
  final String reason;
  final VoidCallback? onpress;

  const TrasactionsCard(
      {super.key,
      required this.date,
      required this.dailyInterest,
      required this.paymentType,
      this.onpress,
      required this.reason});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$reason",
                  style: Texttheme.subtitle,
                ),
                Text(
                  "₹" + dailyInterest,
                  style:
                      Texttheme.subtitle.copyWith(color: MyColor.yellowColor),
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: Texttheme.subheading.copyWith(
                      color: MyColor.accentWhite.withOpacity(0.5),
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  paymentType,
                  style: Texttheme.subheading.copyWith(
                      color: MyColor.accentWhite.withOpacity(0.5),
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
