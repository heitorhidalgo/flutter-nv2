import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/yugioh_card_model.dart';
import '../providers/meu_deck_provider.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';

class DetalhesCardPage extends ConsumerWidget {
  final YugiohCardModel carta;
  final bool modoRemover;
  final String? heroTag;

  const DetalhesCardPage({
    super.key,
    required this.carta,
    this.modoRemover = false,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: CabecalhoWidget(
        mostrarBotaoVoltar: true,
        mostrarBotaoAddDeck: true,
        cliqueBotaoAddDeck: () => modoRemover
            ? _removerDoDeck(context, ref)
            : _adicionarAoDeck(context, ref),
        labelBotaoAddDeck: modoRemover
            ? 'deck.remover_do_deck'.tr()
            : 'detalhes.adicionar_ao_deck'.tr(),
        iconeBotaoAddDeck: modoRemover
            ? Icons.delete_outline
            : Icons.add_circle,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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

  Future<void> _adicionarAoDeck(
      BuildContext context,
      WidgetRef ref,
      ) async {
    final String? mensagemErro = await ref
        .read(meuDeckProvider)
        .adicionarCarta(carta);

    if (!context.mounted) return;

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
          content: Text(
            'deck.carta_adicionada'.tr(
              namedArgs: <String, String>{
                'nome': carta.name,
              },
            ),
          ),
          backgroundColor: AppTheme.corSucesso,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _removerDoDeck(
      BuildContext context,
      WidgetRef ref,
      ) async {
    await ref.read(meuDeckProvider).removerCarta(carta);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'deck.removida'.tr(
            namedArgs: <String, String>{
              'nome': carta.name,
            },
          ),
        ),
        backgroundColor: AppTheme.textoSecundario,
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  Widget _imagemCarta() {
    final String tag = heroTag ?? 'carta-image-${carta.id}';

    return Hero(
      tag: tag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: carta.imageUrl,
          height: 400,
          fit: BoxFit.contain,
          placeholder: (context, url) => const SizedBox(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(
                color: AppTheme.textoPrimario,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const SizedBox(
            height: 400,
            child: Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _nomeCarta() {
    return Text(
      carta.name,
      textAlign: TextAlign.center,
      style: AppTheme.fonteTitulo(28),
    );
  }

  Widget _tipoCarta() {
    return Text(
      carta.type,
      textAlign: TextAlign.center,
      style: AppTheme.fonteSubtitulo(18),
    );
  }

  Widget _descricaoCarta() {
    return Text(
      carta.description,
      style: AppTheme.fonteDescricao(16),
      textAlign: TextAlign.justify,
    );
  }
}