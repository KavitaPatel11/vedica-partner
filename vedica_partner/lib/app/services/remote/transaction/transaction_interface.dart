import 'package:vedica_partner/app/data/custom_response_model.dart';

abstract class TransactionsInterface {
  // addPortFolio(Map<String, dynamic> data);
  getAllTransaction(String token, int pageNumber);
  getwithdrawlTransaction(String token, int pageNumber);
  // getBalance(String token);
}
