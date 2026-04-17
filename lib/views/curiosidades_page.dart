import 'package:flutter/material.dart';
import '../controllers/curiosidades_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_curiosidades_widget.dart';

class CuriosidadesPage extends StatefulWidget {
  const CuriosidadesPage({super.key});

  @override
  State<CuriosidadesPage> createState() => _CuriosidadesPageState();
}

class _CuriosidadesPageState extends State<CuriosidadesPage> {
  final CuriosidadesController _controller = CuriosidadesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _controller.listaCuriosidades.length,
        itemBuilder: (context, index) {
          final curiosidade = _controller.listaCuriosidades[index];
          return CardCuriosidadesWidget(
            curiosidade: curiosidade,
          );
        },
      ),
    );
  }
}