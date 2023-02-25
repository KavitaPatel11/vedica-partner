import 'package:get/get.dart';

import '../controllers/ekyc_controller.dart';

class EkycBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EkycController>(
      () => EkycController(),
    );
  }
}
