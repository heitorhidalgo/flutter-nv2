import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  bool manterConectado = false;

  static const _chaveLogado = 'usuario_logado';

  void alterarManterConectado(bool valor) {
    manterConectado = valor;
    notifyListeners();
  }

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

    if (manterConectado) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_chaveLogado, true);
    }

    isLoading = false;
    notifyListeners();
    return true;
  }

  static Future<void> limparSessao() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveLogado);
  }

  static Future<bool> estaLogado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chaveLogado) ?? false;
  }
}