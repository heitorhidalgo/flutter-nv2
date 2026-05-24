import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/themes/app_theme.dart';
import '../models/login_state.dart';
import '../notifiers/login_notifier.dart';
import '../providers/login_provider.dart';
import '../providers/perfil_provider.dart';
import '../routes/app_routes.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
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
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
    _emailController.addListener(
      ref.read(loginProvider.notifier).onEmailChanged,
    );
    _senhaController.addListener(
      ref.read(loginProvider.notifier).onSenhaChanged,
    );
  }

  Future<void> _entrar() async {
    FocusScope.of(context).unfocus();
    final LoginNotifier loginNotifier = ref.read(loginProvider.notifier);
    final bool sucesso = await loginNotifier.fazerLogin(
      _emailController.text,
      _senhaController.text,
      ref.read(perfilProvider.notifier).atualizarEmail,
    );

    if (!mounted) {
      return;
    }

    if (sucesso) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
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
    final LoginState loginState = ref.watch(loginProvider);
    final LoginNotifier loginNotifier = ref.read(loginProvider.notifier);
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _logotipo(),
                  const SizedBox(height: 24),
                  _campoEmail(loginState),
                  const SizedBox(height: 14),
                  _campoSenha(loginState, loginNotifier),
                  const SizedBox(height: 4),
                  _checkboxManterConectado(loginState, loginNotifier),
                  const SizedBox(height: 16),
                  _botaoEntrar(loginState),
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
    );
  }

  Widget _campoEmail(LoginState loginState) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        _senhaFocus.requestFocus();
      },
      style: AppTheme.fonteDescricao(22),
      decoration: InputDecoration(
        labelText: 'login.email'.tr(),
        errorText: loginState.erroEmail,
      ),
    );
  }

  Widget _campoSenha(LoginState loginState, LoginNotifier loginNotifier,) {
    return TextField(
      controller: _senhaController,
      focusNode: _senhaFocus,
      obscureText: !loginState.senhaVisivel,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) {
        if (!loginState.isLoading) {
          _entrar();
        }
      },
      decoration: InputDecoration(
        labelText: 'login.senha'.tr(),
        errorText: loginState.erroSenha,
        errorMaxLines: 4,
        errorStyle: AppTheme.fonteDescricao(12),
        suffixIcon: IconButton(
          icon: Icon(
            loginState.senhaVisivel ? Icons.visibility_off : Icons.visibility),
          onPressed:
          loginNotifier.alterarVisibilidadeSenha,
        ),
      ),
    );
  }

  Widget _checkboxManterConectado(LoginState loginState, LoginNotifier loginNotifier) {
    return CheckboxListTile(
      value: loginState.manterConectado,
      onChanged: (bool? valor) {
        loginNotifier.alterarManterConectado(valor ?? false);
      },
      title: Text('login.manter_conectado'.tr()),
    );
  }

  Widget _botaoEntrar(LoginState loginState) {
    return ElevatedButton(
      onPressed: loginState.isLoading ? null : _entrar,
      child: loginState.isLoading ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            )
          : Text('login.entrar'.tr()),
    );
  }
}