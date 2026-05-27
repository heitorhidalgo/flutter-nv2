import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/yugioh_card_model.dart';
import '../core/themes/app_theme.dart';
import '../routes/app_routes.dart';
import '../routes/arguments/detalhes_card_args.dart';

class ListaCartasWidget extends StatelessWidget {
  final List<YugiohCardModel> cartas;
  final ScrollController? scrollController;
  final bool isFetchingMore;

  const ListaCartasWidget({
    super.key,
    required this.cartas,
    this.scrollController,
    this.isFetchingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: cartas.length + (isFetchingMore ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == cartas.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: CircularProgressIndicator(color: AppTheme.textoPrimario),
            ),
          );
        }
        return _cardLista(context, cartas[index], index);
      },
    );
  }

  Widget _cardLista(BuildContext context, YugiohCardModel carta, int index) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Hero(
          tag: 'carta-image-${carta.id}-$index',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: carta.imageUrl,
              width: 40,
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String url) => const SizedBox(
                width: 40,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.fundoApp,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (BuildContext context, String url, Object error) =>
                  const Icon(Icons.broken_image, color: AppTheme.fundoApp),
            ),
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
          Navigator.pushNamed(
            context,
            AppRoutes.detalhesCard,
            arguments: DetalhesCardArguments(
              carta: carta,
              modoRemover: false,
              heroTag: 'carta-image-${carta.id}-$index',
            ),
          );
        },
      ),
    );
  }
}
