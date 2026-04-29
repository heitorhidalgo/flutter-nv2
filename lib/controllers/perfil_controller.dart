import 'package:flutter/material.dart';
import '../models/perfil_model.dart';

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

  void atualizarNome(String novoNome) {
    perfil = perfil.copyWith(nome: novoNome.trim());
    notifyListeners();
  }

  void atualizarAvatar(String caminho) {
    perfil = perfil.copyWith(avatarPath: caminho);
    notifyListeners();
  }

  void fazerLogout(BuildContext context) {
    // Futuramente: limpar token, SharedPreferences, etc.
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
}