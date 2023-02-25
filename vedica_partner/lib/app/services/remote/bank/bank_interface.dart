import 'package:vedica_partner/app/data/custom_response_model.dart';

abstract class BankInterface {
  addBank(Map<String, dynamic> data);
  addKyc(Map<String, dynamic> data);
  addWithdrawleRequest(Map<String, dynamic> data);
  addNominee(Map<String, dynamic> data);
  getNominee(String token);
  getBank(String token);
  getKyc(String token);
}
