import 'package:vedica_partner/app/data/custom_response_model.dart';

abstract class PortFolioInterface {
  addPortFolio(Map<String, dynamic> data);
  getPortPolio(String token, int pageNumber);
  getBalance(String token);
  getProfile(String token);
}
