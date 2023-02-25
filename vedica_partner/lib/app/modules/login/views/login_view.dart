import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/component/textfields/my_textform_field.dart';
import 'package:vedica_partner/component/title_heading.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColor.bgcolor,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: SizedBox(
              width: size.width * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFormField(
                      controller: controller.phoneController,
                      textInputType: TextInputType.phone,
                      maxlength: 10,
                      labeltext: "Phone No",
                      onvalidate: (value) {
                        String patttern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
                        RegExp regExp = new RegExp(patttern);
                        if (value!.length == 0) {
                          return 'Please enter mobile number';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }

                        return null;
                      },
                      onsubmitted: (value) {
                        controller.phoneController.text = value;
                        controller.update();
                      },
                      oneditatingComplete: () {
                        if (controller.phoneController.text.length == 10) {
                          Get.toNamed("/otp", arguments: {
                            'phone': controller.phoneController.text
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SubheadingText(text1: "You will receive otp on given no."),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
