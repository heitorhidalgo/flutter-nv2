import 'package:flutter/material.dart';
import 'package:flutter_nv2/controllers/splash_controller.dart';
import '../core/themes/app_theme.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _pulseAnimation;

  final SplashController _splashController = SplashController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.10,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.repeat(reverse: true);

    _iniciarCarregamento();
  }

  void _iniciarCarregamento() async {
    final sucesso = await _splashController.carregarDependencias();

    if(!mounted) {
      return;
    }

    if(sucesso) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Erro ao iniciar o aplicativo. Tente novamente!'),
            backgroundColor: AppTheme.corErro,
          ));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _pulseAnimation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/icons/card_verso.png',
                  height: 350,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 75),
            Text('Carregando...',
                style: AppTheme.fonteTitulo(20)),
          ],
        ),
      ),
    );
  }
}
