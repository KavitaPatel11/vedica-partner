import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vedica_partner/app/modules/overview/controllers/overview_controller.dart';

import 'package:vedica_partner/app/providers/data_providers.dart';
import 'package:vedica_partner/component/card/no_data_card.dart';
import 'package:vedica_partner/component/card/portfolio_card.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/error_helper.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import 'package:vedica_partner/app/data/portfolio_model.dart' as RadioModel;

class OverviewView extends StatefulWidget {
  const OverviewView({Key? key}) : super(key: key);

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  final OverviewController overviewController = Get.put(OverviewController());
  var extendlocking = 6.0;
  final elements2 = [
    "6 month",
    "12 month",
    "18 month",
    "24 month",
  ];
  int selectedIndex2 = 0;
  List<Widget> _buildItems2() {
    return elements2
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();

    var videosBloc = Provider.of<DataProvider>(context, listen: false);
    videosBloc.getBalanceData();
    videosBloc.getProfile();
    videosBloc.resetStreams();
    videosBloc.fetchPortfolio(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        videosBloc.setLoadingState(LoadMoreStatus.LOADING);

        videosBloc.fetchPortfolio(++_page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var balanceMod = Provider.of<DataProvider>(context);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColor.defaultblackColor,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                balanceMod.balanceLoading
                    ? Container(
                        height: 60,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome!",
                                  style: Texttheme.headingTwo,
                                ),
                                balanceMod.investLoading
                                    ? SizedBox()
                                    : Text(
                                        "${balanceMod.investerDetailModel.items!.fullName == null ? "Anonymous User" : balanceMod.investerDetailModel.items!.fullName}",
                                        style: Texttheme.headingTwo.copyWith(
                                            color: MyColor.yellowColor,
                                            fontSize: 25)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${balanceMod.allBalanceModel.items == null ? "0" : balanceMod.allBalanceModel.items!.investAmount}",
                                        style: Texttheme.subtitle.copyWith(
                                          color: MyColor.accentWhite,
                                        ),
                                      ),
                                      Text(
                                        "My Investment",
                                        style: Texttheme.bodyStyle.copyWith(
                                            color: MyColor.accentWhite
                                                .withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${balanceMod.allBalanceModel.items == null ? "0" : balanceMod.allBalanceModel.items!.profit}",
                                        style: Texttheme.subtitle,
                                      ),
                                      Text(
                                        "My Profit",
                                        style: Texttheme.bodyStyle.copyWith(
                                            color: MyColor.accentWhite
                                                .withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              "Portfolio",
                              style: Texttheme.headingTwo
                                  .copyWith(color: MyColor.yellowColor),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                Flexible(
                  child: Consumer<DataProvider>(
                    builder: (context, usersModel, child) {
                      print("stats ${usersModel.getAllPortfolio!.status}");
                      if (usersModel.getAllPortfolio!.status == false) {
                        return NoDataCard(
                            image: ConstentsAssets.nodata,
                            message: "You don't have any portfolio yet");
                      } else if (usersModel.getAllPortfolio != null &&
                          (usersModel.getAllPortfolio!.items == null
                                  ? 0
                                  : usersModel
                                      .getAllPortfolio!.items!.docs!.length) >
                              0) {
                        return _listView(usersModel);
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _listView(DataProvider dataProvider) {
    return ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: dataProvider.getAllPortfolio!.items!.docs!.length,
        itemBuilder: (context, index) {
          if ((index ==
                  dataProvider.getAllPortfolio!.items!.docs!.length - 1) &&
              dataProvider.getAllPortfolio!.items!.docs!.length <
                  dataProvider.totalRecords) {
            return Center(child: CircularProgressIndicator());
          }

          return _buildRow(dataProvider.getAllPortfolio!.items!.docs![index]);
        });
  }

  Widget _buildRow(RadioModel.Doc radioModel) {
    double _fontSize = 20.0;
    return PortfolioCard(
      onWithdrawRequest: () {
        Get.toNamed("/balance");
      },
      investment:
          "${radioModel.investAmount == null ? "" : radioModel.investAmount}",
      profit: "${radioModel.profit == null ? "" : radioModel.profit}",
      rate: "${radioModel.interest == null ? "" : radioModel.interest}",
      date: "${radioModel.createdAt == null ? "" : radioModel.createdAt}",
      onlockingPeriod: () {
        var currentdate = DateTime.now();
        var dateTime1 = DateFormat('d/M/y').parse(
            "${radioModel.portfolioDate == null ? "" : radioModel.portfolioDate}");

        final Duration diffrencef = currentdate.difference(dateTime1);
        print("========diffrence=========$diffrencef==================");

        print("${diffrencef.inDays} Days");
        var days1 = diffrencef.inDays;
        var days2 = radioModel.locking! * 30;
        print("=====days1==$days1======days2====$days2=====");
        print("=========days2 < days1=======${days2 > days1}===========");
        days2 < days1
            ? Get.defaultDialog(
                textConfirm: "Done",
                confirmTextColor: MyColor.defaultblackColor,
                buttonColor: MyColor.yellowColor,
                titlePadding: EdgeInsets.only(top: 20, bottom: 0),
                radius: 10,
                titleStyle: Texttheme.subheading.copyWith(
                  color: Colors.black,
                ),
                title: "Increase your lock period now",
                onConfirm: () {
                  _editlocking(
                      "${extendlocking.toInt()}", radioModel.portfolioId!);
                },
                content: StatefulBuilder(builder: (BuildContext context,
                    StateSetter setState /*You can rename this!*/) {
                  return Column(
                    children: [
                      Slider(
                        value: extendlocking,
                        min: 6,
                        max: 24,
                        divisions: 24,
                        onChanged: (value) {
                          setState(() {
                            extendlocking = value;
                          });
                        },
                      ),
                      Text('${extendlocking.toInt()} month'),
                    ],
                  );
                }))
            : Errorhelper.showErrorToast(
                context, "Your locking time is not expired");
      },
    );
  }

  Future<void> _editlocking(String locakingTime, String portpolioId) async {
    var data = {"locking": locakingTime, "potifoliID": portpolioId};
    print("data $data");
    var provider = Provider.of<DataProvider>(context, listen: false);
    await provider.updatelocking(portpolioId, locakingTime);

    if (provider.isBack) {
      Get.back();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String? title;
  final bool isForList;

  const MySelectionItem({Key? key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : _buildItem(context),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: MyColor.lightGreyColor),
      width: MediaQuery.of(context).size.width * 0.4,
      height: 30,
      alignment: Alignment.center,
      child: Text(
        title!,
        style:
            Texttheme.bodyStyleTwo.copyWith(color: MyColor.defaultblackColor),
      ),
    );
  }
}
