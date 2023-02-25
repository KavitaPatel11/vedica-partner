import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vedica_partner/app/providers/data_providers.dart';
import 'package:vedica_partner/component/buttons/rounded_btn.dart';
import 'package:vedica_partner/component/textfields/my_textform_field.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/nominee_controller.dart';

class NomineeView extends StatefulWidget {
  const NomineeView({Key? key}) : super(key: key);

  @override
  State<NomineeView> createState() => _NomineeViewState();
}

class _NomineeViewState extends State<NomineeView> {
  final NomineeController controller = Get.put(NomineeController());
  @override
  void initState() {
    getnominee();

    // TODO: implement initState
    super.initState();
  }

  getnominee() {
    var provider = Provider.of<DataProvider>(context, listen: false);
    var daata = provider.getNominee();
    print("daata $daata");
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text("Nominee"),
            backgroundColor: MyColor.bgcolor,
          ),
          backgroundColor: MyColor.bgcolor,
          body: Consumer<DataProvider>(builder: (context, data, child) {
            return data.loading
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: controller.addNomineeformKey,
                    child: data.investLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              // Container(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 40),
                              //   height: size.height * 0.2,
                              //   width: size.width,
                              //   decoration: BoxDecoration(),
                              //   child: data.investLoading
                              //       ? Center(child: CircularProgressIndicator())
                              //       : Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             IconButton(
                              //                 onPressed: () {
                              //                   Get.back();
                              //                 },
                              //                 icon: Icon(
                              //                   Icons.arrow_back,
                              //                   color: MyColor.accentWhite,
                              //                 )),
                              //             Align(
                              //               alignment: Alignment.center,
                              //               child: Column(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.center,
                              //                 children: [
                              //                   data.isNominee
                              //                       ? Text(
                              //                           "Nominee",
                              //                           style: Texttheme
                              //                               .headingTwo
                              //                               .copyWith(
                              //                                   color: MyColor
                              //                                       .yellowColor),
                              //                         )
                              //                       : Text(
                              //                           "Add Nominee",
                              //                           style: Texttheme
                              //                               .headingTwo
                              //                               .copyWith(
                              //                                   color: MyColor
                              //                                       .yellowColor),
                              //                         ),
                              //                 ],
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             )
                              //           ],
                              //         ),
                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTextFormField(
                                      labeltext: "Name",
                                      controller: controller.nameController,
                                      onvalidate: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter nominee name";
                                        }
                                        return null;
                                      },
                                    ),
                                    MyTextFormField(
                                      labeltext: "Relation with you",
                                      controller: controller.relationController,
                                      onvalidate: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter nominee relation";
                                        }
                                        return null;
                                      },
                                    ),
                                    MyTextFormField(
                                      maxlength: 10,
                                      textInputType: TextInputType.phone,
                                      labeltext: "Phone",
                                      controller: controller.phoneController,
                                      onvalidate: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter phone number";
                                        } else if (value.length != 10) {
                                          return "Please enter valid phone number";
                                        }
                                        return null;
                                      },
                                    ),
                                    MyTextFormField(
                                      labeltext: "Email",
                                      controller: controller.emailController,
                                      onvalidate: (value) {
                                        if (!GetUtils.isEmail(value!))
                                          return "Email is not valid";
                                        else
                                          return null;
                                      },
                                    ),
                                    MyTextFormField(
                                      labeltext: "Aadhar No",
                                      controller: controller.aadharController,
                                      onvalidate: (value) {
                                        if (controller.aadharValidator
                                                .validate(value) ==
                                            true) {
                                          return null;
                                        }
                                        return "Incorrect Aadhar Number";
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    data.isNominee
                                        ? SizedBox()
                                        : Center(
                                            child: Container(
                                              height: 65,
                                              child: RoundedButton(
                                                  color:
                                                      MyColor.lightyellowColor,
                                                  onPressed: () {
                                                    _addNominee();
                                                  },
                                                  title: "Save"),
                                            ),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                  );
          })),
    );
  }

  Future<void> _addNominee() async {
    var valid = controller.addNomineeformKey.currentState!.validate();
    if (valid) {
      String name = controller.nameController.text.trim();
      String phone = controller.phoneController.text.trim();
      String email = controller.emailController.text.trim();
      String relation = controller.relationController.text.trim();
      String aadhar = controller.aadharController.text.trim();
      var data = {
        "name": name,
        "email": email,
        "phone": phone,
        "relation": relation,
        "aadhar": aadhar,
      };
      print("data $data");
      var provider = Provider.of<DataProvider>(context, listen: false);
      await provider.addnominee(name, phone, email, relation, aadhar);
      // if (provider.isBack) {
      //   // Navigator.push(
      //   //   context,
      //   //   MaterialPageRoute(builder: (context) => Homeview()),
      //   // );
      // }
    } else {
      return null;
    }
  }
}
