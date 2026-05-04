import 'package:flutter/material.dart';
import '../controllers/personagens_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_personagem_widget.dart';

class PersonagensPage extends StatelessWidget {
  const PersonagensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PersonagensController();

    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.listaPersonagens.length,
        itemBuilder: (context, index) {
          final personagem = controller.listaPersonagens[index];
          return CardPersonagemWidget(personagem: personagem);
        },
      ),
    );
  }
}