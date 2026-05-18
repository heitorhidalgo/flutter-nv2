import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/themes/app_theme.dart';
import '../models/personagem_model.dart';
import '../providers/personagens_provider.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_personagem_widget.dart';

class PersonagensPage extends ConsumerWidget {
  const PersonagensPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PersonagemModel> personagens = ref.watch(personagensProvider);
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: personagens.length,
        itemBuilder: (context, index) {
          final personagem = personagens[index];
          return CardPersonagemWidget(personagem: personagem);
        },
      ),
    );
  }
}