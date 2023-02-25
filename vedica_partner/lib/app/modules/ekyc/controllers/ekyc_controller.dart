import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:govt_documents_validator/govt_documents_validator.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/bank/bank_services.dart';

class EkycController extends GetxController {
  //TODO: Implement EkycController
  TextEditingController aadharNo = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController workType = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController checkController = TextEditingController();

  var isAadharNum = false.obs;
  var isPAnNum = false.obs;
  bool isKyc = false;
  PANValidator panValidator = PANValidator();
  AadharValidator aadharValidator = AadharValidator();

  final BankService _service = BankService();
  final LocalResourceManager _manager = LocalResourceManager();
  bool isloading = false;
  bool isloading2 = false;
  final ekycformKey = GlobalKey<FormState>();
  final List<String> genderList = [
    'Male',
    'Female',
    'Other',
  ];
  var genderValue;
  final List<String> workTypeList = [
    'Job',
    'Bussiness',
    'Freelancer',
    "Nothing"
  ];
  var workValue;
  File? aadhar1;
  File? aadhar2;
  File? panimage;

  @override
  void onInit() {
    super.onInit();
  }

  void _updateIsLoading(bool currentStatus) {
    isloading = currentStatus;
    update();
  }

  void _updateIsLoading2(bool currentStatus) {
    isloading2 = currentStatus;
    update();
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
