import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/configuracoes_controller.dart';
import '../core/themes/app_theme.dart';
import '../widgets/cabecalho_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  final ConfiguracoesController _controller = ConfiguracoesController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.carregarIdiomaAtual(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fundoApp,
      appBar: const CabecalhoWidget(mostrarBotaoVoltar: true),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _tituloSecao('configuracoes.preferencias'.tr()),
                _cardIdioma(),
                const SizedBox(height: 32),
                _tituloSecao('configuracoes.sobre_app'.tr()),
                _cardVersao(),
                const SizedBox(height: 16),
                _tituloSecao('configuracoes.desenvolvido_por'.tr()),
                _cardDesenvolvedor(),
              ],
            ),
          );
        },
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

  Widget _cardIdioma() {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.language, color: AppTheme.fundoApp, size: 28),
        title: Text('configuracoes.idioma'.tr(), style: AppTheme.fonteTitulo(20).copyWith(color: AppTheme.fundoApp)),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _controller.idiomaSelecionado,
            dropdownColor: AppTheme.textoSecundario,
            icon: const Icon(Icons.arrow_drop_down, color: AppTheme.fundoApp),
            style: AppTheme.fonteDescricao(16).copyWith(color: AppTheme.fundoApp),
            items: _controller.idiomasDisponiveis.map((String idioma) {
              return DropdownMenuItem<String>(
                  value: idioma,
                  child: Text(idioma));
            }).toList(),
            onChanged: (String? novoIdioma) {
              if (novoIdioma != null) {
                _controller.alterarIdioma(context, novoIdioma);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _cardVersao() {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.info_outline, color: AppTheme.fundoApp, size: 28),
        title: Text('configuracoes.versao'.tr(), style: AppTheme.fonteTitulo(20).copyWith(color: AppTheme.fundoApp)),
        trailing: Text(
          _controller.versaoApp,
          style: AppTheme.fonteDescricao(16).copyWith(color: AppTheme.fundoApp),
        ),
      ),
    );
  }

  Widget _cardDesenvolvedor() {
    return Card(
      color: AppTheme.textoSecundario,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.textoPrimario, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.fundoApp,
              backgroundImage: AssetImage('assets/perfis/dev.png'),
            ),
            const SizedBox(height: 16),
            Text(
              _controller.desenvolvedor,
              style: AppTheme.fonteTitulo(24).copyWith(color: AppTheme.fundoApp),
            ),
            Text(
              'configuracoes.software_developer'.tr(),
              style: AppTheme.fonteDescricao(20).copyWith(color: AppTheme.fundoApp),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _botaoSocial('assets/icons/linkedin.png', 'LinkedIn', _controller.linkLinkedin),
                const SizedBox(width: 20),
                _botaoSocial('assets/icons/github.png', 'GitHub', _controller.linkGithub),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        try {
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            debugPrint('Não foi possível abrir o link: $url');
          }
        } catch (e) {
          debugPrint('Erro ao tentar abrir o link: $e');
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