import 'package:flutter/material.dart';
import 'package:flutter_nv2/models/yugioh_card_model.dart';

class CardDetailsPage extends StatelessWidget{
  final YugiohCardModel carta;

  const CardDetailsPage({
    super.key,
    required this.carta
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carta.name
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
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            Text(
              'Tipo: ${carta.type}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}