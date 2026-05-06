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

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _loginController = LoginController();
  final _emailFocus = FocusNode();
  final _senhaFocus = FocusNode();
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

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    ));
    _animController.forward();
    _emailController.addListener(_loginController.onEmailChanged);
    _senhaController.addListener(_loginController.onSenhaChanged);
  }

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
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _loginController.dispose();
    _emailFocus.dispose();
    _senhaFocus.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: ListenableBuilder(
                listenable: _loginController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _logotipo(),
                      const SizedBox(height: 24),
                      _campoEmail(),
                      const SizedBox(height: 14),
                      _campoSenha(),
                      const SizedBox(height: 4),
                      _checkboxManterConectado(),
                      const SizedBox(height: 16),
                      _botaoEntrar(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _logotipo() {
    return Image.asset(
      'assets/icons/logotipo.png',
      height: 200,
      fit: BoxFit.contain,
      semanticLabel: 'Yu-Gi-Oh! Logotipo',
    );
  }

  Widget _campoEmail() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => _senhaFocus.requestFocus(),
      style: AppTheme.fonteDescricao(22),
      decoration: InputDecoration(
        labelText: 'login.email'.tr(),
        labelStyle: AppTheme.fonteSubtitulo(18),
        prefixIcon: const Icon(Icons.email, color: AppTheme.textoSecundario),
        errorText: _loginController.erroEmail,
        errorStyle: AppTheme.fonteDescricao(13).copyWith(color: AppTheme.corErro),
        errorMaxLines: 2,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _loginController.erroEmail != null
                ? AppTheme.corErro
                : AppTheme.textoSecundario,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _loginController.erroEmail != null
                ? AppTheme.corErro
                : AppTheme.textoPrimario,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.corErro),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.corErro, width: 2),
        ),
      ),
    );
  }

  Widget _campoSenha() {
    return TextField(
      controller: _senhaController,
      focusNode: _senhaFocus,
      obscureText: !_loginController.senhaVisivel,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _loginController.isLoading ? null : _entrar(),
      style: AppTheme.fonteDescricao(22),
      decoration: InputDecoration(
        labelText: 'login.senha'.tr(),
        labelStyle: AppTheme.fonteSubtitulo(18),
        prefixIcon: const Icon(Icons.lock, color: AppTheme.textoSecundario),
        suffixIcon: IconButton(
          icon: Icon(
            _loginController.senhaVisivel
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppTheme.textoSecundario,
          ),
          tooltip: _loginController.senhaVisivel
              ? 'login.ocultar_senha'.tr()
              : 'login.mostrar_senha'.tr(),
          onPressed: _loginController.alterarVisibilidadeSenha,
        ),
        errorText: _loginController.erroSenha,
        errorStyle: AppTheme.fonteDescricao(13).copyWith(color: AppTheme.corErro),
        errorMaxLines: 3,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _loginController.erroSenha != null
                ? AppTheme.corErro
                : AppTheme.textoSecundario,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _loginController.erroSenha != null
                ? AppTheme.corErro
                : AppTheme.textoPrimario,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.corErro),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.corErro, width: 2),
        ),
      ),
    );
  }

  Widget _checkboxManterConectado() {
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
  }

  Widget _botaoEntrar() {
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
  }
}