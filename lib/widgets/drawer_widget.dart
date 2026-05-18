import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/perfil_controller.dart';
import '../core/themes/app_theme.dart';
import '../providers/meu_deck_provider.dart';
import '../providers/perfil_provider.dart';
import '../views/perfil_page.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PerfilController controller = ref.watch(perfilProvider);

    return Drawer(
      backgroundColor: AppTheme.textoSecundario,
      child: Column(
        children: <Widget>[
          _cabecalhoDrawer(
            context,
            controller,
          ),
          const Divider(
            color: AppTheme.fundoApp,
            thickness: 0.5,
          ),
          _itemPerfil(context),
          _itemLogout(
            context,
            ref,
            controller,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _cabecalhoDrawer(BuildContext context, PerfilController controller) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _avatarPerfil(
              controller,
              radius: 50,
            ),
            const SizedBox(height: 12),
            Text(
              controller.perfil.nome,
              style: AppTheme.fonteTitulo(24).copyWith(
                color: AppTheme.fundoApp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              controller.perfil.email,
              style: AppTheme.fonteDescricao(20).copyWith(
                color: AppTheme.fundoApp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemPerfil(
      BuildContext context,
      ) {
    return ListTile(
      leading: const Icon(
        Icons.person_outline,
        color: AppTheme.fundoApp,
      ),
      title: Text(
        'drawer.perfil'.tr(),
        style: AppTheme.fonteSubtitulo(16).copyWith(
          color: AppTheme.fundoApp,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PerfilPage(),
          ),
        );
      },
    );
  }

  Widget _itemLogout(BuildContext context, WidgetRef ref, PerfilController controller) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: AppTheme.fundoApp,
      ),
      title: Text(
        'drawer.sair'.tr(),
        style: AppTheme.fonteSubtitulo(16).copyWith(
          color: AppTheme.fundoApp,
        ),
      ),
      onTap: () => _confirmarLogout(
        context,
        ref,
        controller,
      ),
    );
  }

  void _confirmarLogout(BuildContext context, WidgetRef ref, PerfilController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.textoSecundario,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'drawer.sair'.tr(),
          style: AppTheme.fonteTitulo(20).copyWith(
            color: AppTheme.fundoApp,
          ),
        ),
        content: Text(
          'drawer.confirmar_sair'.tr(),
          style: AppTheme.fonteDescricao(16).copyWith(
            color: AppTheme.fundoApp,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              'drawer.cancelar'.tr(),
              style: AppTheme.fonteSubtitulo(14).copyWith(
                color: AppTheme.fundoApp,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.textoPrimario,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(meuDeckProvider).limpar();
              await controller.fazerLogout(context);
            },
            child: Text(
              'drawer.sair'.tr(),
              style: AppTheme.fonteTitulo(14).copyWith(
                color: AppTheme.fundoApp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarPerfil(PerfilController controller, {
        double radius = 30,
      }) {
    final String? avatarPath = controller.perfil.avatarPath;
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppTheme.fundoApp,
      backgroundImage: avatarPath != null ? AssetImage(avatarPath) : null,
      child: avatarPath == null ? Icon(
        Icons.person,
        size: radius,
        color: AppTheme.textoPrimario) : null,
    );
  }
}