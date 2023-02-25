import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/otp/controllers/otp_controller.dart';
import 'package:vedica_partner/component/buttons/rounded_btn.dart';
import 'package:vedica_partner/component/textfields/my_textform_field.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({Key? key}) : super(key: key);
  final OnboardingController onboardingController =
      Get.put(OnboardingController());
  final OtpController otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    // otpController.login();
    var size = MediaQuery.of(context).size;
    // otpController.login();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: MyColor.yellowColor),
            centerTitle: true,
            titleTextStyle: Texttheme.heading
                .copyWith(color: MyColor.yellowColor, fontSize: 30),
            title: const Text("Update Profile"),
            backgroundColor: MyColor.bgcolor,
          ),
          backgroundColor: MyColor.bgcolor,
          body: Obx(() => ListView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: onboardingController.onBoardingformKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.uid.value}",
                            style: Texttheme.subheading,
                          ),
                          MyTextFormField(
                            labeltext: "Name",
                            controller: onboardingController.fullnameController,
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your full name";
                              }
                              return null;
                            },
                          ),
                          MyTextFormField(
                            readonly: true,
                            labeltext: "Phone No",
                            controller: onboardingController.phoneController,
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your phone number";
                              }
                              if (value.length != 13) {
                                return "Please enter your valid phone number";
                              }
                              return null;
                            },
                          ),
                          MyTextFormField(
                            labeltext: "Email",
                            controller: onboardingController.emailController,
                            onvalidate: (value) {
                              if (!GetUtils.isEmail(value!))
                                return "Email is not valid";
                              else
                                return null;
                            },
                          ),
                          MyTextFormField(
                            labeltext: "City",
                            controller: onboardingController.cityController,
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your city";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Container(
                              height: 75,
                              width: 150,
                              child: onboardingController.isloading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : RoundedButton(
                                      color: MyColor.lightyellowColor,
                                      onPressed: () {
                                        var valid = onboardingController
                                            .onBoardingformKey.currentState!
                                            .validate();
                                        if (valid) {
                                          onboardingController.updateProfile();
                                        } else {
                                          return null;
                                        }
                                      },
                                      title: "Next"),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
