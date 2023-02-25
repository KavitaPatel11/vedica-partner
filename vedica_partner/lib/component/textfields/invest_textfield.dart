import 'package:flutter/material.dart';

import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class InvestmentTextFormField extends StatelessWidget {
  final String labeltext;
  final VoidCallback? onTab;
  final Function(String)? onchanged;
  final String? Function(String?)? onvalidate;
  final bool readonly;
  final int? maxlength;
  final TextInputType textInputType;
  final TextEditingController? controller;
  InvestmentTextFormField(
      {Key? key,
      required this.labeltext,
      this.onTab,
      this.onchanged,
      this.onvalidate,
      this.readonly = false,
      this.textInputType = TextInputType.text,
      this.maxlength,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTab,
      readOnly: readonly,
      controller: controller,
      // enabled: true,
      keyboardType: textInputType,
      maxLength: maxlength,
      textAlign: TextAlign.center,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Texttheme.hintStyle.copyWith(color: MyColor.accentWhite),
      decoration: InputDecoration(
        isDense: true,
        counterText: "",
        hintText: labeltext,
        hintStyle: Texttheme.subheading
            .copyWith(color: MyColor.accentWhite.withOpacity(0.2)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColor.accentWhite.withOpacity(0.2)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColor.accentWhite),
        ),
      ),
      validator: onvalidate,
      onChanged: onchanged,
    );
  }
}
