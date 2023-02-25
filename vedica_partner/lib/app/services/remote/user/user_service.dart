import 'dart:convert';

import 'package:get/get.dart';
import 'package:vedica_partner/app/controller/base_controller.dart';
import 'package:vedica_partner/app/data/custom_response_model.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/base_client.dart';
import 'package:vedica_partner/app/services/remote/user/user_interface.dart';
import 'package:vedica_partner/utils/endpoints.dart';

class UserService with BaseController implements UserInterface {
  final BaseClient _client = BaseClient();

  @override
  login(String userId, String phone) async {
    final response = await _client.post(Endpoint.login,
        {"userId": userId, "phone": phone}).catchError(handleError);
    if (response != null) {
      return response;
    }
    return null;
  }

  @override
  updateUser(Map<String, dynamic> data) {
    final token = LocalResourceManager().getToken();

    print("999 token $token");
    if (token != null) {
      final header = {"Authorization": "Bearer $token"};
      final response = _client.post(Endpoint.updateUser, data, header);
      return response;
    } else {
      Get.offAllNamed("/login");
    }
  }

  @override
  getProfile(String token) async {
    final header = {"Authorization": "Bearer $token"};

    final response =
        await _client.get(Endpoint.profile, header).catchError(handleError);
    return response;
  }
}
