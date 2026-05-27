import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_nv2/providers/login_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  ProviderContainer criarContainer() {
    final ProviderContainer container = ProviderContainer();

    addTearDown(container.dispose);

    return container;
  }

  // ─── GRUPO 1: Estado inicial ───────────────────────────────────────────

  group('estado inicial', () {
    test('deve iniciar com estado padrão', () {
      final container = criarContainer();

      final estado = container.read(loginProvider);

      expect(estado.isLoading, false);

      expect(estado.manterConectado, false);

      expect(estado.senhaVisivel, false);

      expect(estado.erroEmail, isNull);

      expect(estado.erroSenha, isNull);
    });
  });

  // ─── GRUPO 2: Alterações de estado ─────────────────────────────────────

  group('alterações de estado', () {
    test('deve alterar visibilidade da senha', () {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      notifier.alterarVisibilidadeSenha();

      final estado = container.read(loginProvider);

      expect(estado.senhaVisivel, true);
    });

    test('deve alterar manter conectado', () {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      notifier.alterarManterConectado(true);

      final estado = container.read(loginProvider);

      expect(estado.manterConectado, true);
    });
  });

  // ─── GRUPO 3: Validação de email ───────────────────────────────────────

  group('validação de email', () {
    test('deve retornar erro quando email estiver vazio', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('', 'Senha123', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroEmail, isNotNull);
    });

    test('deve retornar erro para email inválido', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('emailinvalido', 'Senha123', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroEmail, isNotNull);
    });

    test('não deve retornar erro para email válido', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('teste@email.com', 'Senha123', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroEmail, isNull);
    });
  });

  // ─── GRUPO 4: Validação de senha ───────────────────────────────────────

  group('validação de senha', () {
    test('deve retornar erro quando senha estiver vazia', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('teste@email.com', '', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroSenha, isNotNull);
    });

    test('deve retornar erro para senha sem letra maiúscula', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('teste@email.com', 'senha123', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroSenha, isNotNull);
    });

    test('deve retornar erro para senha sem número', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('teste@email.com', 'SenhaTeste', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroSenha, isNotNull);
    });

    test('deve retornar erro para senha com menos de 8 caracteres', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('teste@email.com', 'Sen1', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroSenha, isNotNull);
    });

    test('não deve retornar erro para senha válida', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      await notifier.fazerLogin('teste@email.com', 'Senha123', (_) async {});

      final estado = container.read(loginProvider);

      expect(estado.erroSenha, isNull);
    });
  });

  // ─── GRUPO 5: Fluxo de login ───────────────────────────────────────────

  group('fluxo de login', () {
    test('deve realizar login com sucesso', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      final sucesso = await notifier.fazerLogin(
        'teste@email.com',
        'Senha123',
        (_) async {},
      );

      final estado = container.read(loginProvider);

      expect(sucesso, true);

      expect(estado.isLoading, false);

      expect(estado.erroEmail, isNull);

      expect(estado.erroSenha, isNull);
    });

    test('deve falhar login com email inválido', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      final sucesso = await notifier.fazerLogin(
        'emailinvalido',
        'Senha123',
        (_) async {},
      );

      final estado = container.read(loginProvider);

      expect(sucesso, false);

      expect(estado.erroEmail, isNotNull);
    });

    test('deve falhar login com senha inválida', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      final sucesso = await notifier.fazerLogin(
        'teste@email.com',
        '123',
        (_) async {},
      );

      final estado = container.read(loginProvider);

      expect(sucesso, false);

      expect(estado.erroSenha, isNotNull);
    });

    test('deve salvar sessão quando manter conectado estiver ativo', () async {
      final container = criarContainer();

      final notifier = container.read(loginProvider.notifier);

      notifier.alterarManterConectado(true);

      await notifier.fazerLogin('teste@email.com', 'Senha123', (_) async {});

      final prefs = await SharedPreferences.getInstance();

      expect(prefs.getBool('usuario_logado'), true);
    });

    test(
      'não deve salvar sessão quando manter conectado estiver desativado',
      () async {
        final container = criarContainer();

        final notifier = container.read(loginProvider.notifier);

        await notifier.fazerLogin('teste@email.com', 'Senha123', (_) async {});

        final prefs = await SharedPreferences.getInstance();

        expect(prefs.getBool('usuario_logado'), isNull);
      },
    );
  });
}
