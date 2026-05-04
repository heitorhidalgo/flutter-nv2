import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/perfil_model.dart';
import 'package:flutter_nv2/views/login_page.dart';
import 'package:flutter_nv2/controllers/meu_deck_controller.dart';

class PerfilController extends ChangeNotifier {
  static final PerfilController _instancia = PerfilController._interno();
  factory PerfilController() => _instancia;
  PerfilController._interno();

  PerfilModel perfil = const PerfilModel(
    nome: 'Duelista',
    email: 'duelista@yugioh.com',
    avatarPath: null,
  );

  final List<String> avataresDisponiveis = [
    'assets/personagens/yugi.jpg',
    'assets/personagens/kaiba.jpg',
    'assets/personagens/joey.jpg',
    'assets/personagens/mai.jpg',
  ];

  static const _chaveNome = 'perfil_nome';
  static const _chaveEmail = 'perfil_email';
  static const _chaveAvatar = 'perfil_avatar';

  Future<void> inicializar() async {
    await _carregarPerfil();
  }

  void atualizarNome(String novoNome) {
    perfil = perfil.copyWith(nome: novoNome.trim());
    _salvarPerfil();
    notifyListeners();
  }

  void atualizarAvatar(String caminho) {
    perfil = perfil.copyWith(avatarPath: caminho);
    _salvarPerfil();
    notifyListeners();
  }

  Future<void> _salvarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveNome, perfil.nome);
    await prefs.setString(_chaveEmail, perfil.email);
    if (perfil.avatarPath != null) {
      await prefs.setString(_chaveAvatar, perfil.avatarPath!);
    }
  }

  Future<void> _carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    perfil = PerfilModel(
      nome: prefs.getString(_chaveNome) ?? 'Duelista',
      email: prefs.getString(_chaveEmail) ?? 'duelista@yugioh.com',
      avatarPath: prefs.getString(_chaveAvatar),
    );
    notifyListeners();
  }

  Future<void> _limparPerfil() async {
    final prefs = await SharedPreferences.getInstance();
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
    await Future.wait([
      _limparPerfil(),
      MeuDeckController().limpar(),
    ]);

    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }
}