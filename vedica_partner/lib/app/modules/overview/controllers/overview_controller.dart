import 'package:get/get.dart';
import 'package:vedica_partner/app/data/user_detail_model.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/user/user_service.dart';

class OverviewController extends GetxController {
  //TODO: Implement OverviewController

  final UserService _service = UserService();
  final LocalResourceManager _manager = LocalResourceManager();
  var userDetailModel = UserDetailModel().obs;
  bool isloading2 = false;

  void _updateIsLoading2(bool currentStatus) {
    isloading2 = currentStatus;
    update();
  }

  @override
  void onInit() {
    getKycDetail();
    super.onInit();
  }

  getKycDetail() async {
    try {
      _updateIsLoading2(true);
      final response = await _service.getProfile(_manager.getToken()!);

      if (response != null) {
        var baseResponse = UserDetailModel.fromJson(response);

        if (baseResponse.subCode == 200) {
          userDetailModel.value = baseResponse;
          LocalResourceManager.setName(baseResponse.items!.fullName.toString());
          LocalResourceManager.setNumber(baseResponse.items!.phone.toString());
          print("user detail $baseResponse");
        }
        _updateIsLoading2(false);
        update();
      }
    } finally {
      _updateIsLoading2(false);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
