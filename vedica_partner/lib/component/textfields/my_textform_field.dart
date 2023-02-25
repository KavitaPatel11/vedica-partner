import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class MyTextFormField extends StatelessWidget {
  final String labeltext;
  final VoidCallback? onTab;
  final Function(String)? onchanged;
  final Function(String)? onsubmitted;
  final VoidCallback? oneditatingComplete;
  final String? Function(String?)? onvalidate;
  final bool readonly;
  final int? maxlength;
  final TextInputType textInputType;
  final TextEditingController? controller;
  MyTextFormField(
      {Key? key,
      required this.labeltext,
      this.onTab,
      this.onchanged,
      this.onvalidate,
      this.readonly = false,
      this.textInputType = TextInputType.text,
      this.maxlength,
      this.controller,
      this.onsubmitted,
      this.oneditatingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      onTap: () {
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      // enabled: false,
      // keyboardType: textInputType,
      maxLength: maxlength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Texttheme.title
          .copyWith(color: MyColor.accentWhite.withOpacity(0.6), fontSize: 18),
      decoration: InputDecoration(
        counterText: "",
        labelText: labeltext,
        labelStyle: Texttheme.hintStyle.copyWith(color: MyColor.accentWhite),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: MyColor.accentWhite.withOpacity(0.2)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: MyColor.accentWhite),
        ),
      ),
      validator: onvalidate,
      onChanged: onchanged,
      onFieldSubmitted: onsubmitted,
      onEditingComplete: oneditatingComplete,
    );
  }
}
