import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConfiguracoesController extends ChangeNotifier {
  final String versaoApp = '1.0.0';
  final String desenvolvedor = 'Heitor Hidalgo';
  final String linkLinkedin = 'https://www.linkedin.com/in/heitorhidalgo/';
  final String linkGithub = 'https://github.com/heitorhidalgo';
  String idiomaSelecionado = 'Português (BR)';

  final List<String> idiomasDisponiveis = [
    'Português (BR)',
    'English (EN)',
    'Español (ES)'
  ];

  void alterarIdioma(BuildContext context, String novoIdioma) {
    if (novoIdioma != idiomaSelecionado) {
      idiomaSelecionado = novoIdioma;

      if (novoIdioma == 'English') {
        context.setLocale(const Locale('en', 'US'));
      } else if (novoIdioma == 'Español') {
        context.setLocale(const Locale('es', 'ES'));
      } else {
        context.setLocale(const Locale('pt', 'BR'));
      }

      notifyListeners();
    }
  }
}