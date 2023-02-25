import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';

class Texttheme {
  static TextStyle heading = TextStyle(
      fontSize: 55,
      fontWeight: FontWeight.bold,
      color: MyColor.accentWhite,
      fontFamily: "OpenSans",
      fontStyle: FontStyle.normal);
  static TextStyle headingTwo = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: MyColor.accentWhite,
      fontFamily: "OpenSans",
      fontStyle: FontStyle.normal);

  static TextStyle subheading = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: MyColor.accentWhite,
      fontStyle: FontStyle.normal);
  static TextStyle title = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: MyColor.accentWhite,
      fontFamily: "OpenSans",
      fontStyle: FontStyle.normal);
  static TextStyle subtitle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: MyColor.accentWhite,
      fontStyle: FontStyle.normal);

  static TextStyle hintStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: MyColor.DarkGreyColor,
      fontStyle: FontStyle.normal);

  static TextStyle bodyStyle = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w300,
      color: MyColor.accentWhite,
      fontFamily: "OpenSans",
      fontStyle: FontStyle.normal);

  static TextStyle bodyStyleTwo = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: MyColor.accentWhite,
      fontFamily: "OpenSans",
      fontStyle: FontStyle.normal);
}

var kTextFieldDecoration = InputDecoration(
  helperStyle: Texttheme.hintStyle,
  hintText: 'Enter a value',
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: const OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff066163), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: const BorderSide(color: const Color(0xff066163), width: 2.0),
    borderRadius: const BorderRadius.all(const Radius.circular(32.0)),
  ),
);

var kTextFieldDecorationTwo = InputDecoration(
  helperStyle: Texttheme.hintStyle,
  hintText: 'Enter a value',
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: const OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff066163), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: const BorderSide(color: const Color(0xff066163), width: 2.0),
    borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
  ),
);
