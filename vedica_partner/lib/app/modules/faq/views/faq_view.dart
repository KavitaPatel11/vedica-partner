import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/faq/views/accordian.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.bgcolor,
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
          title: Text("FAQ"),
          backgroundColor: MyColor.bgcolor,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40),
          children: [
            Accordion(
              title: 'What is Crowdfunding?',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum ornare vulputate. Curabitur faucibus condimentum purus quis tristique.',
            ),
            Accordion(
                title: 'What is locking Period?',
                content:
                    'Fusce ex mi, commodo ut bibendum sit amet, faucibus ac felis. Nullam vel accumsan turpis, quis pretium ipsum. Pellentesque tristique, diam at congue viverra, neque dolor suscipit justo, vitae elementum leo sem vel ipsum'),
            Accordion(
                title: 'Where is our provide safety to our Investment?',
                content:
                    'Nulla facilisi. Donec a bibendum metus. Fusce tristique ex lacus, ac finibus quam semper eu. Ut maximus, enim eu ornare fringilla, metus neque luctus est, rutrum accumsan nibh ipsum in erat. Morbi tristique accumsan odio quis luctus.'),
          ],
        ));
  }
}
