import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/configuracoes_state.dart';

class ConfiguracoesNotifier extends Notifier<ConfiguracoesState> {
  final String versaoApp = '1.0.0';
  final String desenvolvedor = 'Heitor Hidalgo';
  final String linkLinkedin = 'https://www.linkedin.com/in/heitorhidalgo/';
  final String linkGithub = 'https://github.com/heitorhidalgo';

  final List<String> idiomasDisponiveis = <String>[
    'Português (BR)',
    'English',
    'Español',
  ];

  @override
  ConfiguracoesState build() {
    return const ConfiguracoesState();
  }

  void carregarIdiomaAtual(BuildContext context) {
    final String localeCode = context.locale.languageCode;
    if (localeCode == 'en') {
      state = state.copyWith(idiomaSelecionado: 'English');
      return;
    }

    if (localeCode == 'es') {
      state = state.copyWith(idiomaSelecionado: 'Español');
      return;
    }

    state = state.copyWith(idiomaSelecionado: 'Português (BR)');
  }

  void alterarIdioma(BuildContext context, String novoIdioma) {
    if (novoIdioma == state.idiomaSelecionado) {
      return;
    }

    state = state.copyWith(idiomaSelecionado: novoIdioma);

    if (novoIdioma == 'English') {
      context.setLocale(const Locale('en', 'US'));
      return;
    }

    if (novoIdioma == 'Español') {
      context.setLocale(const Locale('es', 'ES'));
      return;
    }

    context.setLocale(const Locale('pt', 'BR'));
  }
}
