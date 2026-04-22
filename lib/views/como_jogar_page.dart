import 'package:flutter/material.dart';
import '../controllers/como_jogar_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_regras_widget.dart';

class ComoJogarPage extends StatefulWidget {
  const ComoJogarPage({super.key});

  @override
  State<ComoJogarPage> createState() => _ComoJogarPageState();
}

class _ComoJogarPageState extends State<ComoJogarPage> {
  final ComoJogarController _controller = ComoJogarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _controller.listaRegras.length,
        itemBuilder: (context, index) {
          final regra = _controller.listaRegras[index];
          return CardRegrasWidget(
            regra: regra,
          );
        },
      ),
    );
  }
}