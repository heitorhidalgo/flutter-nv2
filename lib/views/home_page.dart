import 'package:flutter/material.dart';
import 'package:flutter_nv2/views/catalogo_page.dart';
import '../core/themes/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: AppBar(
        backgroundColor: AppTheme.textoPrimario,
        title: Text(
          'Yu-Gi-Oh! App',
          style: AppTheme.fonteTitulo(24).copyWith(color: AppTheme.fundoApp),
        ),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logotipo.png',
                height: 200,
                fit: BoxFit.contain,
                semanticLabel: 'Yu-Gi-Oh! Logotipo',
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CatalogoPage()),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppTheme.textoPrimario.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.textoPrimario, width: 2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.style,
                          size: 80,
                          color: AppTheme.textoPrimario,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Catálogo de Cartas',
                          style: AppTheme.fonteTitulo(24),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}