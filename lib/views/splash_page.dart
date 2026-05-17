import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/login_controller.dart';
import '../providers/perfil_provider.dart';
import '../providers/meu_deck_provider.dart';
import '../core/themes/app_theme.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future<void> _inicializar() async {
    await Future.wait(<Future<void>>[
      ref.read(perfilProvider).inicializar(),
      ref.read(meuDeckProvider).inicializar(),
    ]);

    final bool estaLogado =
    await LoginController.estaLogado();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
        estaLogado
            ? const HomePage()
            : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icons/icone.png',
              width: 180,
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              color: AppTheme.textoPrimario,
            ),
          ],
        ),
      ),
    );
  }
}