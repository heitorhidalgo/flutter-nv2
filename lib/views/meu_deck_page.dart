import 'package:flutter/material.dart';
import 'package:flutter_nv2/views/detalhes_card_page.dart';
import 'package:flutter_nv2/widgets/cabecalho_widget.dart';
import '../controllers/meu_deck_controller.dart';
import '../core/themes/app_theme.dart';

class MeuDeckPage extends StatefulWidget {
  const MeuDeckPage({super.key});

  @override
  State<MeuDeckPage> createState() => _MeuDeckPageState();
}

class _MeuDeckPageState extends State<MeuDeckPage> {
  final MeuDeckController _controller = MeuDeckController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.minhasCartas.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Nenhuma carta adicionada!\n\nVá até o Catálogo e adicione cartas ao seu deck.',
                  style: AppTheme.fonteTitulo(20),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _controller.minhasCartas.length,
            itemBuilder: (context, index) {
              final carta = _controller.minhasCartas[index];
              return Card(
                color: AppTheme.textoSecundario,
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppTheme.textoPrimario, width: 2),
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
                      style: AppTheme.fonteSubtitulo(18).copyWith(color: AppTheme.fundoApp)
                  ),
                  subtitle: Text(
                      carta.type,
                      style: AppTheme.fonteDescricao(14).copyWith(color: AppTheme.fundoApp)
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
            },
          );
        },
      ),
    );
  }
}