import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vedica_partner/app/modules/transactions/views/tabs/general_transaction.dart';
import 'package:vedica_partner/app/modules/transactions/views/tabs/withdrawal_transaction.dart';
import 'package:vedica_partner/app/providers/transactions_provider.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  void initState() {
    var videosBloc = Provider.of<TrasactionsProvider>(context, listen: false);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var videosBloc = Provider.of<TrasactionsProvider>(context);

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.bgcolor,
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: Texttheme.heading
                .copyWith(color: MyColor.yellowColor, fontSize: 30),
            title: Text("Transactions"),
            backgroundColor: MyColor.bgcolor,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: TabBar(
                tabs: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("General"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Withdrawl"),
                  )
                ],
                automaticIndicatorColorAdjustment: false,
                labelStyle:
                    Texttheme.headingTwo.copyWith(fontWeight: FontWeight.w400),
                indicatorColor: MyColor.bgcolor,
                indicatorWeight: 2.0,
                indicatorSize: TabBarIndicatorSize.label,
              ),
            ),
          ),
          body: TabBarView(
            children: [GeneralTrasactionScren(), WithdrawlTrasactionScren()],
          ),
        ),
      ),
    );
  }
}
