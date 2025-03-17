import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userId;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;

  Future<bool> login(String email, String password) async {
    // Implement your login logic here
    // For this example, we'll just set _isLoggedIn to true
    _isLoggedIn = true;
    _userId = 'user123';
    notifyListeners();
    return _isLoggedIn;
  }

  void logout() {
    _isLoggedIn = false;
    _userId = null;
    notifyListeners();
  }
}
