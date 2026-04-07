import 'package:flutter/material.dart';
import 'package:flutter_nv2/views/detalhes_card_page.dart';
import 'package:flutter_nv2/widgets/cabecalho_widget.dart';
import '../controllers/yugioh_card_controller.dart';
import '../core/themes/app_theme.dart';
import '../repositories/yugioh_card_repository.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  late final YugiohCardController _controller;

  @override
  void initState() {
    super.initState();

    final repository = YugiohCardRepository();
    _controller = YugiohCardController(repository);

    _controller.loadCards();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_controller.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppTheme.textoPrimario));
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            style: AppTheme.fonteDescricao(18),
            decoration: InputDecoration(
              hintText: 'Pesquisar...',
              prefixIcon: const Icon(Icons.search, color: AppTheme.textoSecundario),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.textoPrimario),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.textoPrimario, width: 2),
              ),
            ),
            onChanged: (textoDigitado) {
              // TODO: Conectar com o Controller depois!
              print('Usuário digitou: $textoDigitado');
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _controller.cartas.length,
            itemBuilder: (context, index) {
              final carta = _controller.cartas[index];
              return ListTile(
                title: Text(carta.name, style: AppTheme.fonteSubtitulo(18)),
                subtitle: Text(carta.type),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesCardPage(carta: carta),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}