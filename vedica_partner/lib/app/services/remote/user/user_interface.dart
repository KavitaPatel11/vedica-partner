import 'package:vedica_partner/app/data/custom_response_model.dart';

abstract class UserInterface {
  login(String userId, String phone);
  updateUser(Map<String, dynamic> data);
  getProfile(String token);
}
