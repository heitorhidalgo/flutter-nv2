import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/themes/app_theme.dart';
import '../controllers/login_controller.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _loginController = LoginController();

  Future<void> _entrar() async {
    FocusScope.of(context).unfocus();

    final sucesso = await _loginController.fazerLogin(
      _emailController.text,
      _senhaController.text,
    );

    if (!mounted) return;

    if (sucesso) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _loginController.errorMessage ?? 'geral.erro_desconhecido'.tr(),
          ),
          backgroundColor: AppTheme.corErro,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/icons/logotipo.png',
                height: 200,
                fit: BoxFit.contain,
                semanticLabel: 'Yu-Gi-Oh! Logotipo',
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTheme.fonteDescricao(22),
                decoration: InputDecoration(
                  labelText: 'login.email'.tr(),
                  labelStyle: AppTheme.fonteSubtitulo(18),
                  prefixIcon:
                  const Icon(Icons.email, color: AppTheme.textoSecundario),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.textoSecundario),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: AppTheme.textoPrimario, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _senhaController,
                obscureText: true,
                style: AppTheme.fonteDescricao(22),
                decoration: InputDecoration(
                  labelText: 'login.senha'.tr(),
                  labelStyle: AppTheme.fonteSubtitulo(18),
                  prefixIcon:
                  const Icon(Icons.lock, color: AppTheme.textoSecundario),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.textoSecundario),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: AppTheme.textoPrimario, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ListenableBuilder(
                listenable: _loginController,
                builder: (context, child) {
                  return CheckboxListTile(
                    value: _loginController.manterConectado,
                    onChanged: (valor) =>
                        _loginController.alterarManterConectado(valor ?? false),
                    title: Text(
                      'login.manter_conectado'.tr(),
                      style: AppTheme.fonteDescricao(16),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppTheme.textoPrimario,
                    checkColor: AppTheme.fundoApp,
                    contentPadding: EdgeInsets.zero,
                  );
                },
              ),
              const SizedBox(height: 16),
              ListenableBuilder(
                listenable: _loginController,
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: _loginController.isLoading ? null : _entrar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.textoPrimario,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBackgroundColor:
                      AppTheme.textoSecundario.withValues(alpha: 0.5),
                    ),
                    child: _loginController.isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppTheme.fundoApp,
                        strokeWidth: 3,
                      ),
                    )
                        : Text(
                      'login.entrar'.tr(),
                      style: AppTheme.fonteTitulo(18)
                          .copyWith(color: AppTheme.fundoApp),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}