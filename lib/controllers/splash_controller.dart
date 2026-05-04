import 'package:flutter_nv2/controllers/login_controller.dart';
import 'package:flutter_nv2/controllers/meu_deck_controller.dart';
import 'package:flutter_nv2/controllers/perfil_controller.dart';

class SplashController {
  Future<bool?> carregarDependencias() async {
    try {
      final resultados = await Future.wait([
        PerfilController().inicializar(),
        MeuDeckController().inicializar(),
        LoginController.estaLogado(),
      ]);

      final sessaoAtiva = resultados[2] as bool;
      return sessaoAtiva;
    } catch (e) {
      return null;
    }
  }
}