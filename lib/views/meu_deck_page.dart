import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/meu_deck_controller.dart';
import '../core/themes/app_theme.dart';
import '../models/yugioh_card_model.dart';
import '../providers/meu_deck_provider.dart';
import '../routes/app_routes.dart';
import '../routes/arguments/detalhes_card_args.dart';
import '../widgets/cabecalho_widget.dart';

class MeuDeckPage extends ConsumerWidget {
  const MeuDeckPage({super.key});

  static const int _limiteMaximo = 60;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MeuDeckController controller = ref.watch(meuDeckProvider);

    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(mostrarBotaoVoltar: true),
      body: _conteudoPrincipal(controller),
    );
  }

  Widget _conteudoPrincipal(MeuDeckController controller) {
    if (controller.minhasCartas.isEmpty) {
      return _estadoVazio();
    }

    return Column(
      children: <Widget>[
        _contadorCartas(controller),
        Expanded(
          child: _listaDeCartas(controller),
        ),
      ],
    );
  }

  Widget _contadorCartas(MeuDeckController controller) {
    final int total = controller.minhasCartas.length;
    final double porcentagem = total / _limiteMaximo;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'deck.contador'.tr(
                  namedArgs: <String, String>{
                    'atual': total.toString(),
                    'maximo': _limiteMaximo.toString(),
                  },
                ),
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
                porcentagem < 0.8 ? Colors.green : porcentagem < 0.95 ? Colors.orange : AppTheme.corErro,
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
        padding: const EdgeInsets.all(24),
        child: Text(
          'deck.deck_vazio'.tr(),
          style: AppTheme.fonteTitulo(20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _listaDeCartas(MeuDeckController controller) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      itemCount: controller.minhasCartas.length,
      itemBuilder: (BuildContext context, int index) {
        final YugiohCardModel carta = controller.minhasCartas[index];

        return _cardLista(context, carta);
      },
    );
  }

  Widget _cardLista(BuildContext context, YugiohCardModel carta) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppTheme.textoPrimario,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: carta.imageUrl,
            width: 40,
            fit: BoxFit.cover,
            errorWidget: (BuildContext context, String url, Object error) =>
            const Icon(
              Icons.broken_image,
              color: AppTheme.fundoApp,
            ),
          ),
        ),
        title: Text(
          carta.name,
          style: AppTheme.fonteSubtitulo(18).copyWith(
            color: AppTheme.fundoApp,
          ),
        ),
        subtitle: Text(
          carta.type,
          style: AppTheme.fonteDescricao(14).copyWith(
            color: AppTheme.fundoApp,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppTheme.fundoApp,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detalhesCard,
            arguments: DetalhesCardArguments(
              carta: carta,
              modoRemover: true,
            ),
          );
        },
      ),
    );
  }
}