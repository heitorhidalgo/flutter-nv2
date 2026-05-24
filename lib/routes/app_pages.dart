import 'package:flutter/material.dart';
import '../routes/arguments/detalhes_card_args.dart';
import '../views/catalogo_page.dart';
import '../views/detalhes_card_page.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    AppRoutes.splash: (BuildContext context) => const SplashPage(),
    AppRoutes.login: (BuildContext context) => const LoginPage(),
    AppRoutes.home: (BuildContext context) => const HomePage(),
    AppRoutes.catalogo: (BuildContext context) => const CatalogoPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.detalhesCard:
        final DetalhesCardArguments args = settings.arguments as DetalhesCardArguments;

        return MaterialPageRoute(
          builder: (BuildContext context) {
            return DetalhesCardPage(
              carta: args.carta,
              modoRemover: args.modoRemover,
            );
          },
        );

      default:
        return null;
    }
  }
}
