import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: MyColor.defaultblackColor,
          body: homeController.tabs[homeController.currentPosition.value],
          bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 28,
              unselectedFontSize: 18,
              unselectedLabelStyle: Texttheme.bodyStyle,
              selectedLabelStyle: Texttheme.bodyStyleTwo,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              backgroundColor: MyColor.defaultblackColor,
              selectedItemColor: MyColor.accentWhite,
              unselectedItemColor: MyColor.redColor.withOpacity(0.8),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(ConstentsAssets.homeSvg,
                      semanticsLabel: 'home'),
                  label: 'Home',
                  backgroundColor: MyColor.accentWhite.withOpacity(0.3),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ConstentsAssets.transasctionSvg,
                    semanticsLabel: 'transactions',
                  ),
                  label: 'Transactions',
                  backgroundColor: MyColor.accentWhite.withOpacity(0.3),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(ConstentsAssets.activitySvg,
                      semanticsLabel: 'invest'),
                  label: 'Invest',
                  backgroundColor: MyColor.accentWhite.withOpacity(0.3),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(ConstentsAssets.profileSvg,
                      semanticsLabel: 'profile'),
                  label: 'Profile',
                  backgroundColor: MyColor.accentWhite.withOpacity(0.3),
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: homeController.currentPosition.value,
              iconSize: 40,
              onTap: (index) {
                print("indes  $index");
                homeController.currentPosition.value = index;
              },
              elevation: 0),
        ));
  }
}
