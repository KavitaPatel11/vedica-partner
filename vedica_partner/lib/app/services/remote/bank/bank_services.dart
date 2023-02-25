import 'package:get/get.dart';
import 'package:vedica_partner/app/controller/base_controller.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/bank/bank_interface.dart';
import 'package:vedica_partner/app/services/remote/base_client.dart';
import 'package:vedica_partner/utils/endpoints.dart';

class BankService with BaseController implements BankInterface {
  final BaseClient _client = BaseClient();

  @override
  addBank(Map<String, dynamic> data) {
    final token = LocalResourceManager().getToken();

    print("token $token");
    if (token != null) {
      final header = {
        "Authorization": "Bearer ${LocalResourceManager().getToken()}"
      };
      final response = _client.post(Endpoint.addBank, data, header);
      return response;
    } else {
      Get.offAllNamed("/home");
    }
  }

  @override
  updateBank(Map<String, dynamic> data) {
    final token = LocalResourceManager().getToken();

    print("token $token");
    if (token != null) {
      final header = {
        "Authorization": "Bearer ${LocalResourceManager().getToken()}"
      };
      final response = _client.post(Endpoint.editBank, data, header);
      return response;
    } else {
      Get.offAllNamed("/home");
    }
  }

  @override
  addKyc(Map<String, dynamic> data) {
    final token = LocalResourceManager().getToken();

    print("token $token");
    if (token != null) {
      final header = {
        "Authorization": "Bearer ${LocalResourceManager().getToken()}"
      };
      final response = _client.post(Endpoint.addKyc, data, header);
      return response;
    } else {
      Get.offAllNamed("/home");
    }
  }

  @override
  getBank(String token) async {
    final header = {"Authorization": "Bearer $token"};

    final response =
        await _client.get(Endpoint.getBank, header).catchError(handleError);
    return response;
  }

  @override
  getKyc(String token) async {
    final header = {"Authorization": "Bearer $token"};

    final response =
        await _client.get(Endpoint.getKyc, header).catchError(handleError);
    return response;
  }

  @override
  addWithdrawleRequest(Map<String, dynamic> data) {
    final token = LocalResourceManager().getToken();

    print("token $token");
    if (token != null) {
      final header = {
        "Authorization": "Bearer ${LocalResourceManager().getToken()}"
      };
      final response =
          _client.post(Endpoint.createWithdrawlRequest, data, header);
      return response;
    } else {
      Get.offAllNamed("/home");
    }
  }

  @override
  getNominee(String token) async {
    final header = {"Authorization": "Bearer $token"};

    final response =
        await _client.get(Endpoint.getNominee, header).catchError(handleError);
    return response;
  }

  @override
  addNominee(Map<String, dynamic> data) {
    final token = LocalResourceManager().getToken();

    print(" add nominte token $token");
    if (token != null) {
      final header = {"Authorization": "Bearer $token"};
      final response = _client.post(Endpoint.addNominee, data, header);
      return response;
    } else {
      Get.offAllNamed("/home");
    }
  }
}
