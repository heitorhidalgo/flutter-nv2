import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/perfil_model.dart';

class PerfilNotifier extends AsyncNotifier<PerfilModel> {
  static const String _chaveNome = 'perfil_nome';
  static const String _chaveEmail = 'perfil_email';
  static const String _chaveAvatar = 'perfil_avatar';

  final List<String> avataresDisponiveis = <String>[
    'assets/personagens/yugi.jpg',
    'assets/personagens/kaiba.jpg',
    'assets/personagens/joey.jpg',
    'assets/personagens/mai.jpg',
  ];

  @override
  Future<PerfilModel> build() async {
    return _carregarPerfil();
  }

  Future<void> atualizarNome(String novoNome) async {
    final PerfilModel atual = state.value!;
    state = AsyncData(atual.copyWith(nome: novoNome.trim()));
    await _salvarPerfil();
  }

  Future<void> atualizarEmail(String novoEmail) async {
    final PerfilModel atual = state.value!;
    state = AsyncData(atual.copyWith(email: novoEmail.trim()));
    await _salvarPerfil();
  }

  Future<void> atualizarAvatar(String caminho) async {
    final PerfilModel atual = state.value!;
    state = AsyncData(atual.copyWith(avatarPath: caminho));
    await _salvarPerfil();
  }

  Future<void> limparPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveNome);
    await prefs.remove(_chaveEmail);
    await prefs.remove(_chaveAvatar);
    state = const AsyncData(
      PerfilModel(
        nome: 'Duelista',
        email: 'duelista@yugioh.com',
        avatarPath: null,
      ),
    );
  }

  Future<void> _salvarPerfil() async {
    final PerfilModel perfil = state.value!;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveNome, perfil.nome);
    await prefs.setString(_chaveEmail, perfil.email);
    if (perfil.avatarPath != null) {
      await prefs.setString(_chaveAvatar, perfil.avatarPath!);
    } else {
      await prefs.remove(_chaveAvatar);
    }
  }

  Future<PerfilModel> _carregarPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return PerfilModel(
      nome: prefs.getString(_chaveNome) ?? 'Duelista',
      email: prefs.getString(_chaveEmail) ?? 'duelista@yugioh.com',
      avatarPath: prefs.getString(_chaveAvatar),
    );
  }
}