import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ConstentsAssets.noInternet,
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Whoops!!",
              style: Texttheme.heading,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "No internet connection found.Check your connection or try agin",
              style: Texttheme.subheading,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
