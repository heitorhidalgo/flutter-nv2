import 'package:flutter/material.dart';
import '../core/themes/app_theme.dart';

class CabecalhoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool mostrarBotaoVoltar;
  final bool mostrarDrawer;

  const CabecalhoWidget({
    super.key,
    this.mostrarBotaoVoltar = false,
    this.mostrarDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.fundoApp,
      centerTitle: true,
      elevation: 0,
      leading: _construirLeading(context),
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
