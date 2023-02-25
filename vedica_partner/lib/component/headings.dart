import 'package:flutter/cupertino.dart';
import 'package:vedica_partner/utils/textthem.dart';

class HeadingText extends StatelessWidget {
  final String text1;
  const HeadingText({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text1,
            style: Texttheme.subheading,
          )
        ],
      ),
    );
  }
}
