import 'package:flutter/material.dart';
import '../views/catalogo_page.dart';
import '../views/detalhes_card_page.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    AppRoutes.splash: (_) => const SplashPage(),
    AppRoutes.login: (_) => const LoginPage(),
    AppRoutes.home: (_) => const HomePage(),
    AppRoutes.catalogo: (_) => const CatalogoPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.detalhesCard:
        final Map<String, dynamic> args =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DetalhesCardPage(
            carta: args['carta'],
            modoRemover: args['modoRemover'],
          ),
        );
      default: return null;
    }
  }
}