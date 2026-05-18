import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/themes/app_theme.dart';
import '../models/curiosidades_model.dart';
import '../providers/curiosidades_provider.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/card_curiosidades_widget.dart';
class CuriosidadesPage extends ConsumerWidget {
  const CuriosidadesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CuriosidadesModel> curiosidades = ref.watch(curiosidadesProvider);
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: curiosidades.length,
        itemBuilder: (context, index) {
          final curiosidade = curiosidades[index];
          return CardCuriosidadesWidget(curiosidade: curiosidade);
        },
      ),
    );
  }
}