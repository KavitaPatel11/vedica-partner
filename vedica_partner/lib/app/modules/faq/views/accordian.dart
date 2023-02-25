import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        onTap: () {
          setState(() {
            _showContent = !_showContent;
          });
        },
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(
          widget.title,
          style: Texttheme.subtitle,
        ),
      ),
      Divider(
        height: 2,
        color: MyColor.accentWhite,
      ),
      _showContent
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: Text(
                widget.content,
                style: Texttheme.bodyStyle,
              ),
            )
          : Container(),
    ]);
  }
}
