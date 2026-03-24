import 'package:flutter/material.dart';
import 'package:flutter_nv2/views/home_page.dart';

import '../core/themes/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  
  void _fazerLogin(){
    Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
            builder: (context) => const HomePage()
        ),
    );
  }
  
  @override
  void dispose(){
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Yu-Gi-Oh! App',
                style: AppTheme.fonteTitulo(40),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTheme.fonteDescricao(18),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: AppTheme.fonteSubtitulo(16),
                  prefixIcon: const Icon(Icons.email, color: AppTheme.textoSecundario),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.textoSecundario),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.textoPrimario, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _senhaController,
                obscureText: true,
                style: AppTheme.fonteDescricao(18),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: AppTheme.fonteSubtitulo(16),
                  prefixIcon: const Icon(Icons.password, color: AppTheme.textoSecundario),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.textoSecundario),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.textoPrimario, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(onPressed: _fazerLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.textoPrimario,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                  child: Text(
                    'Entrar',
                    style: AppTheme.fonteTitulo(18).copyWith(color: AppTheme.fundoApp),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}