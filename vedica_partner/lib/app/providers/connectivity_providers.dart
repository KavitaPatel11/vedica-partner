import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityProvider with ChangeNotifier {
  late bool? data = true;
  bool? _isOnline;
  bool? get isOnline => _isOnline;

  ConnectivityProvider() {
    Connectivity _connectivity = Connectivity();

    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    });
  }
}
