import 'package:get_storage/get_storage.dart';
import 'package:vedica_partner/app/services/local/keys.dart';

class LocalResourceManager {
  static setToken(String token) {
    var _box = GetStorage();
    return _box.write(Keys.USER_TOKEN, token);
  }

  String? getToken() {
    var _box = GetStorage();
    return _box.read<String?>(Keys.USER_TOKEN) ?? null;
  }

  static setRememberMe(String token) {
    var _box = GetStorage();
    return _box.write(Keys.REMEMBER_TOKEN, token);
  }

  String? getRememberMe() {
    var _box = GetStorage();
    return _box.read<String?>(Keys.REMEMBER_TOKEN) ?? null;
  }

  static setIsOnboarded(bool is_onboarded) {
    var _box = GetStorage();
    return _box.write(Keys.ISONBOARDED, is_onboarded);
  }

  bool? getIsOnboarded() {
    var _box = GetStorage();
    return _box.read<bool?>(Keys.ISONBOARDED) ?? null;
  }

  static Future<void> logout() async {
    var _box = GetStorage();
    await _box.erase();
  }

  static setName(String name) {
    var _box = GetStorage();
    return _box.write(Keys.NAME, name);
  }

  String? getName() {
    var _box = GetStorage();
    return _box.read<String?>(Keys.NAME) ?? null;
  }

  static setNumber(String number) {
    var _box = GetStorage();
    return _box.write(Keys.NUMBER, number);
  }

  String? getNumber() {
    var _box = GetStorage();
    return _box.read<String?>(Keys.NUMBER) ?? null;
  }
}
