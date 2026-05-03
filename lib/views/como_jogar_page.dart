import 'package:flutter/material.dart';
import '../controllers/como_jogar_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_regras_widget.dart';

class ComoJogarPage extends StatelessWidget {
  const ComoJogarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ComoJogarController();

    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.listaRegras.length,
        itemBuilder: (context, index) {
          final regra = controller.listaRegras[index];
          return CardRegrasWidget(regra: regra);
        },
      ),
    );
  }
}