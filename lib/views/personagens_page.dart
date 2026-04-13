import 'package:flutter/material.dart';
import '../controllers/personagens_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_personagem_widget.dart';

class PersonagensPage extends StatefulWidget {
  const PersonagensPage({super.key});

  @override
  State<PersonagensPage> createState() => _PersonagensPageState();
}

class _PersonagensPageState extends State<PersonagensPage> {
  final PersonagensController _controller = PersonagensController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _controller.listaPersonagens.length,
        itemBuilder: (context, index) {
          final personagem = _controller.listaPersonagens[index];
          return CardPersonagemWidget(personagem: personagem);
        },
      ),
    );
  }
}