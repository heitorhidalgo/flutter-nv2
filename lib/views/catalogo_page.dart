import 'dart:async';
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

  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    final repository = YugiohCardRepository();
    _controller = YugiohCardController(repository);
    _scrollController.addListener(_onScroll);
    _controller.buscarCartas();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _controller.buscarCartas(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel();
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
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                _controller.pesquisarCarta(textoDigitado);
              });
            },
          ),
        ),
        Expanded(
          child: _controller.isLoading
              ? const Center(child: CircularProgressIndicator(color: AppTheme.textoPrimario))
              : _controller.errorMessage != null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 16),
                Text(_controller.errorMessage!, style: const TextStyle(color: Colors.red)),
                ElevatedButton(
                  onPressed: () => _controller.buscarCartas(),
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          )
              : _controller.cartas.isEmpty
              ? Center(
            child: Text(
              'Nenhuma carta encontrada.',
              style: AppTheme.fonteTitulo(20),
            ),
          )
              : ListView.builder(
            controller: _scrollController,
            itemCount: _controller.cartas.length + (_controller.isFetchingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _controller.cartas.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(child: CircularProgressIndicator(color: AppTheme.textoPrimario)),
                );
              }
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