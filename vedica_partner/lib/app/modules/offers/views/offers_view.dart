import 'package:flutter/material.dart';

import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class OffersView extends StatefulWidget {
  const OffersView({Key? key}) : super(key: key);

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.bgcolor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: TabBar(
                // isScrollable: true,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Used"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Active"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Expired"),
                  )
                ],
                automaticIndicatorColorAdjustment: false,
                labelStyle: Texttheme.headingTwo,
                indicatorColor: MyColor.bgcolor,
                indicatorWeight: 2.0,
                indicatorSize: TabBarIndicatorSize.label,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                  child: Text(
                "Used",
                style: Texttheme.headingTwo,
              )),
              Center(
                  child: Text(
                "Active",
                style: Texttheme.headingTwo,
              )),
              Center(
                  child: Text(
                "Expired",
                style: Texttheme.headingTwo,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
