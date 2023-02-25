import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vedica_partner/app/data/all_transaction_model.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/component/card/no_data_card.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/endpoints.dart';
import 'package:vedica_partner/utils/my_colors.dart';

import '../../../../../component/card/trasactions_card.dart';

class GeneralTrasactionScren extends StatefulWidget {
  const GeneralTrasactionScren({super.key});

  @override
  State<GeneralTrasactionScren> createState() => _GeneralTrasactionScrenState();
}

class _GeneralTrasactionScrenState extends State<GeneralTrasactionScren> {
  int _page = 1;

  bool _hasNextPage = true;

  bool _isFirstLoadRunning = false;

  bool _isLoadMoreRunning = false;

  var _posts;
  var alltransaction = AllTransactionModel();
  bool nodata = true;

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(
          Uri.parse(
              "${Endpoint.baseUrl}${Endpoint.getAllTransactions}?page=$_page"),
          headers: {
            "Authorization": "Bearer ${LocalResourceManager().getToken()}"
          });

      setState(() {
        _posts = json.decode(res.body);
        print("====posts====================$_posts=============");

        print("====posts====================${_posts['status']}=============");
        if (_posts['status'] == true) {
          alltransaction = AllTransactionModel.fromJson(_posts);
        } else {
          nodata == _posts['status'];
        }
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {
        final res = await http.get(
            Uri.parse(
                "${Endpoint.baseUrl}${Endpoint.getAllTransactions}?page=$_page"),
            headers: {
              "Authorization": "Bearer ${LocalResourceManager().getToken()}"
            });

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
            alltransaction = AllTransactionModel.fromJson(_posts);
          });
        } else {}
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("========alltransaction============${alltransaction}============");
    return Scaffold(
      backgroundColor: MyColor.bgcolor,
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : alltransaction.status == null
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: NoDataCard(
                      image: ConstentsAssets.nodata,
                      message: "No Transactions Found"),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColor.accentWhite.withOpacity(0.1)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            shrinkWrap: true,
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                Divider(
                                  height: 5,
                                  color: MyColor.accentWhite.withOpacity(0.6),
                                  thickness: 2,
                                ),
                            controller: _controller,
                            itemCount: alltransaction.items!.docs!.length,
                            itemBuilder: (_, index) => TrasactionsCard(
                                  date:
                                      "${alltransaction.items!.docs![index].date == null ? "" : alltransaction.items!.docs![index].date}",
                                  dailyInterest:
                                      "${alltransaction.items!.docs![index].amount == null ? "" : alltransaction.items!.docs![index].amount}",
                                  paymentType:
                                      "${alltransaction.items!.docs![index].type == null ? "" : alltransaction.items!.docs![index].type}",
                                  reason:
                                      '${alltransaction.items!.docs![index].reason == null ? "" : alltransaction.items!.docs![index].reason}',
                                )),
                      ),

                      // when the _loadMore function is running
                      if (_isLoadMoreRunning == true)
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 40),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      // When nothing else to load
                      if (_hasNextPage == false)
                        Container(
                          padding: const EdgeInsets.only(top: 30, bottom: 40),
                          color: Colors.amber,
                          child: const Center(
                            child: Text('You have fetched all of the content'),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }
}
