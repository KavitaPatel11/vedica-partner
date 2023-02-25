import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class InvestCard extends StatelessWidget {
  final String text1;
  final String text2;
  const InvestCard({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: MyColor.accentWhite.withOpacity(0.3)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: MyColor.bgcolor,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: MyColor.accentWhite.withOpacity(0.2),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text1,
            style: Texttheme.subheading,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text2,
            style: Texttheme.subheading.copyWith(color: MyColor.yellowColor),
          )
        ],
      ),
    );
  }
}
