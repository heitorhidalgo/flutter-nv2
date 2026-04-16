import 'package:flutter/material.dart';
import 'package:flutter_nv2/widgets/cabecalho_widget.dart';
import '../controllers/meu_deck_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/lista_cartas_widget.dart';

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
          return _conteudoPrincipal();
        },
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _conteudoPrincipal() {
    if (_controller.minhasCartas.isEmpty) {
      return _estadoVazio();
    }
    return _listaDeCartas();
  }

  Widget _estadoVazio() {
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

  Widget _listaDeCartas() {
    return ListaCartasWidget(
      cartas: _controller.minhasCartas,
    );
  }
}