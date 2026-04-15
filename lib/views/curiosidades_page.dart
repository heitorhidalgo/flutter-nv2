import 'package:flutter/material.dart';
import '../controllers/curiosidades_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';

class CuriosidadesPage extends StatefulWidget {
  const CuriosidadesPage({super.key});

  //TODO: adicionar a imagem entre o titulo e a descricao. ex imagem do autor, imagem do manga vol 1, imagem do anime etc

  @override
  State<CuriosidadesPage> createState() => _CuriosidadesPageState();
}

class _CuriosidadesPageState extends State<CuriosidadesPage> {
  final CuriosidadesController _controller = CuriosidadesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _controller.listaCuriosidades.length,
        itemBuilder: (context, index) {
          final curiosidade = _controller.listaCuriosidades[index];

          return Card(
            color: AppTheme.textoSecundario,
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppTheme.textoPrimario, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(curiosidade.icone, color: AppTheme.fundoApp, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          curiosidade.titulo,
                          style: AppTheme.fonteTitulo(22).copyWith(color: AppTheme.fundoApp),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppTheme.fundoApp, thickness: 0.5),
                  const SizedBox(height: 12),
                  Text(
                    curiosidade.descricao,
                    style: AppTheme.fonteDescricao(20).copyWith(color: AppTheme.fundoApp),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}