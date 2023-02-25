import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/portfolios_controller.dart';

class PortfoliosView extends GetView<PortfoliosController> {
  const PortfoliosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PortfoliosView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PortfoliosView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
