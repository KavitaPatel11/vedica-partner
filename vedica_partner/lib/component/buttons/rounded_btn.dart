import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Function() onPressed;
  final String title;

  RoundedButton(
      {required this.color, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 0.0,
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 30.0,
          child: Text(title,
              style: Texttheme.bodyStyleTwo
                  .copyWith(color: MyColor.defaultblackColor)),
        ),
      ),
    );
  }
}
