import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  bool manterConectado = false;
  bool senhaVisivel = false;
  String? erroEmail;
  String? erroSenha;
  static const _chaveLogado = 'usuario_logado';
  static final _regexSenha = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
  );

  void alterarManterConectado(bool valor) {
    manterConectado = valor;
    notifyListeners();
  }

  void alterarVisibilidadeSenha() {
    senhaVisivel = !senhaVisivel;
    notifyListeners();
  }

  void onEmailChanged() {
    if (erroEmail != null) {
      erroEmail = null;
      notifyListeners();
    }
  }

  void onSenhaChanged() {
    if (erroSenha != null) {
      erroSenha = null;
      notifyListeners();
    }
  }

  Future<bool> fazerLogin(String email, String senha) async {
    erroEmail = null;
    erroSenha = null;

    if (email.isEmpty) {
      erroEmail = 'login.erro_campos_vazios'.tr();
    } else if (!email.contains('@') || !email.contains('.')) {
      erroEmail = 'login.erro_email_invalido'.tr();
    }

    if (senha.isEmpty) {
      erroSenha = 'login.erro_campos_vazios'.tr();
    } else if (!_regexSenha.hasMatch(senha)) {
      erroSenha = 'login.erro_senha_requisitos'.tr();
    }

    if (erroEmail != null || erroSenha != null) {
      notifyListeners();
      return false;
    }

    isLoading = true;
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