import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/themes/app_theme.dart';
import '../models/regra_model.dart';
import '../providers/como_jogar_provider.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_regras_widget.dart';

class ComoJogarPage extends ConsumerWidget {
  const ComoJogarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<RegraModel> regras = ref.watch(comoJogarProvider);
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: regras.length,
        itemBuilder: (context, index) {
          final regra = regras[index];
          return CardRegrasWidget(regra: regra);
        },
      ),
    );
  }
}