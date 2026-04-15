import 'package:flutter/material.dart';
import 'package:flutter_nv2/models/yugioh_card_model.dart';
import '../controllers/meu_deck_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';

class DetalhesCardPage extends StatelessWidget {
  final YugiohCardModel carta;

  const DetalhesCardPage({
    super.key,
    required this.carta
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: CabecalhoWidget(
        mostrarBotaoVoltar: true,
        mostrarBotaoAddDeck: true,
        cliqueBotaoAddDeck: () {
          final mensagemErro = MeuDeckController().adicionarCarta(carta);
          if (mensagemErro != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(mensagemErro),
                backgroundColor: AppTheme.corErro,
                duration: const Duration(seconds: 3),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${carta.name} adicionada ao deck!'),
                backgroundColor: AppTheme.corSucesso,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _imagemCarta(),
            const SizedBox(height: 32),
            _nomeCarta(),
            const SizedBox(height: 8),
            _tipoCarta(),
            const SizedBox(height: 24),
            _descricaoCarta(),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _imagemCarta() {
    return Hero(
      tag: 'carta-image-${carta.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          carta.imageUrl,
          height: 400,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(color: AppTheme.textoPrimario),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => const SizedBox(
            height: 400,
            child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _nomeCarta() {
    return Text(
      carta.name,
      style: AppTheme.fonteTitulo(35),
      textAlign: TextAlign.center,
    );
  }

  Widget _tipoCarta() {
    return Text(
      'TIPO: ${carta.type.toUpperCase()}',
      style: AppTheme.fonteSubtitulo(20).copyWith(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _descricaoCarta() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.textoSecundario,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textoPrimario, width: 2),
      ),
      child: Text(
        carta.description,
        style: AppTheme.fonteDescricao(20).copyWith(color: AppTheme.fundoApp),
        textAlign: TextAlign.justify,
      ),
    );
  }
}