import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/themes/app_theme.dart';
import '../routes/app_routes.dart';
import '../widgets/botao_home_widget.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarDrawer: true,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  BotaoHomeWidget(
                    titulo: 'home.catalogo'.tr(),
                    icone: Icons.style,
                    clique: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.catalogo,
                      );
                    },
                  ),
                  BotaoHomeWidget(
                    titulo: 'home.meu_deck'.tr(),
                    icone: Icons.style_outlined,
                    clique: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.meuDeck,
                      );
                    },
                  ),
                  BotaoHomeWidget(
                    titulo: 'home.personagens'.tr(),
                    icone: Icons.person,
                    clique: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.personagens,
                      );
                    },
                  ),
                  BotaoHomeWidget(
                    titulo: 'home.curiosidades'.tr(),
                    icone: Icons.question_mark,
                    clique: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.curiosidades,
                      );
                    },
                  ),
                  BotaoHomeWidget(
                    titulo: 'home.como_jogar'.tr(),
                    icone: Icons.play_arrow,
                    clique: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.comoJogar,
                      );
                    },
                  ),
                  BotaoHomeWidget(
                    titulo: 'home.configuracoes'.tr(),
                    icone: Icons.settings,
                    clique: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.configuracoes,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}