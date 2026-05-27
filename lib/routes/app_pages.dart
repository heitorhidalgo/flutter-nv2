import 'package:flutter/material.dart';
import '../routes/arguments/detalhes_card_args.dart';
import '../views/catalogo_page.dart';
import '../views/como_jogar_page.dart';
import '../views/configuracoes_page.dart';
import '../views/curiosidades_page.dart';
import '../views/detalhes_card_page.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/meu_deck_page.dart';
import '../views/perfil_page.dart';
import '../views/personagens_page.dart';
import '../views/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    AppRoutes.splash: (BuildContext context) => const SplashPage(),
    AppRoutes.login: (BuildContext context) => const LoginPage(),
    AppRoutes.home: (BuildContext context) => const HomePage(),
    AppRoutes.catalogo: (BuildContext context) => const CatalogoPage(),
    AppRoutes.meuDeck: (BuildContext context) => const MeuDeckPage(),
    AppRoutes.perfil: (BuildContext context) => const PerfilPage(),
    AppRoutes.configuracoes: (BuildContext context) => const ConfiguracoesPage(),
    AppRoutes.personagens: (BuildContext context) => const PersonagensPage(),
    AppRoutes.curiosidades: (BuildContext context) => const CuriosidadesPage(),
    AppRoutes.comoJogar: (BuildContext context) => const ComoJogarPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.detalhesCard:
        final DetalhesCardArguments args =
            settings.arguments as DetalhesCardArguments;
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return DetalhesCardPage(
              carta: args.carta,
              modoRemover: args.modoRemover,
              heroTag: args.heroTag,
            );
          },
        );
      default:
        return null;
    }
  }
}