import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_nv2/widgets/cabecalho_widget.dart';
import '../controllers/catalogo_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/lista_cartas_widget.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  final CatalogoController _controller = CatalogoController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _pesquisaController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _controller.buscarCartas();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _controller.buscarCartas(isLoadMore: true);
    }
  }

  void _limparPesquisa() {
    _pesquisaController.clear();
    _controller.pesquisarCarta('');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pesquisaController.dispose();
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(mostrarBotaoVoltar: true),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Column(
            children: [
              _barraDePesquisa(),
              Expanded(child: _conteudoPrincipal()),
            ],
          );
        },
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _conteudoPrincipal() {
    if (_controller.isLoading) return _estadoCarregando();
    if (_controller.errorMessage != null) return _estadoErro();
    if (_controller.cartas.isEmpty) return _estadoVazio();
    return _listaDeCartas();
  }

  Widget _barraDePesquisa() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _pesquisaController,
        style: AppTheme.fonteDescricao(18),
        decoration: InputDecoration(
          hintText: 'catalogo.pesquisar'.tr(),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textoSecundario),
          suffixIcon: ListenableBuilder(
            listenable: _pesquisaController,
            builder: (context, _) {
              return _pesquisaController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.close, color: AppTheme.textoSecundario),
                onPressed: _limparPesquisa,
              )
                  : const SizedBox.shrink();
            },
          ),
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
    );
  }

  Widget _estadoCarregando() {
    return const Center(
      child: CircularProgressIndicator(color: AppTheme.textoPrimario),
    );
  }

  Widget _estadoErro() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(
            _controller.errorMessage!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _controller.buscarCartas(),
            child: Text('geral.tentar_novamente'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _estadoVazio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.style_outlined,
            size: 72,
            color: AppTheme.textoPrimario.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'catalogo.nenhuma_carta'.tr(),
            style: AppTheme.fonteTitulo(20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: _limparPesquisa,
            icon: const Icon(Icons.close, color: AppTheme.textoSecundario),
            label: Text(
              'catalogo.limpar_pesquisa'.tr(),
              style: AppTheme.fonteSubtitulo(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listaDeCartas() {
    return ListaCartasWidget(
      cartas: _controller.cartas,
      scrollController: _scrollController,
      isFetchingMore: _controller.isFetchingMore,
    );
  }
}