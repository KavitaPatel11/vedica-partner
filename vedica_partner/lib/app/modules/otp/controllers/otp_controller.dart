import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vedica_partner/app/data/custom_response_model.dart';
import 'package:vedica_partner/app/modules/login/controllers/login_controller.dart';
import 'package:vedica_partner/app/routes/app_pages.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/user/user_service.dart';
import 'package:vedica_partner/utils/error_helper.dart';

class OtpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var showPrefix = false.obs;
  var isLogin = true;
  var phoneNo = "".obs;
  var otp = "".obs;
  var isOtpSent = false.obs;
  var resendAfter = 30.obs;
  var resendOTP = false.obs;
  var firebaseVerificationId = "";
  var statusMessage = "".obs;
  var statusMessageColor = Colors.red.obs;
  final UserService _service = UserService();
  final LocalResourceManager _manager = LocalResourceManager();

  var isloading = false.obs;

  var timer;

  AuthController() {}

  @override
  onInit() async {
    super.onInit();
  }

  getOtp() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phoneNo.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        isOtpSent.value = true;
        statusMessage.value = "OTP sent to +91" + phoneNo.value;
        startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  resendOtp() async {
    resendOTP.value = false;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phoneNo.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        isOtpSent.value = true;
        statusMessage.value = "OTP re-sent to +91" + phoneNo.value;
        startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOTP() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      statusMessage.value = "Verifying... " + otp.value;
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId, smsCode: otp.value);
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      // Get.toNamed("/home");
      login();
    } catch (e) {
      statusMessage.value = "Invalid  OTP";
      statusMessageColor = Colors.red.obs;
    }
  }

  startResendOtpTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendAfter.value != 0) {
        resendAfter.value--;
      } else {
        resendAfter.value = 30;
        resendOTP.value = true;
        timer.cancel();
      }
      update();
    });
  }

  login() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var userPhone = FirebaseAuth.instance.currentUser!.phoneNumber;

    var data = {"userId": userId, "userphone": userPhone};
    print("data $data");

    try {
      isloading = true.obs;
      final response = CustomResponseModel.fromJson(
          await _service.login(userId, userPhone!));
      if (response != null) {
        if (response.subCode == 200) {
          LocalResourceManager.setToken(response.items!.token.toString());
          LocalResourceManager.setIsOnboarded(
              response.items!.isOnboarded == null
                  ? false
                  : response.items!.isOnboarded!);

          print('Token Get SuccessFully ${response.items!}');

          if (response.items!.isOnboarded == true) {
            Get.offAllNamed(
              Routes.HOME,
            );
          } else {
            Get.offAllNamed(
              Routes.ONBOARDING,
            );
          }
        } else {
          isloading = false.obs;
          Errorhelper.showErrorDialog(
              title: "Error On Login",
              discription: response.message!,
              onSubmit: () => Get.back());
        }
      }
    } finally {
      isloading = false.obs;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
