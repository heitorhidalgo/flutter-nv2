import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/themes/app_theme.dart';
import '../models/perfil_model.dart';
import '../providers/perfil_provider.dart';

class CabecalhoWidget extends ConsumerWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PerfilModel> perfilAsync = ref.watch(perfilProvider);
    final PerfilModel? perfil = perfilAsync.value;

    return AppBar(
      backgroundColor: AppTheme.fundoApp,
      centerTitle: true,
      elevation: 0,
      leading: _construirLeading(context, perfil),
      actions: _construirActions(),
      title: Image.asset(
        'assets/icons/logotipo.png',
        height: 70,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget? _construirLeading(BuildContext context, PerfilModel? perfil) {
    if (mostrarBotaoVoltar) {
      return IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textoPrimario),
        onPressed: () => Navigator.pop(context),
      );
    }

    if (mostrarDrawer) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppTheme.textoSecundario,
            backgroundImage: perfil?.avatarPath != null ? AssetImage(perfil!.avatarPath!) : null,
            child: perfil?.avatarPath == null ? const Icon(Icons.person, size: 20, color: AppTheme.fundoApp) : null,
          ),
        ),
      );
    }
    return null;
  }

  List<Widget>? _construirActions() {
    if (!mostrarBotaoAddDeck) return null;

    final String label = labelBotaoAddDeck ?? 'detalhes.adicionar_ao_deck'.tr();
    final IconData icone = iconeBotaoAddDeck ?? Icons.add_circle;

    return <Widget>[
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: AppTheme.textoPrimario),
        color: AppTheme.textoSecundario,
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (String valor) {
          if (valor == 'acao' && cliqueBotaoAddDeck != null) {
            cliqueBotaoAddDeck!();
          }
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'acao',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  Icon(icone, color: AppTheme.fundoApp, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTheme.fonteSubtitulo(16).copyWith(color: AppTheme.fundoApp),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}