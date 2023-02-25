import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/app/routes/app_pages.dart';
import 'package:vedica_partner/component/title_heading.dart';
import 'package:vedica_partner/utils/my_colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  start() {
    Future.delayed(Duration(seconds: 1), () {
      Get.offNamedUntil("/home", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    start();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColor.bgcolor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator()
                // TitleHeadingThree(text1: "Login"),
                // InkWell(
                //     onTap: () async {
                //       FirebaseAuth auth = FirebaseAuth.instance;
                //       auth.signOut();
                //       Get.toNamed("/login");
                //     },
                //     child: TitleHeadingOne(text1: "Login")),
                // TitleHeadingThree(text1: "Login"),
              ],
            ),
          ),
        ));
  }
}
