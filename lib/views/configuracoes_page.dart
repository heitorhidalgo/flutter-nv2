import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/themes/app_theme.dart';
import '../models/configuracoes_state.dart';
import '../notifiers/configuracoes_notifier.dart';
import '../providers/configuracoes_provider.dart';
import '../widgets/cabecalho_widget.dart';

class ConfiguracoesPage extends ConsumerStatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  ConsumerState<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends ConsumerState<ConfiguracoesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(configuracoesProvider.notifier).carregarIdiomaAtual(context);
  }

  @override
  Widget build(BuildContext context) {
    final ConfiguracoesState configuracoesState = ref.watch(
      configuracoesProvider,
    );

    final ConfiguracoesNotifier configuracoesNotifier = ref.read(
      configuracoesProvider.notifier,
    );

    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(mostrarBotaoVoltar: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _tituloSecao('configuracoes.preferencias'.tr()),
            _cardIdioma(context, configuracoesState, configuracoesNotifier),
            const SizedBox(height: 32),
            _tituloSecao('configuracoes.sobre_app'.tr()),
            _cardVersao(configuracoesNotifier),
            const SizedBox(height: 16),
            _tituloSecao('configuracoes.desenvolvido_por'.tr()),
            _cardDesenvolvedor(configuracoesNotifier),
          ],
        ),
      ),
    );
  }

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

  Widget _cardIdioma(BuildContext context, ConfiguracoesState configuracoesState, ConfiguracoesNotifier configuracoesNotifier) {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.language, color: AppTheme.fundoApp, size: 28),
        title: Text(
          'configuracoes.idioma'.tr(),
          style: AppTheme.fonteTitulo(20).copyWith(color: AppTheme.fundoApp),
        ),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: configuracoesState.idiomaSelecionado,
            dropdownColor: AppTheme.textoSecundario,
            icon: const Icon(Icons.arrow_drop_down, color: AppTheme.fundoApp),
            style: AppTheme.fonteDescricao(18).copyWith(color: AppTheme.fundoApp),
            items: configuracoesNotifier.idiomasDisponiveis.map((String idioma) {
              return DropdownMenuItem<String>(
                value: idioma,
                alignment: Alignment.center,
                child: Text(idioma),
              );
            }).toList(),
            onChanged: (String? novoIdioma) {
              if (novoIdioma != null) {
                configuracoesNotifier.alterarIdioma(context, novoIdioma);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _cardVersao(ConfiguracoesNotifier configuracoesNotifier) {
    return Card(
      color: AppTheme.textoSecundario,
      child: ListTile(
        leading: const Icon(Icons.info_outline),
        title: Text('configuracoes.versao'.tr()),
        trailing: Text(configuracoesNotifier.versaoApp),
      ),
    );
  }

  Widget _cardDesenvolvedor(ConfiguracoesNotifier configuracoesNotifier) {
    return Card(
      color: AppTheme.textoSecundario,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/perfis/dev.png'),
            ),
            const SizedBox(height: 16),
            Text(configuracoesNotifier.desenvolvedor),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _botaoSocial(
                  'assets/icons/linkedin.png',
                  'LinkedIn',
                  configuracoesNotifier.linkLinkedin,
                ),
                const SizedBox(width: 20),
                _botaoSocial(
                  'assets/icons/github.png',
                  'GitHub',
                  configuracoesNotifier.linkGithub,
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
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
      icon: Image.asset(caminhoImagem, width: 24, height: 24),
      label: Text(label),
    );
  }
}