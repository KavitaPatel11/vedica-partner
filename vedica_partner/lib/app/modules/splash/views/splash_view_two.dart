import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/app/routes/app_pages.dart';
import 'package:vedica_partner/component/title_heading.dart';
import 'package:vedica_partner/utils/my_colors.dart';

import '../controllers/splash_controller.dart';

class SplashViewTwo extends GetView<SplashController> {
  const SplashViewTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColor.bgcolor,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TitleHeadingThree(text1: "Login"),
                InkWell(
                    onTap: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut();
                      Get.toNamed("/otp");
                    },
                    child: const TitleHeadingOne(text1: "Login")),
                const TitleHeadingThree(text1: "Login"),
              ],
            ),
          ),
        ));
  }
}
