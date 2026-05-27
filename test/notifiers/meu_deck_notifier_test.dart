import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nv2/providers/meu_deck_provider.dart';
import '../mocks/carta_mock.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });


  ProviderContainer criarContainer() {
    final container = ProviderContainer();

    addTearDown(container.dispose);
    return container;
  }

  // ─── GRUPO 1: Adicionar carta ───────────────────────────────────────────

  group('adicionarCarta', () {
    test('adiciona uma carta ao deck com sucesso', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      final erro = await notifier.adicionarCarta(cartaMock());

      final estado = container.read(meuDeckProvider).value!;
      expect(erro, isNull);
      expect(estado.cartas.length, equals(1));
    });

    test('não permite adicionar mais de 60 cartas', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      for (int i = 0; i < 60; i++) {
        await notifier.adicionarCarta(cartaMock(id: i, name: 'Carta $i'));
      }

      final erro = await notifier.adicionarCarta(cartaMock(id: 99, name: 'Carta Extra'));

      expect(erro, isNotNull);
    });

    test('não permite mais de 3 cópias da mesma carta', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      final carta = cartaMock(name: 'Blue-Eyes White Dragon');

      await notifier.adicionarCarta(carta);
      await notifier.adicionarCarta(carta);
      await notifier.adicionarCarta(carta);

      final erro = await notifier.adicionarCarta(carta);

      expect(erro, isNotNull);
    });

    test('permite 3 cópias da mesma carta (exatamente no limite)', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      final carta = cartaMock(name: 'Dark Magician');

      final erro1 = await notifier.adicionarCarta(carta);
      final erro2 = await notifier.adicionarCarta(carta);
      final erro3 = await notifier.adicionarCarta(carta);

      expect(erro1, isNull);
      expect(erro2, isNull);
      expect(erro3, isNull);

      final estado = container.read(meuDeckProvider).value!;
      expect(estado.cartas.length, equals(3));
    });

    test('permite cartas diferentes com o mesmo id', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);
      final erro1 = await notifier.adicionarCarta(cartaMock(id: 1, name: 'Carta A'));
      final erro2 = await notifier.adicionarCarta(cartaMock(id: 1, name: 'Carta B'));

      expect(erro1, isNull);
      expect(erro2, isNull);

      final estado = container.read(meuDeckProvider).value!;
      expect(estado.cartas.length, equals(2));
    });
  });

  // ─── GRUPO 2: Remover carta ─────────────────────────────────────────────

  group('removerCarta', () {
    test('remove uma carta do deck com sucesso', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      final carta = cartaMock();
      await notifier.adicionarCarta(carta);
      await notifier.removerCarta(carta);

      final estado = container.read(meuDeckProvider).value!;
      expect(estado.cartas, isEmpty);
    });

    test('deck fica vazio após remover única carta', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      final carta = cartaMock();
      await notifier.adicionarCarta(carta);

      final estadoAntes = container.read(meuDeckProvider).value!;
      expect(estadoAntes.cartas.length, equals(1));

      await notifier.removerCarta(carta);

      final estadoDepois = container.read(meuDeckProvider).value!;
      expect(estadoDepois.cartas, isEmpty);
    });

    test('remove apenas uma cópia quando há múltiplas', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      final carta = cartaMock();
      await notifier.adicionarCarta(carta);
      await notifier.adicionarCarta(carta);
      await notifier.removerCarta(carta);

      final estado = container.read(meuDeckProvider).value!;
      expect(estado.cartas.length, equals(1));
    });
  });

  // ─── GRUPO 3: Limpar deck ───────────────────────────────────────────────

  group('limpar', () {
    test('limpa todas as cartas do deck', () async {
      final container = criarContainer();
      await container.read(meuDeckProvider.future);
      final notifier = container.read(meuDeckProvider.notifier);

      await notifier.adicionarCarta(cartaMock(id: 1, name: 'Carta A'));
      await notifier.adicionarCarta(cartaMock(id: 2, name: 'Carta B'));
      await notifier.adicionarCarta(cartaMock(id: 3, name: 'Carta C'));

      await notifier.limpar();

      final estado = container.read(meuDeckProvider).value!;
      expect(estado.cartas, isEmpty);
    });
  });

  // ─── GRUPO 4: Estado inicial ─────────────────────────────────────────────

  group('estado inicial', () {
    test('deck começa vazio quando não há dados salvos', () async {
      final container = criarContainer();
      final estado = await container.read(meuDeckProvider.future);

      expect(estado.cartas, isEmpty);
    });
  });
}