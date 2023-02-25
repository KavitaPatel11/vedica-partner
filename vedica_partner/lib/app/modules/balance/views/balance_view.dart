import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/balance/views/tabs/capital_balance_screen.dart';
import 'package:vedica_partner/app/modules/balance/views/tabs/current_profit_screen.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/balance_controller.dart';

class BalanceView extends GetView<BalanceController> {
  const BalanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
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
            title: Text("Withdraw"),
            elevation: 0,
            backgroundColor: MyColor.bgcolor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: TabBar(
                tabs: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text("Current Profit"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    child: Text("Capital Balance"),
                  )
                ],
                automaticIndicatorColorAdjustment: false,
                labelStyle: Texttheme.title,
                indicatorColor: MyColor.defaultblackColor,
                indicatorWeight: 2.0,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.zero,
              ),
            ),
          ),
          backgroundColor: MyColor.bgcolor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Flexible(
                child: SizedBox(
                  height: size.height * 0.5,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CurrentProfitBalance(),
                      CapitalBalance(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
