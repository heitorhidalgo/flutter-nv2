import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_nv2/providers/configuracoes_provider.dart';

void main() {
  ProviderContainer criarContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  group('ConfiguracoesNotifier - Estado e Propriedades', () {
    test('deve iniciar com o idioma padrão Português (BR)', () {
      final container = criarContainer();
      final estado = container.read(configuracoesProvider);

      expect(estado.idiomaSelecionado, equals('Português (BR)'));
    });

    test('deve conter as informações corretas do desenvolvedor e aplicativo', () {
      final container = criarContainer();
      final notifier = container.read(configuracoesProvider.notifier);

      expect(notifier.versaoApp, equals('1.0.0'));
      expect(notifier.desenvolvedor, equals('Heitor Hidalgo'));
      expect(notifier.linkLinkedin, equals('https://www.linkedin.com/in/heitorhidalgo/'));
      expect(notifier.linkGithub, equals('https://github.com/heitorhidalgo'));
    });

    test('deve conter a lista exata com os 3 idiomas suportados', () {
      final container = criarContainer();
      final notifier = container.read(configuracoesProvider.notifier);

      expect(notifier.idiomasDisponiveis.length, equals(3));
      expect(
        notifier.idiomasDisponiveis,
        containsAll([
          'Português (BR)',
          'English',
          'Español',
        ]),
      );
    });
  });
}