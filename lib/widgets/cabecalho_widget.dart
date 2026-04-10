import 'package:flutter/material.dart';
import '../core/themes/app_theme.dart';

class CabecalhoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool mostrarBotaoVoltar;
  final bool mostrarDrawer;
  final bool mostrarBotaoAddDeck;
  final VoidCallback? cliqueBotaoAddDeck;


  const CabecalhoWidget({
    super.key,
    this.mostrarBotaoVoltar = false,
    this.mostrarDrawer = false,
    this.mostrarBotaoAddDeck = false,
    this.cliqueBotaoAddDeck,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.fundoApp,
      centerTitle: true,
      elevation: 0,
      leading: _construirLeading(context),
      actions: _construirActions(context),
      title: Image.asset(
        'assets/icons/logotipo.png',
        height: 70,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget? _construirLeading(BuildContext context) {
    if(mostrarBotaoVoltar) {
      return IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textoPrimario),
        onPressed: () => Navigator.pop(context),
      );
    } else if (mostrarDrawer) {
      return IconButton(
        icon: const Icon(Icons.menu, color: AppTheme.textoPrimario),
        onPressed: () => Scaffold.of(context).openDrawer(),
      );
    }
    return null;
  }

  List<Widget>? _construirActions(BuildContext context) {
    if (mostrarBotaoAddDeck) {
      return [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: AppTheme.textoPrimario),
          color: AppTheme.textoSecundario,
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (valor) {
            if (valor == 'adicionar' && cliqueBotaoAddDeck != null) {
              cliqueBotaoAddDeck!();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'adicionar',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.add_circle, color: AppTheme.fundoApp, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Adicionar ao Meu Deck',
                      style: AppTheme.fonteSubtitulo(16).copyWith(
                        color: AppTheme.fundoApp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ];
    }
    return null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
