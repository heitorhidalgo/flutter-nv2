import 'package:flutter/material.dart';
import '../models/yugioh_card_model.dart';
import '../core/themes/app_theme.dart';
import '../views/detalhes_card_page.dart';

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
      itemBuilder: (context, index) {

        if (index == cartas.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(child: CircularProgressIndicator(color: AppTheme.textoPrimario)),
          );
        }
        final carta = cartas[index];
        return _cardLista(context, carta);
      },
    );
  }

  // --- WIDGET FRAGMENTADO ---

  Widget _cardLista(BuildContext context, YugiohCardModel carta) {
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
          tag: 'carta-image-${carta.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              carta.imageUrl,
              width: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalhesCardPage(carta: carta),
            ),
          );
        },
      ),
    );
  }
}