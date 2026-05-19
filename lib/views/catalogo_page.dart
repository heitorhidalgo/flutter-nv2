import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/themes/app_theme.dart';
import '../models/catalogo_state.dart';
import '../providers/catalogo_provider.dart';
import '../widgets/cabecalho_widget.dart';
import '../widgets/lista_cartas_widget.dart';

class CatalogoPage extends ConsumerStatefulWidget {
  const CatalogoPage({super.key});

  @override
  ConsumerState<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends ConsumerState<CatalogoPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _pesquisaController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(catalogoProvider.notifier).buscarMaisCartas();
    }
  }

  void _limparPesquisa() {
    _pesquisaController.clear();
    ref.read(catalogoProvider.notifier).pesquisarCarta('');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pesquisaController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<CatalogoState> catalogo =
    ref.watch(catalogoProvider);
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: Column(
        children: <Widget>[
          _barraDePesquisa(),
          Expanded(
            child: catalogo.when(
              loading: _estadoCarregando,
              error: (error, stack) => _estadoErro(error),
              data: (CatalogoState estado) => _conteudoPrincipal(estado),
            ),
          ),
        ],
      ),
    );
  }

  Widget _conteudoPrincipal(CatalogoState estado) {
    if (estado.cartas.isEmpty) {
      return _estadoVazio();
    }
    return _listaDeCartas(estado);
  }

  Widget _barraDePesquisa() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _pesquisaController,
        style: AppTheme.fonteDescricao(18),
        decoration: InputDecoration(
          hintText: 'catalogo.pesquisar'.tr(),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.textoSecundario,
          ),
          suffixIcon: ListenableBuilder(
            listenable: _pesquisaController,
            builder: (context, _) {
              return _pesquisaController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppTheme.textoSecundario,
                ),
                onPressed: _limparPesquisa,
              ) : const SizedBox.shrink();
            },
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppTheme.textoPrimario,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppTheme.textoPrimario,
              width: 2,
            ),
          ),
        ),
        onChanged: (String texto) {
          if (_debounce?.isActive ?? false) {
            _debounce!.cancel();
          }
          _debounce = Timer(
            const Duration(milliseconds: 500),
                () {
              ref.read(catalogoProvider.notifier).pesquisarCarta(texto);
            },
          );
        },
      ),
    );
  }

  Widget _estadoCarregando() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppTheme.textoPrimario,
      ),
    );
  }

  Widget _estadoErro(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(catalogoProvider);
            },
            child: Text(
              'geral.tentar_novamente'.tr(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _estadoVazio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.style_outlined,
            size: 72,
            color: AppTheme.textoPrimario.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'catalogo.nenhuma_carta'.tr(),
            style: AppTheme.fonteTitulo(20),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: _limparPesquisa,
            icon: const Icon(Icons.close),
            label: Text(
              'catalogo.limpar_pesquisa'.tr(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listaDeCartas(CatalogoState estado) {
    return ListaCartasWidget(
      cartas: estado.cartas,
      scrollController: _scrollController,
      isFetchingMore: estado.isFetchingMore,
    );
  }
}