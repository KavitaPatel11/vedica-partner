import 'package:flutter/cupertino.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class TitleHeading extends StatelessWidget {
  final String text1;
  const TitleHeading({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text1,
            style: Texttheme.title,
          )
        ],
      ),
    );
  }
}

class TitleHeadingOne extends StatelessWidget {
  final String text1;
  const TitleHeadingOne({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text1,
          style: Texttheme.heading,
        ));
  }
}

class TitleHeadingThree extends StatelessWidget {
  final String text1;
  const TitleHeadingThree({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(text1,
            style: Texttheme.heading.copyWith(
              color: MyColor.accentWhite.withOpacity(0.2),
            )));
  }
}

class TitleHeadingTwo extends StatelessWidget {
  final String text1;
  const TitleHeadingTwo({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
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

class SubheadingText extends StatelessWidget {
  final String text1;
  const SubheadingText({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(text1,
            style: Texttheme.subheading.copyWith(
              color: MyColor.yellowColor,
            )));
  }
}
