import 'package:get/get.dart';

import '../controllers/invest_controller.dart';

class InvestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestController>(
      () => InvestController(),
    );
  }
}
