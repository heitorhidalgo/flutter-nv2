import 'package:flutter/material.dart';
import 'package:flutter_nv2/views/catalogo_page.dart';
import 'package:flutter_nv2/views/personagens_page.dart';
import 'package:flutter_nv2/widgets/botao_home_widget.dart';
import 'package:flutter_nv2/widgets/cabecalho_widget.dart';
import '../core/themes/app_theme.dart';
import 'meu_deck_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
       mostrarDrawer: true,
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  children: [
                    BotaoHomeWidget(
                        titulo: 'Catálogo',
                        icone: Icons.style,
                        clique: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CatalogoPage())
                          );
                        },
                    ),
                    BotaoHomeWidget(
                      titulo: 'Meu deck',
                      icone: Icons.style_outlined,
                      clique: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MeuDeckPage())
                        );
                      },
                    ),
                    BotaoHomeWidget(
                      titulo: 'Personagens',
                      icone: Icons.person,
                      clique: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PersonagensPage())
                        );
                      },
                    ),
                    BotaoHomeWidget(
                      titulo: 'Curiosidades',
                      icone: Icons.question_mark,
                      clique: (){
                        print('indo para pag de curiosidades');
                      },
                    ),
                    BotaoHomeWidget(
                      titulo: 'Como Jogar?',
                      icone: Icons.play_arrow,
                      clique: (){
                        print('indo para pag de como jogar');
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