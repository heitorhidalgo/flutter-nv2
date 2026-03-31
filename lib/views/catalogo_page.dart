import 'package:flutter/material.dart';
import 'package:flutter_nv2/views/detalhes_card_page.dart';
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
      appBar: AppBar(
        backgroundColor: AppTheme.fundoApp,
        title: const Text(
            'Yu-Gi-Oh! App'
        ),
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
      return const Center(
          child: CircularProgressIndicator()
      );
    }
    if (_controller.apiError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60),
            const SizedBox(height: 16),
            Text(
              _controller.apiError.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _controller.loadCards();
              },
              child: const Text(
                  'Tentar novamente'
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: _controller.cartas.length,
      itemBuilder: (context, index) {
        final carta = _controller.cartas[index];
        return ListTile(
          title: Text(
              carta.name
          ),
          subtitle: Text(
              carta.type
          ),
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
    );
  }
}