import 'package:flutter/material.dart';
import 'package:flutter_nv2/models/yugioh_card_model.dart';

import '../core/themes/app_theme.dart';

class CardDetailsPage extends StatelessWidget{
  final YugiohCardModel carta;

  const CardDetailsPage({
    super.key,
    required this.carta
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: AppBar(
        backgroundColor: AppTheme.fundoApp,
        title: Text(
          carta.name,
          style: AppTheme.fonteTitulo(30),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                carta.imageUrl,
                height: 400,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress){
                  if(loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 400,
                  child: Icon(Icons.broken_image,
                  size: 100,
                  color: Colors.grey
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              carta.name,
              style: AppTheme.fonteTitulo(35),
              textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            Text(
              'Tipo: ${carta.type}',
              style: AppTheme.fonteSubtitulo(30),
              textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            Text(
              'Descrição: ${carta.description}',
              style: AppTheme.fonteDescricao(25),
              textAlign: TextAlign.justify,
              ),
          ],
        ),
      ),
    );
  }
}