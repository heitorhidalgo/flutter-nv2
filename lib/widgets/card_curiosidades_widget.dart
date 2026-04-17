import 'package:flutter/material.dart';
import '../core/themes/app_theme.dart';
import '../models/curiosidades_model.dart';

class CardCuriosidadesWidget extends StatelessWidget {
  final CuriosidadesModel curiosidade;

  const CardCuriosidadesWidget({
    super.key,
    required this.curiosidade,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tituloEIcone(),
            const SizedBox(height: 12),
            const Divider(color: AppTheme.fundoApp, thickness: 0.5),
            const SizedBox(height: 16),
            _imagemCuriosidade(),
            const SizedBox(height: 16),
            _descricaoCuriosidade(),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _tituloEIcone() {
    return Row(
      children: [
        Icon(curiosidade.icone, color: AppTheme.fundoApp, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            curiosidade.titulo,
            style: AppTheme.fonteTitulo(22).copyWith(color: AppTheme.fundoApp),
          ),
        ),
      ],
    );
  }

  Widget _imagemCuriosidade() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        curiosidade.imagem,
        width: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 200,
          color: AppTheme.fundoApp.withValues(alpha: 0.1),
          child: const Center(
            child: Icon(Icons.broken_image, color: AppTheme.fundoApp, size: 50),
          ),
        ),
      ),
    );
  }

  Widget _descricaoCuriosidade() {
    return Text(
      curiosidade.descricao,
      style: AppTheme.fonteDescricao(18).copyWith(color: AppTheme.fundoApp),
      textAlign: TextAlign.justify,
    );
  }
}