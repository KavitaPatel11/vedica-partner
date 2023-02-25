import 'package:get/get.dart';

import '../controllers/portfolios_controller.dart';

class PortfoliosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortfoliosController>(
      () => PortfoliosController(),
    );
  }
}
