import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<bool> fazerLogin(String email, String senha) async {
    if (email.isEmpty || senha.isEmpty) {
      errorMessage = 'login.erro_campos_vazios'.tr();
      notifyListeners();
      return false;
    }

    if (!email.contains('@')) {
      errorMessage = 'login.erro_email_invalido'.tr();
      notifyListeners();
      return false;
    }

    if (senha.length < 6) {
      errorMessage = 'login.erro_senha_requisitos'.tr();
      notifyListeners();
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
    return true;
  }
}