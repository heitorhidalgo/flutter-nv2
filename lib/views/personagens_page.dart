import 'package:flutter/material.dart';
import '../controllers/personagens_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';

class PersonagensPage extends StatefulWidget {
  const PersonagensPage({super.key});

  @override
  State<PersonagensPage> createState() => _PersonagensPageState();
}

class _PersonagensPageState extends State<PersonagensPage> {
  final PersonagensController _controller = PersonagensController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _controller.listaPersonagens.length,
        itemBuilder: (context, index) {
          final personagem = _controller.listaPersonagens[index];
          return Card(
            color: AppTheme.fundoApp,
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 24),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppTheme.textoSecundario, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: AppTheme.textoPrimario.withValues(alpha: 0.1),
                  child: Image.asset(
                    personagem.imagem,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(
                      height: 250,
                      child: Icon(Icons.person, size: 80, color: AppTheme.textoSecundario),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        personagem.nome,
                        style: AppTheme.fonteTitulo(26),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        personagem.descricao,
                        style: AppTheme.fonteDescricao(18),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}