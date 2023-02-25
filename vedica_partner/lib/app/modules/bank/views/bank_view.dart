import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/component/buttons/rounded_btn.dart';
import 'package:vedica_partner/component/card/bank_card.dart';
import 'package:vedica_partner/component/textfields/my_textform_field.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/bank_controller.dart';

class BankView extends GetView<BankController> {
  const BankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColor.bgcolor,
          body: Obx(() => Form(
                key: controller.addBankformKey,
                child: controller.isloading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: controller.isBankUdate.value
                                    ? IconButton(
                                        onPressed: () {
                                          controller.iscard.value = true;
                                          controller.isBankUdate.value = false;
                                        },
                                        icon: Icon(Icons.arrow_back_ios,
                                            color: MyColor.yellowColor))
                                    : IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(Icons.arrow_back_ios,
                                            color: MyColor.yellowColor)),
                              ),
                              Spacer(),
                              controller.isBankUdate.value
                                  ? Text(
                                      "Manage Bank",
                                      style: Texttheme.headingTwo
                                          .copyWith(color: MyColor.yellowColor),
                                    )
                                  : Text(
                                      "${controller.iscard.value ? "Manage Bank" : "Add Bank"}",
                                      style: Texttheme.headingTwo
                                          .copyWith(color: MyColor.yellowColor),
                                    ),
                              Spacer(),
                              SizedBox(
                                width: 40,
                              )
                            ],
                          ),
                          controller.iscard.value
                              ? Container(
                                  height: size.height * 0.6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        BankCard(
                                            bnakUnit:
                                                "${controller.bankdetails.value.items!.bankName == null ? "" : controller.bankdetails.value.items!.bankName}",
                                            name:
                                                "${controller.bankdetails.value.items!.accountHolderName == null ? "" : controller.bankdetails.value.items!.accountHolderName}",
                                            accountNumber:
                                                "${controller.bankdetails.value.items!.accountNumber == null ? "" : controller.bankdetails.value.items!.accountNumber}",
                                            ifcode:
                                                "${controller.bankdetails.value.items!.ifsc == null ? "" : controller.bankdetails.value.items!.ifsc}"),
                                        RoundedButton(
                                            color: MyColor.yellowColor,
                                            onPressed: () {
                                              controller.iscard.value = false;
                                              controller.isBankUdate.value =
                                                  true;
                                            },
                                            title: "Update Bank")
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      MyTextFormField(
                                        labeltext: "Account Holder's Name",
                                        controller:
                                            controller.accountHolderName,
                                        onvalidate: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter account holders's name";
                                          }
                                          return null;
                                        },
                                      ),
                                      MyTextFormField(
                                        labeltext: "Account Number",
                                        controller: controller.accountNo,
                                        onvalidate: (value) {
                                          if (value!.length < 8 ||
                                              value.length > 12)
                                            return "Please enter bank valid account number";

                                          // Account numbers can only contain digits
                                          if (int.tryParse(value) == null)
                                            return "Please enter bank account number";
                                          return null;
                                        },
                                      ),
                                      MyTextFormField(
                                        labeltext: "IFSC Code",
                                        controller: controller.ifscCode,
                                        onvalidate: (value) {
                                          if (value!.length != 11)
                                            return "Please enter IFSC Code";

                                          // The first 4 characters are alphabets and represent the bank name
                                          var bankCode = value.substring(0, 4);
                                          if (!bankCode.contains(
                                              new RegExp(r'[A-Za-z]')))
                                            return "Please enter IFSC Code";

                                          // The fifth character is always 0
                                          if (value[4] != '0')
                                            return "Please enter IFSC Code";

                                          // The remaining 6 characters are alphanumeric and represent the branch
                                          var branchCode = value.substring(5);
                                          if (!branchCode.contains(
                                              new RegExp(r'[A-Za-z0-9]')))
                                            return "Please enter IFSC Code";

                                          return null;
                                        },
                                      ),
                                      MyTextFormField(
                                        labeltext: "Bank Name",
                                        controller: controller.bankName,
                                        onvalidate: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter bank name";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Container(
                                          height: 65,
                                          child: RoundedButton(
                                              color: MyColor.lightyellowColor,
                                              onPressed: () {
                                                addbank();
                                              },
                                              title:
                                                  "${controller.isBankUdate.value ? 'Update' : "Save"}"),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                        ],
                      ),
              ))),
    );
  }

  addbank() {
    var valid = controller.addBankformKey.currentState!.validate();
    if (valid) {
      controller.isBankUdate.value
          ? controller.updateBank()
          : controller.addBank();
    }
  }
}
