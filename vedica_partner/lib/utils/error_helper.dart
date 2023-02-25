import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:vedica_partner/component/buttons/rounded_btn.dart';
import 'package:vedica_partner/utils/my_colors.dart';

class Errorhelper {
  static Widget showLoading() {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(Get.size.width / 20),
      child: Container(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(
            color: MyColor.primaryColor,
          ),
          SizedBox(
            width: Get.size.width / 20,
          ),
          const Text("Loading...")
        ]),
      ),
    ));
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: MyColor.primaryColor,
        textColor: Colors.white,
        fontSize: 14);
  }

  static showErrorToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 2000),
        content: Text(
          '$message',
          style: TextStyle(
            color: MyColor.accentWhite,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        backgroundColor: MyColor.redColor,
      ),
    );
  }

  static void showErrorDialog(
      {required String title,
      required String discription,
      required VoidCallback onSubmit}) {
    print(discription);
    Get.dialog(
      Dialog(
        child: SizedBox(
          height: Get.size.height / 3.2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.error_outline_rounded,
                  color: MyColor.redColor,
                  size: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  discription.toString(),
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: Get.size.width / 2,
                      child: RoundedButton(
                        onPressed: onSubmit,
                        title: "Ok",
                        color: MyColor.yellowColor,
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
