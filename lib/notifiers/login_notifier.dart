import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_state.dart';

class LoginNotifier extends Notifier<LoginState> {
  static const String _chaveLogado = 'usuario_logado';

  static final RegExp _regexSenha = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
  );

  @override
  LoginState build() {
    return const LoginState();
  }

  void alterarManterConectado(bool valor) {
    state = state.copyWith(manterConectado: valor);
  }

  void alterarVisibilidadeSenha() {
    state = state.copyWith(senhaVisivel: !state.senhaVisivel);
  }

  void onEmailChanged() {
    if (state.erroEmail != null) {
      state = state.copyWith(erroEmail: null);
    }
  }

  void onSenhaChanged() {
    if (state.erroSenha != null) {
      state = state.copyWith(erroSenha: null);
    }
  }

  Future<bool> fazerLogin(
    String email,
    String senha,
    Future<void> Function(String) atualizarEmailPerfil,
  ) async {
    String? erroEmail;
    String? erroSenha;

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
      state = state.copyWith(erroEmail: erroEmail, erroSenha: erroSenha);
      return false;
    }

    state = state.copyWith(isLoading: true, erroEmail: null, erroSenha: null);
    await Future.delayed(const Duration(seconds: 2));

    if (state.manterConectado) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_chaveLogado, true);
    }

    await atualizarEmailPerfil(email.trim());
    state = state.copyWith(isLoading: false);
    return true;
  }

  Future<void> limparSessao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveLogado);
  }

  Future<bool> estaLogado() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chaveLogado) ?? false;
  }
}
