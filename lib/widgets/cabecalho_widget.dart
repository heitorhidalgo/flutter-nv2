import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/perfil_controller.dart';
import '../core/themes/app_theme.dart';

class CabecalhoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool mostrarBotaoVoltar;
  final bool mostrarDrawer;
  final bool mostrarBotaoAddDeck;
  final VoidCallback? cliqueBotaoAddDeck;
  final String? labelBotaoAddDeck;
  final IconData? iconeBotaoAddDeck;

  const CabecalhoWidget({
    super.key,
    this.mostrarBotaoVoltar = false,
    this.mostrarDrawer = false,
    this.mostrarBotaoAddDeck = false,
    this.cliqueBotaoAddDeck,
    this.labelBotaoAddDeck,
    this.iconeBotaoAddDeck,
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
    if (mostrarBotaoVoltar) {
      return IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textoPrimario),
        onPressed: () => Navigator.pop(context),
      );
    } else if (mostrarDrawer) {
      final controller = PerfilController();
      return ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          final avatarPath = controller.perfil.avatarPath;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.textoSecundario,
                backgroundImage:
                avatarPath != null ? AssetImage(avatarPath) : null,
                child: avatarPath == null
                    ? const Icon(Icons.person,
                    size: 20, color: AppTheme.fundoApp)
                    : null,
              ),
            ),
          );
        },
      );
    }
    return null;
  }

  List<Widget>? _construirActions(BuildContext context) {
    if (mostrarBotaoAddDeck) {
      final label =
          labelBotaoAddDeck ?? 'detalhes.adicionar_ao_deck'.tr();
      final icone = iconeBotaoAddDeck ?? Icons.add_circle;

      return [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: AppTheme.textoPrimario),
          color: AppTheme.textoSecundario,
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (valor) {
            if (valor == 'acao' && cliqueBotaoAddDeck != null) {
              cliqueBotaoAddDeck!();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'acao',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(icone, color: AppTheme.fundoApp, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
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