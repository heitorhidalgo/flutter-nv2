import 'package:flutter/material.dart';
import '../controllers/curiosidades_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_curiosidades_widget.dart';

class CuriosidadesPage extends StatelessWidget {
  const CuriosidadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CuriosidadesController();

    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.listaCuriosidades.length,
        itemBuilder: (context, index) {
          final curiosidade = controller.listaCuriosidades[index];
          return CardCuriosidadesWidget(curiosidade: curiosidade);
        },
      ),
    );
  }
}