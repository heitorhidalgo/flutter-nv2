import 'package:flutter_nv2/controllers/meu_deck_controller.dart';
import 'package:flutter_nv2/controllers/perfil_controller.dart';

class SplashController {
  Future<bool> carregarDependencias() async {
    try {
      await Future.wait([
        PerfilController().inicializar(),
        MeuDeckController().inicializar(),
      ]);
      return true;
    } catch (e) {
      return false;
    }
  }
}