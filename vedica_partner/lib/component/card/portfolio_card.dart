import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class PortfolioCard extends StatelessWidget {
  final String investment;
  final String profit;
  final String rate;
  final String date;
  final VoidCallback? onpress;
  final VoidCallback? onlockingPeriod;
  final VoidCallback? onWithdrawRequest;
  const PortfolioCard(
      {super.key,
      required this.investment,
      required this.profit,
      required this.rate,
      required this.date,
      this.onpress,
      this.onlockingPeriod,
      this.onWithdrawRequest});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: DottedDecoration(
          color: MyColor.accentWhite,
          shape: Shape.box,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ), //remove this to get plane rectange
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  investment,
                  style: Texttheme.subtitle,
                ),
                Text(
                  profit,
                  textAlign: TextAlign.start,
                  style: Texttheme.subtitle,
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Investment",
                  style: Texttheme.bodyStyle.copyWith(
                      color: MyColor.accentWhite.withOpacity(0.6),
                      fontSize: 18),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: MyColor.accentWhite,
                ),
                Text(
                  "Profit",
                  textAlign: TextAlign.center,
                  style: Texttheme.bodyStyle.copyWith(
                      color: MyColor.accentWhite.withOpacity(0.6),
                      fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
