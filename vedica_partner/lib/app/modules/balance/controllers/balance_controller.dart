import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  TextEditingController amountController = TextEditingController();
  //TODO: Implement BalanceController

  final count = 0.obs;
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

  void increment() => count.value++;
}
