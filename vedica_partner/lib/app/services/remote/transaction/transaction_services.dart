import 'package:get/get.dart';
import 'package:vedica_partner/app/controller/base_controller.dart';

import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/base_client.dart';
import 'package:vedica_partner/app/services/remote/transaction/transaction_interface.dart';

import 'package:vedica_partner/utils/endpoints.dart';

class TransactionsService with BaseController implements TransactionsInterface {
  final BaseClient _client = BaseClient();

  @override
  getAllTransaction(String token, int PageNumber) async {
    final header = {"Authorization": "Bearer $token"};

    final response = await _client
        .get(Endpoint.getAllTransactions + "?page=$PageNumber", header)
        .catchError(handleError);

    print("all Transactions $response");
    return response;
  }

  @override
  getwithdrawlTransaction(String token, int PageNumber) async {
    final header = {"Authorization": "Bearer $token"};

    final response = await _client
        .get(Endpoint.getWithdrawlTransactions + "?page=$PageNumber", header)
        .catchError(handleError);

    print("all Transactions $response");
    return response;
  }
}
