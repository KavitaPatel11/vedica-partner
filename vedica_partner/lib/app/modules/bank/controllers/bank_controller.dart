import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vedica_partner/app/data/bank_detail_model.dart';
import 'package:vedica_partner/app/data/default_model.dart';
import 'package:vedica_partner/app/routes/app_pages.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/bank/bank_services.dart';
import 'package:vedica_partner/utils/error_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BankController extends GetxController {
  //TODO: Implement BankController
  var iscard = false.obs;
  final BankService _service = BankService();
  final LocalResourceManager _manager = LocalResourceManager();
  var isloading = false.obs;
  var isBankloading = false.obs;
  var isBankUdate = false.obs;
  var bankdetails = BankDetailModel().obs;
  final addBankformKey = GlobalKey<FormState>();

  TextEditingController accountNo = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();

  @override
  void onInit() {
    getBankDetail();
    super.onInit();
  }

  getBankDetail() async {
    try {
      isloading(true);
      update();
      final response = await _service.getBank(_manager.getToken()!);

      if (response != null) {
        var baseResponse = BankDetailModel.fromJson(response);

        if (baseResponse.subCode == 200) {
          bankdetails.value = baseResponse;
          iscard.value = baseResponse.status!;
          accountNo.text = bankdetails.value.items!.accountNumber == null
              ? ""
              : bankdetails.value.items!.accountNumber!;
          bankName.text = bankdetails.value.items!.bankName == null
              ? ""
              : bankdetails.value.items!.bankName!;
          ifscCode.text = bankdetails.value.items!.ifsc == null
              ? ""
              : bankdetails.value.items!.ifsc!;
          accountHolderName.text =
              bankdetails.value.items!.accountHolderName == null
                  ? ""
                  : bankdetails.value.items!.accountHolderName!;
          print("=========baseResponse===========${baseResponse.items}=======");
        }
        update();
      }
    } finally {
      isloading(false);
      update();
    }
  }

  addBank() async {
    try {
      isBankloading = true.obs;
      var data = {
        "bankName": bankName.text,
        "accountNumber": accountNo.text,
        "ifsc": ifscCode.text,
        "accountHolderName": accountHolderName.text
      };
      print("data");
      final data2 = await _service.addBank(data);

      print("data2 $data2");

      if (data2 != null) {
        final response = DefaultModel.fromJson(data2);
        print("rsponse $response");
        if (response.subCode == 200) {
          Errorhelper.showToast("Bank added successfully");

          getBankDetail();
        } else {
          Errorhelper.showErrorDialog(
              title: "Error On Added Bank detail",
              discription: response.message!,
              onSubmit: () => Get.back());
        }
      }
    } finally {
      isBankloading = false.obs;
    }
  }

  updateBank() async {
    try {
      isBankloading = true.obs;
      var data = {
        "bankName": bankName.text,
        "accountNumber": accountNo.text,
        "ifsc": ifscCode.text,
        "accountHolderName": accountHolderName.text
      };
      print("data");
      final data2 = await _service.updateBank(data);

      print("data2 $data2");

      if (data2['status'] == true) {
        Errorhelper.showToast("${data2['message']}");
        isBankUdate.value = false;

        getBankDetail();
      } else {
        Errorhelper.showErrorDialog(
            title: "Error",
            discription: data2['message'],
            onSubmit: () => Get.back());
      }
    } finally {
      isBankloading = false.obs;
    }
  }

  bool validateIFSCCode(String ifscCode) {
    // IFSC codes are 11 characters long
    if (ifscCode.length != 11) return false;

    // The first 4 characters are alphabets and represent the bank name
    var bankCode = ifscCode.substring(0, 4);
    if (!bankCode.contains(new RegExp(r'[A-Za-z]'))) return false;

    // The fifth character is always 0
    if (ifscCode[4] != '0') return false;

    // The remaining 6 characters are alphanumeric and represent the branch
    var branchCode = ifscCode.substring(5);
    if (!branchCode.contains(new RegExp(r'[A-Za-z0-9]'))) return false;

    return true;
  }

  bool validateAccountNumber(String accountNumber) {
    // Account numbers are typically 8 to 12 digits long
    if (accountNumber.length < 8 || accountNumber.length > 12) return false;

    // Account numbers can only contain digits
    if (int.tryParse(accountNumber) == null) return false;

    return true;
  }

  bool validateBankName(String bankName) {
    List<String> knownBankNames = [
      "State Bank of India",
      "HDFC Bank",
      "ICICI Bank",
      "Axis Bank",
      "Kotak Mahindra Bank",
      // Add more known bank names here
    ];

    return knownBankNames.contains(bankName);
  }

  Future<String> getBankName(String ifscCode) async {
    final response =
        await http.get(Uri.parse("https://bankbazaar.com/ifsc/$ifscCode.html"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      bankName.text = data['bank'];
      return data['bank'];
    } else {
      Errorhelper.showToast("Failed to get bank name");
      throw Exception("Failed to get bank name");
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
