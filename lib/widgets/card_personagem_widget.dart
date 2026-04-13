import 'package:flutter/material.dart';
import '../core/themes/app_theme.dart';
import '../models/personagem_model.dart';

class CardPersonagemWidget extends StatelessWidget {
  final PersonagemModel personagem;

  const CardPersonagemWidget({
    super.key,
    required this.personagem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.fundoApp,
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 24),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoSecundario, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _imagemPersonagem(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nomePersonagem(),
                const SizedBox(height: 12),
                _descricaoPersonagem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _imagemPersonagem() {
    return Container(
      color: AppTheme.textoPrimario.withValues(alpha: 0.1),
      child: Image.asset(
        personagem.imagem,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) => const SizedBox(
          height: 250,
          child: Icon(Icons.person, size: 80, color: AppTheme.textoSecundario),
        ),
      ),
    );
  }

  Widget _nomePersonagem() {
    return Text(
      personagem.nome,
      style: AppTheme.fonteTitulo(26),
    );
  }

  Widget _descricaoPersonagem() {
    return Text(
      personagem.descricao,
      style: AppTheme.fonteDescricao(18),
      textAlign: TextAlign.justify,
    );
  }
}