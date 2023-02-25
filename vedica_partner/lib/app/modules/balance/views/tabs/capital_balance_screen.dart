import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vedica_partner/app/modules/balance/controllers/balance_controller.dart';
import 'package:vedica_partner/app/providers/data_providers.dart';
import 'package:vedica_partner/component/buttons/rounded_btn.dart';
import 'package:vedica_partner/component/textfields/invest_textfield.dart';
import 'package:vedica_partner/utils/error_helper.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class CapitalBalance extends StatefulWidget {
  const CapitalBalance({super.key});

  @override
  State<CapitalBalance> createState() => _CapitalBalanceState();
}

class _CapitalBalanceState extends State<CapitalBalance> {
  final BalanceController balanceController = Get.put(BalanceController());
  final _formKey = GlobalKey<FormState>();
  int? investAmount = 0;
  bool readonliy = false;
  @override
  void initState() {
    super.initState();
    var balanceMod = Provider.of<DataProvider>(context, listen: false);
    balanceMod.getBalanceData();
    investAmount = int.parse(
        "${balanceMod.allBalanceModel.items == null ? "0" : balanceMod.allBalanceModel.items!.investAmount}");
    balanceMod.resetStreams();
  }

  @override
  Widget build(BuildContext context) {
    var balanceMod = Provider.of<DataProvider>(context);

    return Consumer<DataProvider>(builder: (context, data, child) {
      return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Capital Balance",
                  style:
                      Texttheme.hintStyle.copyWith(color: MyColor.yellowColor),
                ),
                SizedBox(
                  height: 10,
                ),
                balanceMod.balanceLoading
                    ? SizedBox()
                    : Text(
                        "$investAmount",
                        style: Texttheme.title,
                      ),
                SizedBox(
                  height: 40,
                ),
                investAmount! < 100
                    ? InvestmentTextFormField(
                        onTab: () {
                          Errorhelper.showErrorToast(
                              context, "Not enough wallet balance(Min.100)");
                        },
                        readonly: true,
                        labeltext: "Request Amount",
                        textInputType: TextInputType.number,
                        controller: balanceController.amountController,
                        onvalidate: (value) {},
                      )
                    : InvestmentTextFormField(
                        labeltext: "Request Amount",
                        textInputType: TextInputType.number,
                        controller: balanceController.amountController,
                        onvalidate: (value) {
                          if (int.parse("$investAmount") < 100) {
                            return "Not enough wallet balance(Min.100)";
                          }
                          if (value!.isEmpty) {
                            return "Please enetr some amount to proceed";
                          } else if (int.parse(value.toString()) >
                              investAmount!.toInt()) {
                            return "You can not withdraw amount more than $investAmount";
                          }
                          return null;
                        },
                      ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  width: 160,
                  child: data.loading
                      ? Container(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: MyColor.yellowColor,
                            ),
                          ),
                        )
                      : RoundedButton(
                          color: MyColor.lightyellowColor,
                          onPressed: () {
                            var now = DateTime.now();

                            var beginningNextMonth = (now.month < 12)
                                ? DateTime(now.year, now.month + 1, 1)
                                : DateTime(now.year + 1, 1, 1);
                            var lastDay = beginningNextMonth
                                .subtract(Duration(days: 1))
                                .day;
                            var last2Day = beginningNextMonth
                                .subtract(Duration(days: 2))
                                .day;

                            var currentday = now.day;

                            var valid = _formKey.currentState!.validate();
                            if (valid) {
                              if (investAmount! < 100) {
                                Errorhelper.showErrorToast(context,
                                    "Not enough wallet balance(Min.100)");
                              } else if (currentday == lastDay ||
                                  currentday == last2Day) {
                                _createwithdrawRequest();
                              } else {
                                Errorhelper.showErrorToast(context,
                                    "you can only request at the last two days of month");
                              }
                            }
                            return;
                          },
                          title: "Submit Request"),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _createwithdrawRequest() async {
    String amonut = balanceController.amountController.text.trim();

    var data = {
      "amonut ": amonut,
    };
    var provider = Provider.of<DataProvider>(context, listen: false);
    await provider.createwithdrawlerequest("Capital withdrawal", amonut);
    if (provider.isBack) {
      balanceController.amountController.text = "";
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Homeview()),
      // );
    }
  }
}
