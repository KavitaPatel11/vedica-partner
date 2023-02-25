import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/overview/controllers/overview_controller.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/component/card/account_tile.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/error_helper.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/account_controller.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final OverviewController overviewController = Get.put(OverviewController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: Texttheme.heading
                .copyWith(color: MyColor.yellowColor, fontSize: 30),
            title: Text("Account"),
            backgroundColor: MyColor.bgcolor,
          ),
          backgroundColor: MyColor.bgcolor,
          body: SingleChildScrollView(
            padding: EdgeInsets.zero,
            // physics: BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: MyColor.bgcolor,
                          backgroundImage: AssetImage(ConstentsAssets.avatar),
                        ),
                        Text(
                          "${overviewController.userDetailModel.value.items!.fullName == null ? "Anonymous User" : overviewController.userDetailModel.value.items!.fullName}",
                          style: Texttheme.hintStyle
                              .copyWith(color: MyColor.accentWhite),
                        ),
                        Text(
                            "${overviewController.userDetailModel.value.items!.phone == null ? "9875455443" : overviewController.userDetailModel.value.items!.phone}",
                            style: Texttheme.bodyStyleTwo)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AccountTile(
                    title: "Ekyc Details",
                    onpress: () {
                      Get.toNamed("/ekyc");
                    },
                  ),
                  AccountTile(
                    title: "Manage Banks",
                    onpress: () {
                      Get.toNamed("/bank");
                    },
                  ),
                  AccountTile(
                    title: "Withdraw Request",
                    onpress: () {
                      Get.toNamed("/balance");
                    },
                  ),
                  const AccountTile(title: "Refer"),
                  AccountTile(
                    title: "Add Nominee",
                    onpress: () {
                      Get.toNamed("/nominee");
                    },
                  ),
                  AccountTile(
                    title: "FAQ",
                    onpress: () {
                      Get.toNamed("/faq");
                    },
                  ),
                  const AccountTile(title: "Help & Support"),
                  const AccountTile(title: "Terms & Condition"),
                  const AccountTile(title: "Privacy Policy"),
                  const AccountTile(title: "Rate us"),
                  AccountTile(
                    title: "Logout",
                    onpress: () async {
                      LocalResourceManager.logout();
                      await FirebaseAuth.instance.signOut();
                      if (!mounted) return;

                      Get.offNamedUntil("/otp", (route) => false);
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
