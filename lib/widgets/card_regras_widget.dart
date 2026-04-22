import 'package:flutter/material.dart';
import '../core/themes/app_theme.dart';
import '../models/regra_model.dart';

class CardRegrasWidget extends StatelessWidget {
  final RegraModel regra;

  const CardRegrasWidget({
    super.key,
    required this.regra,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        iconColor: AppTheme.fundoApp,
        collapsedIconColor: AppTheme.fundoApp,
        leading: _iconeRegra(),
        title: _tituloRegra(),
        children: [
          const Divider(color: AppTheme.fundoApp, thickness: 0.5, height: 1),
          _descricaoRegra(),
        ],
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _iconeRegra() {
    return Icon(
      regra.icone,
      color: AppTheme.fundoApp,
      size: 28,
    );
  }

  Widget _tituloRegra() {
    return Text(
      regra.titulo,
      style: AppTheme.fonteTitulo(20).copyWith(color: AppTheme.fundoApp),
    );
  }

  Widget _descricaoRegra() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        regra.descricao,
        style: AppTheme.fonteDescricao(22).copyWith(color: AppTheme.fundoApp),
        textAlign: TextAlign.justify,
      ),
    );
  }
}