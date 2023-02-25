import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vedica_partner/app/modules/login/controllers/login_controller.dart';
import 'package:vedica_partner/app/routes/app_pages.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/user/user_service.dart';
import 'package:vedica_partner/utils/error_helper.dart';

import '../../../data/userdetail_model.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController

  var uid = "".obs;

  final UserService _service = UserService();
  final LocalResourceManager _manager = LocalResourceManager();
  final UserService _userService = UserService();
  final LoginController loginController = Get.put(LoginController());
  var isloading = false.obs;

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final onBoardingformKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getuserid();
    super.onInit();
  }

  getuserid() async {
    var data = FirebaseAuth.instance.currentUser!;
    var user = await FirebaseAuth.instance.currentUser;

    phoneController.text = data.phoneNumber!;

    print("user token  $data");

    print("user data  $user");
  }

  updateProfile() async {
    var data = {
      "fullName": fullnameController.text,
      "email": emailController.text,
      "city": cityController.text,
      "profileImage": "profileImage"
    };
    print("data $data");

    try {
      isloading = true.obs;

      print("data user");

      final response =
          UserDetailModel.fromJson(await _service.updateUser(data));
      print("user profiele  $response");
      if (response != null) {
        if (response.subCode == 200) {
          LocalResourceManager.setIsOnboarded(true);
          Errorhelper.showToast(response.message.toString());
          isloading = false.obs;

          Get.offAllNamed(
            Routes.HOME,
          );
        } else {
          isloading = false.obs;

          Errorhelper.showErrorDialog(
              title: "Error On Onboarding",
              discription: response.message!,
              onSubmit: () => Get.back());
        }
      }
    } finally {
      isloading = false.obs;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
