import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kings_lab_test/controller/services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user => _user;

  AuthService authService = AuthService();

  Future<void> login(String username, String password) async {
    try {
      authService.login(username: username, password: password);
      Fluttertoast.showToast(msg: 'Login succesful');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Login failed');
    }
  }
}
