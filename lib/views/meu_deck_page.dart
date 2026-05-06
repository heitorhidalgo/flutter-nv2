import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_nv2/widgets/cabecalho_widget.dart';
import '../controllers/meu_deck_controller.dart';
import '../core/themes/app_theme.dart';
import '../models/yugioh_card_model.dart';
import '../views/detalhes_card_page.dart';

class MeuDeckPage extends StatefulWidget {
  const MeuDeckPage({super.key});

  @override
  State<MeuDeckPage> createState() => _MeuDeckPageState();
}

class _MeuDeckPageState extends State<MeuDeckPage> {
  final MeuDeckController _controller = MeuDeckController();
  static const int _limiteMaximo = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(mostrarBotaoVoltar: true),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) => _conteudoPrincipal(),
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _conteudoPrincipal() {
    if (_controller.minhasCartas.isEmpty) return _estadoVazio();
    return Column(
      children: [
        _contadorCartas(),
        Expanded(child: _listaDeCartas()),
      ],
    );
  }

  Widget _contadorCartas() {
    final total = _controller.minhasCartas.length;
    final porcentagem = total / _limiteMaximo;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'deck.contador'.tr(namedArgs: {
                  'atual': total.toString(),
                  'maximo': _limiteMaximo.toString(),
                }),
                style: AppTheme.fonteSubtitulo(14),
              ),
              Text(
                '${(porcentagem * 100).toStringAsFixed(0)}%',
                style: AppTheme.fonteSubtitulo(14),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: porcentagem,
              minHeight: 8,
              backgroundColor: AppTheme.textoSecundario.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                porcentagem < 0.8
                    ? Colors.green
                    : porcentagem < 0.95
                    ? Colors.orange
                    : AppTheme.corErro,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _estadoVazio() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          'deck.deck_vazio'.tr(),
          style: AppTheme.fonteTitulo(20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _listaDeCartas() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _controller.minhasCartas.length,
      itemBuilder: (context, index) {
        final carta = _controller.minhasCartas[index];
        return _cardLista(carta);
      },
    );
  }

  Widget _cardLista(YugiohCardModel carta) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            carta.imageUrl,
            width: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: AppTheme.fundoApp),
          ),
        ),
        title: Text(
          carta.name,
          style: AppTheme.fonteSubtitulo(18).copyWith(color: AppTheme.fundoApp),
        ),
        subtitle: Text(
          carta.type,
          style: AppTheme.fonteDescricao(14).copyWith(color: AppTheme.fundoApp),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.fundoApp),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalhesCardPage(
                carta: carta,
                modoRemover: true,
              ),
            ),
          );
        },
      ),
    );
  }
}