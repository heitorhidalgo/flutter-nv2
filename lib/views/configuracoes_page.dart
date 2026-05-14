import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/configuracoes_controller.dart';
import '../core/themes/app_theme.dart';
import '../providers/configuracoes_provider.dart';
import '../widgets/cabecalho_widget.dart';

class ConfiguracoesPage extends ConsumerStatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  ConsumerState<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState
    extends ConsumerState<ConfiguracoesPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(configuracoesProvider).carregarIdiomaAtual(context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(configuracoesProvider);
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(mostrarBotaoVoltar: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tituloSecao('configuracoes.preferencias'.tr()),
            _cardIdioma(controller),
            const SizedBox(height: 32),
            _tituloSecao('configuracoes.sobre_app'.tr()),
            _cardVersao(controller),
            const SizedBox(height: 16),
            _tituloSecao('configuracoes.desenvolvido_por'.tr()),
            _cardDesenvolvedor(controller),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS FRAGMENTADOS ---

  Widget _tituloSecao(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        titulo,
        style: AppTheme.fonteSubtitulo(16).copyWith(
          color: AppTheme.textoPrimario,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _cardIdioma(ConfiguracoesController controller) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppTheme.textoPrimario,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.language,
          color: AppTheme.fundoApp,
          size: 28,
        ),
        title: Text(
          'configuracoes.idioma'.tr(),
          style: AppTheme.fonteTitulo(20).copyWith(
              color: AppTheme.fundoApp
          ),
        ),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.idiomaSelecionado,
            dropdownColor: AppTheme.textoSecundario,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppTheme.fundoApp,
            ),
            style: AppTheme.fonteDescricao(18).copyWith(
                color: AppTheme.fundoApp
            ),
            items: controller.idiomasDisponiveis.map((String idioma) {
              return DropdownMenuItem<String>(
                value: idioma,
                alignment: Alignment.center,
                child: Text(idioma),
              );
            }).toList(),
            onChanged: (String? novoIdioma) {
              if (novoIdioma != null) {
                controller.alterarIdioma(context, novoIdioma);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _cardVersao(ConfiguracoesController controller) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppTheme.textoPrimario,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.info_outline,
          color: AppTheme.fundoApp,
          size: 28,
        ),
        title: Text(
          'configuracoes.versao'.tr(),
          style: AppTheme.fonteTitulo(20).copyWith(
              color: AppTheme.fundoApp
          ),
        ),
        trailing: Text(
          controller.versaoApp,
          style: AppTheme.fonteDescricao(16).copyWith(
              color: AppTheme.fundoApp
          ),
        ),
      ),
    );
  }

  Widget _cardDesenvolvedor(ConfiguracoesController controller) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppTheme.textoPrimario,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.fundoApp,
              backgroundImage:
              AssetImage('assets/perfis/dev.png'),
            ),
            const SizedBox(height: 16),
            Text(
              controller.desenvolvedor,
              style: AppTheme.fonteTitulo(24).copyWith(
                  color: AppTheme.fundoApp
              ),
            ),
            Text(
              'configuracoes.software_developer'.tr(),
              style: AppTheme.fonteDescricao(20).copyWith(
                  color: AppTheme.fundoApp
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _botaoSocial(
                  'assets/icons/linkedin.png',
                  'LinkedIn',
                  controller.linkLinkedin,
                ),
                const SizedBox(width: 20),
                _botaoSocial(
                  'assets/icons/github.png',
                  'GitHub',
                  controller.linkGithub,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoSocial(String caminhoImagem, String label, String url) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.fundoApp,
        foregroundColor: AppTheme.textoPrimario,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        try {
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            debugPrint(
              'Não foi possível abrir o link: $url',
            );
          }
        } catch (e) {
          debugPrint(
            'Erro ao tentar abrir o link: $e',
          );
        }
      },
      icon: Image.asset(
        caminhoImagem,
        height: 24,
        width: 24,
      ),
      label: Text(label),
    );
  }
}