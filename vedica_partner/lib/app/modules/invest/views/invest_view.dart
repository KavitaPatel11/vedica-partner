import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:upi_india/upi_india.dart';
import 'package:vedica_partner/app/providers/data_providers.dart';

import 'package:vedica_partner/component/buttons/rounded_btn.dart';
import 'package:vedica_partner/utils/error_helper.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class InvestView extends StatefulWidget {
  const InvestView({Key? key}) : super(key: key);

  @override
  State<InvestView> createState() => _InvestViewState();
}

class _InvestViewState extends State<InvestView> {
  double _total_amount = 5000.0;
  double _total_lockingperiod = 24;
  double minlocking_period = 6;
  double min_amount = 5000;
  double _profit_daily = 4.74;
  double __profit_monthly = 145.50;
  double __profit_yearly = 1746.00;

  String? _upiAddrError;

  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();

  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;
  Path customPath = Path()
    // ..moveTo(20, 20)
    ..lineTo(200, 0)
    ..lineTo(20, 200)
    ..lineTo(100, 100)
    ..lineTo(20, 20);

  @override
  void initState() {
    _total_lockingperiod = 6;
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  _counter() {
    if (_total_amount > 50000) {
      setState(() {
        minlocking_period = 12;
        _total_lockingperiod = minlocking_period;
      });
      print(" minlocking_period  $minlocking_period");
    } else {
      setState(() {
        minlocking_period = 6;
        _total_lockingperiod = minlocking_period;
      });
      print(" minlocking_period  $minlocking_period");
    }
  }

  calculator() {
    setState(() {
      _profit_daily = ((_total_amount * 35 * 1) / (100 * 365)).toPrecision(2);
      __profit_monthly = ((_total_amount * 35 * 1) / (100 * 12)).toPrecision(2);
      __profit_yearly = ((_total_amount * 35 * 1) / 100).toPrecision(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: MyColor.yellowColor),
            centerTitle: true,
            titleTextStyle: Texttheme.heading
                .copyWith(color: MyColor.yellowColor, fontSize: 30),
            title: const Text("Invest"),
            backgroundColor: MyColor.bgcolor,
          ),
          backgroundColor: MyColor.bgcolor,
          body: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: MyColor.accentWhite.withOpacity(0.09)),
              child: Column(
                children: [
                  Text("Profit Calculator", style: Texttheme.subtitle),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Where is our capital being used?",
                          style: Texttheme.subtitle.copyWith(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: DottedDecoration(
                      color: MyColor.accentWhite,
                      shape: Shape.box,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ), //remove this to get plane rectange
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Daily",
                              style: Texttheme.subtitle,
                            ),
                            Text(
                              "Monthly",
                              style: Texttheme.subtitle,
                            ),
                            Text(
                              "Yearly",
                              style: Texttheme.subtitle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "$_profit_daily",
                              style: Texttheme.subheading
                                  .copyWith(color: MyColor.yellowColor),
                            ),
                            Text(
                              "$__profit_monthly",
                              style: Texttheme.subheading
                                  .copyWith(color: MyColor.yellowColor),
                            ),
                            Text(
                              "$__profit_yearly",
                              style: Texttheme.subheading
                                  .copyWith(color: MyColor.yellowColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Investment Amount", style: Texttheme.bodyStyle),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_total_amount > 5000)
                                    _total_amount = _total_amount - 10;
                                  _counter();
                                  calculator();
                                });
                              },
                              child: Icon(
                                Icons.remove,
                                color: MyColor.yellowColor,
                              )),
                          Expanded(
                            child: Column(
                              children: [
                                // Text(
                                //   _total_amount.round().toString(),
                                //   style: Texttheme.subheading,
                                // ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: MyColor.yellowColor,
                                    thumbColor: MyColor.yellowColor,
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 1),
                                  ),
                                  child: Slider(
                                    min: 5000,
                                    value: _total_amount,
                                    max: 10000000,
                                    activeColor: MyColor.yellowColor,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _total_amount = value;
                                        _counter();
                                        calculator();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_total_amount < 10000000)
                                    _total_amount = _total_amount + 10;
                                  _counter();
                                  calculator();
                                });
                              },
                              child: Icon(
                                Icons.add,
                                color: MyColor.yellowColor,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("₹${_total_amount.toPrecision(2)}",
                          style: Texttheme.headingTwo.copyWith(
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
                              color: MyColor.yellowColor.withOpacity(0.5))),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Locking Period", style: Texttheme.bodyStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_total_lockingperiod > 1)
                                    _total_lockingperiod =
                                        _total_lockingperiod - 1;
                                });
                              },
                              child: Icon(
                                Icons.remove,
                                color: MyColor.yellowColor,
                              )),
                          Expanded(
                            child: Slider(
                              activeColor: MyColor.yellowColor,
                              min: minlocking_period,
                              value: _total_lockingperiod,
                              max: 24,
                              // divisions: 100,
                              // label: _total_amount.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _total_lockingperiod = value;
                                });
                                print(
                                    "======_total_lockingperiod======$_total_lockingperiod========");
                              },
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_total_lockingperiod < 24)
                                    _total_lockingperiod =
                                        _total_lockingperiod + 1;
                                });
                              },
                              child: Icon(
                                Icons.add,
                                color: MyColor.yellowColor,
                              )),
                        ],
                      ),
                      Text("${_total_lockingperiod.toInt()} Month",
                          style: Texttheme.headingTwo.copyWith(
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
                              color: MyColor.yellowColor.withOpacity(0.5))),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 75,
                        child: RoundedButton(
                            color: MyColor.lightyellowColor,
                            onPressed: () {
                              Get.bottomSheet(
                                getbottomshet(),
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor: MyColor.accentWhite,
                              );
                            },
                            title: "Invest Now"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9174100683@ybl",
      receiverName: 'Syama takur',
      transactionRefId: 'ppppp',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.0,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return const Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: Texttheme.subheading.copyWith(color: MyColor.bgcolor),
        ),
      );
    else
      // ignore: curly_braces_in_flow_control_structures
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () async {
                  _transaction = initiateTransaction(app);
                  print(
                      "t=========_transaction===========${_transaction!.asStream()}=========");
                  UpiResponse? _upiResponse = await _transaction;
                  print(
                      "t=========__upiResponse====status=======${_upiResponse!.status}=========");
                  print(
                      "t=========__upiResponse= _upiResponse.responseCode==========${_upiResponse.responseCode}=========");
                  _checkTxnStatus(_upiResponse.status!);
                  setState(() {});
                  Get.back();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        _addPortfolio();
        // Errorhelper.showToast('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        Errorhelper.showErrorToast(context, "Transaction Failed");
        Get.back();
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: Texttheme.subheading),
          Flexible(
              child: Text(
            body,
            style: Texttheme.subheading,
          )),
        ],
      ),
    );
  }

  getbottomshet() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              displayUpiApps(),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addPortfolio() async {
    var data = {
      "investAmount": "${_total_amount.toInt()}",
      "locking": "${_total_lockingperiod.toInt()}"
    };
    print("data $data");
    var provider = Provider.of<DataProvider>(context, listen: false);
    await provider.addportfolio(
        _total_amount.toString(), _total_lockingperiod.toString());

    print("==========provider.isBack=========${provider.isBack}============");
    if (provider.isBack == true) {
      Get.offNamedUntil("splash", (route) => false);
    }
  }
}
