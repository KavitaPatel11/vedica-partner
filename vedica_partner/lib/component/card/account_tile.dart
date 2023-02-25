import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class AccountTile extends StatelessWidget {
  final String title;
  final VoidCallback? onpress;
  const AccountTile({super.key, required this.title, this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(right: 60, left: 40, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Texttheme.subtitle,
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 5,
              thickness: 2,
              color: MyColor.accentWhite.withOpacity(0.3),
            )
          ],
        ),
      ),
    );
  }
}
