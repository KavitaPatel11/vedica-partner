import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/ekyc/controllers/ekyc_controller.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class DefaultDropdown extends StatefulWidget {
  final String hintText;
  final List<String> item;
  String selectedValue;
  DefaultDropdown(
      {super.key,
      required this.hintText,
      required this.item,
      required this.selectedValue});

  @override
  State<DefaultDropdown> createState() => _DefaultDropdownState();
}

class _DefaultDropdownState extends State<DefaultDropdown> {
  final EkycController ekycController = Get.put(EkycController());
  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      dropdownElevation: 8,
      offset: const Offset(0, 8),
      dropdownDecoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(2, 2),
          blurRadius: 12,
          color: MyColor.accentWhite.withOpacity(0.2),
        )
      ], color: MyColor.bgcolor),
      hint: Text(widget.hintText,
          style: Texttheme.subheading
              .copyWith(color: MyColor.accentWhite.withOpacity(0.2))),
      items: widget.item
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: Texttheme.subheading),
              ))
          .toList(),
      value: widget.selectedValue,
      onChanged: (value) {
        setState(() {
          widget.selectedValue = value as String;
          widget.hintText == "Select gender"
              ? ekycController.genderValue = value.toString()
              : ekycController.workValue = value.toString();
        });
        ekycController.update();
      },
      buttonHeight: 40,
      buttonWidth: double.infinity,
      itemHeight: 40,
    );
  }
}
