import 'package:flutter/material.dart';

import '../core/themes/app_theme.dart';

class BotaoHomeWidget extends StatelessWidget{
  final String titulo;
  final IconData icone;
  final VoidCallback clique;

  const BotaoHomeWidget({
    super.key,
    required this.titulo,
    required this.icone,
    required this.clique
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clique,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.textoSecundario,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.textoPrimario, width: 2)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icone,
              size: 50,
              color: AppTheme.fundoApp,
            ),
            const SizedBox(height: 12),
            Text(
              titulo,
              style: AppTheme.fonteTitulo(18).copyWith(color: AppTheme.fundoApp),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}