import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/perfil_controller.dart';
import '../core/themes/app_theme.dart';
import '../providers/perfil_provider.dart';
import '../widgets/cabecalho_widget.dart';

class PerfilPage extends ConsumerStatefulWidget {
  const PerfilPage({super.key});

  @override
  ConsumerState<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState
    extends ConsumerState<PerfilPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _erroEmail;

  @override
  void initState() {
    super.initState();
    final PerfilController controller = ref.read(perfilProvider);
    _nomeController.text = controller.perfil.nome;
    _emailController.text = controller.perfil.email;
  }

  bool _validarEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PerfilController controller = ref.watch(perfilProvider);
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(
        mostrarBotaoVoltar: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,
          children: <Widget>[
            _secaoAvatar(controller),
            const SizedBox(height: 32),
            _secaoNome(),
            const SizedBox(height: 20),
            _secaoEmail(),
            const SizedBox(height: 32),
            _secaoEscolhaAvatar(controller),
            const SizedBox(height: 32),
            _botaoSalvar(controller),
          ],
        ),
      ),
    );
  }

  Widget _secaoAvatar(
      PerfilController controller) {
    final String? avatarPath = controller.perfil.avatarPath;
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundColor: AppTheme.textoSecundario,
            backgroundImage: avatarPath != null ? AssetImage(avatarPath) : null,
            child: avatarPath == null ? const Icon(
              Icons.person,
              size: 60,
              color: AppTheme.fundoApp,
            ) : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.textoPrimario,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.fundoApp,
                  width: 2,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.edit,
                  size: 18,
                  color: AppTheme.fundoApp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _secaoNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'perfil.nome'.tr(),
          style: AppTheme.fonteSubtitulo(18),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nomeController,
          style: AppTheme.fonteDescricao(18),
          decoration: InputDecoration(
            hintText:
            'perfil.insira_nome'.tr(),
            hintStyle:
            AppTheme.fonteDescricao(16).copyWith(
              color: AppTheme.textoSecundario
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.4),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(12),
              borderSide:
              const BorderSide(
                color: AppTheme.textoPrimario
              ),
            ),
            focusedBorder:
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.textoPrimario,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _secaoEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'perfil.email'.tr(),
          style: AppTheme.fonteSubtitulo(18),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: AppTheme.fonteDescricao(18),
          onChanged: (_) {
            if (_erroEmail != null) {
              setState(() {
                _erroEmail = null;
              });
            }
          },
          decoration: InputDecoration(
            hintText:
            'perfil.insira_email'.tr(),
            hintStyle:
            AppTheme.fonteDescricao(16).copyWith(
              color: AppTheme.textoSecundario
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.4),
            errorText: _erroEmail,
            errorStyle: AppTheme.fonteDescricao(13).copyWith(
              color: AppTheme.corErro,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: AppTheme.textoPrimario
              ),
            ),
            focusedBorder:
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: AppTheme.textoPrimario,
                  width: 2
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _secaoEscolhaAvatar(
      PerfilController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'perfil.escolha_avatar'.tr(),
          style: AppTheme.fonteSubtitulo(18),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: controller.avataresDisponiveis.length,
          itemBuilder: (BuildContext context, int index) {
            final String caminho = controller.avataresDisponiveis[index];
            final bool selecionado = controller.perfil.avatarPath == caminho;
            return GestureDetector(
              onTap: () {
                controller.atualizarAvatar(
                  caminho,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: selecionado ? AppTheme.textoPrimario : Colors.transparent, width: 3)
                ),
                child: CircleAvatar(
                  backgroundImage:
                  AssetImage(caminho),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _botaoSalvar(
      PerfilController controller) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.textoPrimario,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () async {

        final String email = _emailController.text.trim();
        if (!_validarEmail(email)) {
          setState(() {
            _erroEmail = 'perfil.erro_email_invalido'.tr();
          });
          return;
        }
        await controller.atualizarNome(_nomeController.text);
        await controller.atualizarEmail(email);
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'perfil.atualizado'.tr(),
              style:
              AppTheme.fonteDescricao(16).copyWith(
                color: AppTheme.textoPrimario)
            ),
            backgroundColor: AppTheme.corSucesso
          ),
        );
        Navigator.pop(context);
      },
      child: Text(
        'perfil.salvar'.tr(),
        style: AppTheme.fonteTitulo(16).copyWith(
            color: AppTheme.fundoApp
        ),
      ),
    );
  }
}