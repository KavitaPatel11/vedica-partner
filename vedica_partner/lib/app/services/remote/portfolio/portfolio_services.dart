import 'package:get/get.dart';
import 'package:vedica_partner/app/controller/base_controller.dart';

import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/base_client.dart';
import 'package:vedica_partner/app/services/remote/portfolio/portfoli_interface.dart';

import 'package:vedica_partner/utils/endpoints.dart';

class PortFolioService with BaseController implements PortFolioInterface {
  final BaseClient _client = BaseClient();

  @override
  addPortFolio(Map<String, dynamic> data) {
    final token = LocalResourceManager().getToken();

    print("token $token");
    if (token != null) {
      final header = {"Authorization": "Bearer $token"};
      final response = _client.post(Endpoint.addPortfolio, data, header);
      return response;
    } else {
      Get.offAllNamed("/login");
    }
  }

  @override
  updatelocking(Map<String, dynamic> data, String portfolioId) {
    final token = LocalResourceManager().getToken();

    print("token $token");
    if (token != null) {
      final header = {"Authorization": "Bearer $token"};
      final response =
          _client.post(Endpoint.updateLocking + portfolioId, data, header);
      return response;
    } else {
      Get.offAllNamed("/login");
    }
  }

  @override
  getPortPolio(String token, int PageNumber) async {
    final header = {"Authorization": "Bearer $token"};

    final response = await _client
        .get(Endpoint.getAllPortfolio + "?page=$PageNumber", header)
        .catchError(handleError);

    print("all portfolio $response");
    return response;
  }

  @override
  getBalance(String token) async {
    final header = {"Authorization": "Bearer $token"};

    final response =
        await _client.get(Endpoint.getBalance, header).catchError(handleError);
    return response;
  }

  @override
  getProfile(String token) async {
    final header = {"Authorization": "Bearer $token"};

    final response =
        await _client.get(Endpoint.profile, header).catchError(handleError);
    return response;
  }
}
