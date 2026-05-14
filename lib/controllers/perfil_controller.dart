import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/perfil_model.dart';
import '../views/login_page.dart';
import 'login_controller.dart';
import 'meu_deck_controller.dart';

class PerfilController extends ChangeNotifier {

  PerfilModel perfil = const PerfilModel(
    nome: 'Duelista',
    email: 'duelista@yugioh.com',
    avatarPath: null,
  );

  final List<String> avataresDisponiveis = <String>[
    'assets/personagens/yugi.jpg',
    'assets/personagens/kaiba.jpg',
    'assets/personagens/joey.jpg',
    'assets/personagens/mai.jpg',
  ];

  static const String _chaveNome = 'perfil_nome';
  static const String _chaveEmail = 'perfil_email';
  static const String _chaveAvatar = 'perfil_avatar';

  Future<void> inicializar() async {
    await _carregarPerfil();
  }

  Future<void> atualizarNome(String novoNome) async {
    perfil = perfil.copyWith(
      nome: novoNome.trim(),
    );
    await _salvarPerfil();
    notifyListeners();
  }

  Future<void> atualizarEmail(String novoEmail) async {
    perfil = perfil.copyWith(
      email: novoEmail.trim(),
    );
    await _salvarPerfil();
    notifyListeners();
  }

  Future<void> atualizarAvatar(String caminho) async {
    perfil = perfil.copyWith(
      avatarPath: caminho,
    );
    await _salvarPerfil();
    notifyListeners();
  }

  Future<void> _salvarPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _chaveNome,
      perfil.nome,
    );
    await prefs.setString(
      _chaveEmail,
      perfil.email,
    );
    if (perfil.avatarPath != null) {
      await prefs.setString(
        _chaveAvatar,
        perfil.avatarPath!,
      );
    }
  }

  Future<void> _carregarPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    perfil = PerfilModel(
      nome: prefs.getString(_chaveNome) ?? 'Duelista',
      email: prefs.getString(_chaveEmail) ?? 'duelista@yugioh.com',
      avatarPath: prefs.getString(_chaveAvatar),
    );
    notifyListeners();
  }

  Future<void> _limparPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveNome);
    await prefs.remove(_chaveEmail);
    await prefs.remove(_chaveAvatar);
    perfil = const PerfilModel(
      nome: 'Duelista',
      email: 'duelista@yugioh.com',
      avatarPath: null,
    );
    notifyListeners();
  }

  Future<void> fazerLogout(BuildContext context) async {
    await Future.wait(<Future<void>>[
      _limparPerfil(),
      MeuDeckController().limpar(),
      LoginController.limparSessao(),
    ]);
    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<LoginPage>(
        builder: (_) => const LoginPage(),
      ),
          (Route<dynamic> route) => false,
    );
  }
}