import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/themes/app_theme.dart';
import '../models/perfil_model.dart';
import '../providers/login_provider.dart';
import '../providers/meu_deck_provider.dart';
import '../providers/perfil_provider.dart';
import '../routes/app_routes.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PerfilModel? perfil = ref.watch(perfilProvider).value;

    return Drawer(
      backgroundColor: AppTheme.textoSecundario,
      child: Column(
        children: <Widget>[
          _cabecalhoDrawer(perfil),
          const Divider(color: AppTheme.fundoApp, thickness: 0.5),
          _itemPerfil(context),
          _itemLogout(context, ref),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _cabecalhoDrawer(PerfilModel? perfil) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _avatarPerfil(perfil, radius: 50),
            const SizedBox(height: 12),
            Text(
              perfil?.nome ?? 'Duelista',
              style: AppTheme.fonteTitulo(24).copyWith(color: AppTheme.fundoApp),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              perfil?.email ?? '',
              style: AppTheme.fonteDescricao(20).copyWith(color: AppTheme.fundoApp),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemPerfil(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_outline, color: AppTheme.fundoApp),
      title: Text(
        'drawer.perfil'.tr(),
        style: AppTheme.fonteSubtitulo(16).copyWith(color: AppTheme.fundoApp),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRoutes.perfil);
      },
    );
  }

  Widget _itemLogout(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.logout, color: AppTheme.fundoApp),
      title: Text(
        'drawer.sair'.tr(),
        style: AppTheme.fonteSubtitulo(16).copyWith(color: AppTheme.fundoApp),
      ),
      onTap: () => _confirmarLogout(context, ref),
    );
  }

  void _confirmarLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: AppTheme.textoSecundario,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'drawer.sair'.tr(),
            style: AppTheme.fonteTitulo(20).copyWith(color: AppTheme.fundoApp),
          ),
          content: Text(
            'drawer.confirmar_sair'.tr(),
            style: AppTheme.fonteDescricao(16).copyWith(color: AppTheme.fundoApp),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'drawer.cancelar'.tr(),
                style: AppTheme.fonteSubtitulo(14).copyWith(color: AppTheme.fundoApp),
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
                await Future.wait([
                  ref.read(perfilProvider.notifier).limparPerfil(),
                  ref.read(meuDeckProvider.notifier).limpar(),
                  ref.read(loginProvider.notifier).limparSessao(),
                ]);
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'drawer.sair'.tr(),
                style: AppTheme.fonteTitulo(14).copyWith(color: AppTheme.fundoApp),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _avatarPerfil(PerfilModel? perfil, {double radius = 30}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppTheme.fundoApp,
      backgroundImage: perfil?.avatarPath != null ? AssetImage(perfil!.avatarPath!) : null,
      child: perfil?.avatarPath == null ? Icon(Icons.person, size: radius, color: AppTheme.textoPrimario) : null,
    );
  }
}