import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/account/views/account_view.dart';
import 'package:vedica_partner/app/modules/invest/views/invest_view.dart';
import 'package:vedica_partner/app/modules/offers/views/offers_view.dart';
import 'package:vedica_partner/app/modules/overview/views/overview_view.dart';
import 'package:vedica_partner/app/modules/transactions/views/transactions_view.dart';

class HomeController extends GetxController {
  var currentPosition = 0.obs;
  var uid = "".obs;
  //TODO: Implement HomeController

  @override
  void onInit() {
    getuserid();
    super.onInit();
  }

  getuserid() {
    uid.value = FirebaseAuth.instance.currentUser == null
        ? ""
        : FirebaseAuth.instance.currentUser!.uid;
    print("user token  $uid");
  }

  onItemTapped(int index) {
    currentPosition = index.obs;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final tabs = <Widget>[
    const OverviewView(),
    const TransactionsView(),
    const InvestView(),
    const AccountView()
  ];
}
