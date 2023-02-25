import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govt_documents_validator/govt_documents_validator.dart';

class NomineeController extends GetxController {
  //TODO: Implement NomineeController

  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aadharController = TextEditingController();

  final addNomineeformKey = GlobalKey<FormState>();
  AadharValidator aadharValidator = AadharValidator();

  @override
  void onInit() {
    super.onInit();
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
