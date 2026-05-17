import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/login_controller.dart';
import '../controllers/perfil_controller.dart';
import '../core/themes/app_theme.dart';
import '../providers/login_provider.dart';
import '../providers/perfil_provider.dart';
import 'home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with SingleTickerProviderStateMixin {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _senhaFocus = FocusNode();
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
          vsync: this,
          duration:
          const Duration(
            milliseconds: 600,
          ),
        );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _slideAnim = Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animController,
            curve:
            Curves.easeOut,
          ),
        );

    _animController.forward();

    _emailController.addListener(
      ref.read(loginProvider).onEmailChanged);

    _senhaController.addListener(ref.read(loginProvider).onSenhaChanged);
  }

  Future<void> _entrar() async {
    FocusScope.of(context).unfocus();

    final LoginController loginController = ref.read(loginProvider);

    final PerfilController perfilController = ref.read(perfilProvider);

    final bool sucesso = await loginController.fazerLogin(
      _emailController.text,
      _senhaController.text,
      perfilController,
    );

    if (!mounted) {
      return;
    }

    if (sucesso) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (BuildContext context) => const HomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _emailFocus.dispose();
    _senhaFocus.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor:
      AppTheme.fundoApp,
      body: Center(
        child:
        SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child:
          FadeTransition(
            opacity: _fadeAnim,
            child:
            SlideTransition(
              position: _slideAnim,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _logotipo(),
                  const SizedBox(height: 24),
                  _campoEmail(loginController),
                  const SizedBox(height: 14),
                  _campoSenha(loginController),
                  const SizedBox(height: 4),
                  _checkboxManterConectado(loginController),
                  const SizedBox(height: 16),
                  _botaoEntrar(loginController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logotipo() {
    return Image.asset(
      'assets/icons/logotipo.png',
      height: 200,
      fit: BoxFit.contain,
      semanticLabel:
      'Yu-Gi-Oh! Logotipo',
    );
  }

  Widget _campoEmail(LoginController loginController) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => _senhaFocus.requestFocus(),
      style: AppTheme.fonteDescricao(22),
      decoration:
      InputDecoration(
        labelText:
        'login.email'.tr(),
        errorText:
        loginController.erroEmail,
      ),
    );
  }

  Widget _campoSenha(LoginController loginController) {
    return TextField(
      controller: _senhaController,
      focusNode: _senhaFocus,
      obscureText: !loginController.senhaVisivel,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => loginController.isLoading ? null : _entrar(),
      decoration:
      InputDecoration(
        labelText:
        'login.senha'.tr(),
        errorText:
        loginController.erroSenha,
        suffixIcon:
        IconButton(
          icon: Icon(
            loginController.senhaVisivel ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed:
          loginController.alterarVisibilidadeSenha,
        ),
      ),
    );
  }

  Widget _checkboxManterConectado(LoginController loginController) {
    return CheckboxListTile(
      value:
      loginController.manterConectado,
      onChanged: (bool? valor) {
        loginController.alterarManterConectado(valor ?? false);
      },
      title: Text(
        'login.manter_conectado'.tr(),
      ),
    );
  }

  Widget _botaoEntrar(LoginController loginController) {
    return ElevatedButton(
      onPressed:
      loginController.isLoading ? null : _entrar,
      child:
      loginController.isLoading ? const SizedBox(
        height: 24,
        width: 24,
        child:
        CircularProgressIndicator(),
      ) : Text(
        'login.entrar'.tr(),
      ),
    );
  }
}