import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vedica_partner/app/modules/home/views/home_view.dart';
import 'package:vedica_partner/app/modules/overview/controllers/overview_controller.dart';
import 'package:vedica_partner/app/providers/data_providers.dart';
import 'package:vedica_partner/component/buttons/rounded_btn.dart';
import 'package:vedica_partner/component/dropdowns.dart';
import 'package:vedica_partner/component/imagepicker.dart';
import 'package:vedica_partner/component/textfields/my_textform_field.dart';
import 'package:vedica_partner/component/textfields/textformfield_with_icon.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/error_helper.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/ekyc_controller.dart';

class EkycView extends StatefulWidget {
  EkycView({Key? key}) : super(key: key);

  @override
  State<EkycView> createState() => _EkycViewState();
}

class _EkycViewState extends State<EkycView> {
  final EkycController ekyccontroller = Get.put(EkycController());
  final OverviewController overviewController = Get.put(OverviewController());

  onchange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    var videosBloc = Provider.of<DataProvider>(context, listen: false);
    videosBloc.getKyc();
  }

  @override
  Widget build(BuildContext context) {
    var balanceMod = Provider.of<DataProvider>(context);
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            iconTheme: IconThemeData(color: MyColor.yellowColor),
            centerTitle: true,
            titleTextStyle: Texttheme.heading
                .copyWith(color: MyColor.yellowColor, fontSize: 30),
            title: Text("E-KYC"),
            backgroundColor: MyColor.bgcolor,
          ),
          backgroundColor: MyColor.bgcolor,
          body: Consumer<DataProvider>(builder: (context, data, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // padding: EdgeInsets.zero,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 30,
                ),
                Flexible(
                  child: data.kycLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView(
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Form(
                                key: ekyccontroller.ekycformKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTextFormField(
                                      labeltext: "Name",
                                      controller: ekyccontroller.nameController,
                                      onvalidate: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your name";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextFormField(
                                      labeltext: "Aadhar No",
                                      controller: ekyccontroller.aadharNo,
                                      onvalidate: (value) {
                                        if (ekyccontroller.aadharValidator
                                                .validate(value) ==
                                            true) {
                                          return null;
                                        }
                                        return "Incorrect Aadhar Number";
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    data.isKyc
                                        ? SizedBox()
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Upload aadhar front and back side images",
                                                style: Texttheme.subheading
                                                    .copyWith(
                                                        color: MyColor
                                                            .accentWhite
                                                            .withOpacity(0.3)),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 80,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child:
                                                            DefaultImagePicker(
                                                      pickimage: "1",
                                                    )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        child:
                                                            DefaultImagePicker(
                                                                pickimage: "2"))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    MyTextFormField(
                                      labeltext: "PAN No",
                                      controller: ekyccontroller.panNo,
                                      onvalidate: (value) {
                                        if (ekyccontroller.panValidator
                                                .validate(value) ==
                                            true) {
                                          return null;
                                        }
                                        return "Incorrect PAN Number";
                                      },
                                    ),
                                    data.isKyc
                                        ? SizedBox()
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Upload PAN front image",
                                                style: Texttheme.subheading
                                                    .copyWith(
                                                        color: MyColor
                                                            .accentWhite
                                                            .withOpacity(0.3)),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 80,
                                                width: size.width * 0.6,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        child:
                                                            DefaultImagePicker(
                                                                pickimage:
                                                                    "3")),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    data.isKyc
                                        ? MyTextFormField(
                                            labeltext: "Gender",
                                            controller: ekyccontroller.gender,
                                            onvalidate: (value) {},
                                          )
                                        : DefaultDropdown(
                                            hintText: "Select gender",
                                            item: ekyccontroller.genderList,
                                            selectedValue: ekyccontroller
                                                        .genderValue ==
                                                    null
                                                ? "Male"
                                                : ekyccontroller.genderValue,
                                          ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    data.isKyc
                                        ? MyTextFormField(
                                            labeltext: "What do you do?",
                                            controller: ekyccontroller.workType,
                                            onvalidate: (value) {},
                                          )
                                        : DefaultDropdown(
                                            hintText: "What do you do?",
                                            item: ekyccontroller.workTypeList,
                                            selectedValue:
                                                ekyccontroller.workValue == null
                                                    ? "Job"
                                                    : ekyccontroller.workValue,
                                          ),
                                    MyTextFormFieldWithIcon(
                                      readonly: true,
                                      suffixIcon: data.isKyc
                                          ? SizedBox()
                                          : IconButton(
                                              onPressed: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime
                                                            .now(), //get today's date
                                                        firstDate: DateTime(
                                                            1950), //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime.now());
                                                if (pickedDate != null) {
                                                  print(
                                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('MM/dd/yyyy')
                                                          .format(
                                                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2022-07-04
                                                  //You can format date as per your need

                                                  ekyccontroller
                                                          .dobController.text =
                                                      formattedDate; //set foratted date to TextField value.
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color: MyColor.accentWhite,
                                              )),
                                      labeltext: "Date of birth",
                                      controller: ekyccontroller.dobController,
                                      onvalidate: (value) {
                                        if (value!.isEmpty) {
                                          return "Please select date of birth";
                                        }
                                        return null;
                                      },
                                    ),
                                    MyTextFormField(
                                      labeltext: "Resedential Address",
                                      controller: ekyccontroller.address,
                                      onvalidate: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter resedential address";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    data.isKyc
                                        ? SizedBox()
                                        : Container(
                                            height: 65,
                                            width: double.infinity,
                                            child: data.loading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: MyColor.redColor,
                                                    ),
                                                  )
                                                : RoundedButton(
                                                    color: MyColor
                                                        .lightyellowColor,
                                                    onPressed: () {
                                                      addKyc();
                                                    },
                                                    title: "Submit"),
                                          ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                )
              ],
            );
          })),
    );
  }

  addKyc() {
    var valid = ekyccontroller.ekycformKey.currentState!.validate();
    if (valid) {
      if (ekyccontroller.aadhar1 != null &&
          ekyccontroller.aadhar2 != null &&
          ekyccontroller.panimage != null) {
        _addkyc();
      } else {
        Errorhelper.showErrorToast(
            context, "Please upload required documents aadhar and pancard");
      }
    }
    return null;
  }

  Future<void> _addkyc() async {
    String name = ekyccontroller.nameController.text.toString();
    String work = ekyccontroller.workValue.toString();
    String address = ekyccontroller.address.text.toString();
    String aadhaarNumber = ekyccontroller.aadharNo.text.toString();
    String panNumber = ekyccontroller.panNo.text.toString();

    String DateOfBirth = ekyccontroller.dobController.text.toString();
    String gender = ekyccontroller.genderValue.toString();
    File aadhaarFront = File(ekyccontroller.aadhar1!.path);
    File aadhaarBack = File(ekyccontroller.aadhar2.toString());
    File panimg = File(ekyccontroller.panimage.toString());
    var data = {
      "name": ekyccontroller.nameController.text.toString(),
      "work": ekyccontroller.workValue.toString(),
      "address": ekyccontroller.address.text.toString(),
      "aadhaarNumber": ekyccontroller.aadharNo.text.toString(),
      "aadhaarFront": ekyccontroller.aadhar1.toString(),
      "aadhaarBack": ekyccontroller.aadhar2.toString(),
      "panNumber": ekyccontroller.panNo.text.toString(),
      "panFront": ekyccontroller.panimage.toString(),
      "DateOfBirth": ekyccontroller.dobController.text.toString(),
      "gender": "ll${ekyccontroller.genderValue.toString()}llll"
    };
    print("data $data");
    var provider = Provider.of<DataProvider>(context, listen: false);
    await provider.addKYC(
        name,
        work,
        address,
        gender,
        aadhaarNumber,
        panNumber,
        ekyccontroller.aadhar1!,
        ekyccontroller.aadhar2!,
        ekyccontroller.panimage!,
        DateOfBirth);
    // if (provider.isBack) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomeView()),
    //   );
    // }
  }
}
