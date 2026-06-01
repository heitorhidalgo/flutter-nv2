import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nv2/providers/perfil_provider.dart';

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
    test('deve iniciar com perfil padrão (Duelista) quando cache está vazio', () async {
      final container = criarContainer();

      final perfil = await container.read(perfilProvider.future);

      expect(perfil.nome, equals('Duelista'));
      expect(perfil.email, equals('duelista@yugioh.com'));
      expect(perfil.avatarPath, isNull);
    });

    test('deve carregar dados salvos no cache ao iniciar', () async {
      SharedPreferences.setMockInitialValues({
        'perfil_nome': 'Seto Kaiba',
        'perfil_email': 'kaiba@kc.com',
        'perfil_avatar': 'assets/personagens/kaiba.jpg',
      });

      final container = criarContainer();
      final perfil = await container.read(perfilProvider.future);

      expect(perfil.nome, equals('Seto Kaiba'));
      expect(perfil.email, equals('kaiba@kc.com'));
      expect(perfil.avatarPath, equals('assets/personagens/kaiba.jpg'));
    });
  });

  // ─── GRUPO 2: Atualização de Dados ─────────────────────────────────────

  group('atualização de dados', () {
    test('deve atualizar o nome no estado e no SharedPreferences', () async {
      final container = criarContainer();
      await container.read(perfilProvider.future);
      final notifier = container.read(perfilProvider.notifier);

      await notifier.atualizarNome('Yugi Muto  ');

      final estado = container.read(perfilProvider).value!;
      expect(estado.nome, equals('Yugi Muto'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('perfil_nome'), equals('Yugi Muto'));
    });

    test('deve atualizar o email no estado e no SharedPreferences', () async {
      final container = criarContainer();
      await container.read(perfilProvider.future);
      final notifier = container.read(perfilProvider.notifier);

      await notifier.atualizarEmail('yugi@kingofgames.com  ');

      final estado = container.read(perfilProvider).value!;
      expect(estado.email, equals('yugi@kingofgames.com'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('perfil_email'), equals('yugi@kingofgames.com'));
    });

    test('deve atualizar o avatar no estado e no SharedPreferences', () async {
      final container = criarContainer();
      await container.read(perfilProvider.future);
      final notifier = container.read(perfilProvider.notifier);

      await notifier.atualizarAvatar('assets/personagens/yugi.jpg');

      final estado = container.read(perfilProvider).value!;
      expect(estado.avatarPath, equals('assets/personagens/yugi.jpg'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('perfil_avatar'), equals('assets/personagens/yugi.jpg'));
    });
  });

  // ─── GRUPO 3: Limpeza de Perfil ────────────────────────────────────────

  group('limpeza de perfil', () {
    test('deve apagar os dados do SharedPreferences e voltar ao padrão', () async {
      SharedPreferences.setMockInitialValues({
        'perfil_nome': 'Joey Wheeler',
        'perfil_email': 'joey@brooklyn.com',
        'perfil_avatar': 'assets/personagens/joey.jpg',
      });

      final container = criarContainer();
      await container.read(perfilProvider.future);
      final notifier = container.read(perfilProvider.notifier);

      await notifier.limparPerfil();

      final estado = container.read(perfilProvider).value!;
      expect(estado.nome, equals('Duelista'));
      expect(estado.email, equals('duelista@yugioh.com'));
      expect(estado.avatarPath, isNull);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('perfil_nome'), isFalse);
      expect(prefs.containsKey('perfil_email'), isFalse);
      expect(prefs.containsKey('perfil_avatar'), isFalse);
    });
  });
}