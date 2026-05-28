import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/models/auth/auth_model.dart';


class AuthProvider extends ChangeNotifier {

  bool isLoading = false;

  bool isLoggedIn = false;

  String userEmail = "";

  final authBox =
      Hive.box<AuthModel>('authBox');

  /// LOGIN
  Future<bool> login({
    required String email,
    required String password,
  }) async {

    isLoading = true;

    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 2),
    );

    /// DEMO LOGIN
    if (email == 'admin@gmail.com' &&
        password == '123456') {

      final authData = AuthModel(
        isLoggedIn: true,
        email: email,
      );

      /// STORE LOCALLY IN HIVE
      await authBox.put(
        "user",
        authData,
      );

      isLoggedIn = true;

      userEmail = email;

      isLoading = false;

      notifyListeners();

      return true;
    }

    isLoading = false;

    notifyListeners();

    return false;
  }

  /// CHECK LOGIN
  Future<void> checkLogin() async {

    final data =
        authBox.get("user");

    if (data != null) {

      isLoggedIn =
          data.isLoggedIn;

      userEmail =
          data.email;
    }

    notifyListeners();
  }

  /// LOGOUT
  Future<void> logout() async {

    await authBox.clear();

    isLoggedIn = false;

    userEmail = "";

    notifyListeners();
  }
}