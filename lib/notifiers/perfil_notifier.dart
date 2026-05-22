import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/perfil_model.dart';

class PerfilNotifier extends Notifier<PerfilModel> {
  static const String _chaveNome = 'perfil_nome';
  static const String _chaveEmail = 'perfil_email';
  static const String _chaveAvatar = 'perfil_avatar';

  final List<String> avataresDisponiveis =
  <String>[
    'assets/personagens/yugi.jpg',
    'assets/personagens/kaiba.jpg',
    'assets/personagens/joey.jpg',
    'assets/personagens/mai.jpg',
  ];

  @override
  PerfilModel build() {
    _carregarPerfil();
    return const PerfilModel(
      nome: 'Duelista',
      email: 'duelista@yugioh.com',
      avatarPath: null,
    );
  }

  Future<void> atualizarNome(String novoNome) async {
    state = state.copyWith(nome: novoNome.trim());
    await _salvarPerfil();
  }

  Future<void> atualizarEmail(String novoEmail) async {
    state = state.copyWith(email: novoEmail.trim());
    await _salvarPerfil();
  }

  Future<void> atualizarAvatar(String caminho) async {
    state = state.copyWith(avatarPath: caminho);
    await _salvarPerfil();
  }

  Future<void> limparPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveNome);
    await prefs.remove(_chaveEmail);
    await prefs.remove(_chaveAvatar);

    state = const PerfilModel(
      nome: 'Duelista',
      email: 'duelista@yugioh.com',
      avatarPath: null,
    );
  }

  Future<void> _salvarPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveNome, state.nome);
    await prefs.setString(_chaveEmail, state.email);
    if (state.avatarPath != null) {
      await prefs.setString(_chaveAvatar, state.avatarPath!);
    }
  }

  Future<void> _carregarPerfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = PerfilModel(nome: prefs.getString(_chaveNome) ?? 'Duelista',
      email: prefs.getString(_chaveEmail) ?? 'duelista@yugioh.com',
      avatarPath: prefs.getString(_chaveAvatar));
  }
}