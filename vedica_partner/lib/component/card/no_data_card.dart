import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class NoDataCard extends StatelessWidget {
  final String image;
  final String message;
  const NoDataCard({super.key, required this.image, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            color: MyColor.accentWhite,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: Texttheme.bodyStyle,
          )
        ],
      ),
    );
  }
}
