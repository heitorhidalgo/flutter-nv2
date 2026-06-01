import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_nv2/models/catalogo_state.dart';
import 'package:flutter_nv2/models/yugioh_card_model.dart';
import 'package:flutter_nv2/providers/catalogo_provider.dart';
import 'package:flutter_nv2/providers/repository_provider.dart';
import 'package:flutter_nv2/repositories/yugioh_card_repository.dart';
import 'catalogo_notifier_test.mocks.dart';


@GenerateNiceMocks([MockSpec<YugiohCardRepository>()])
List<YugiohCardModel> gerarCartas(int quantidade, {String nomeBase = 'Carta'}) {
  return List.generate(
    quantidade,
    (index) => YugiohCardModel(
      id: index + 1,
      name: '$nomeBase ${index + 1}',
      type: 'Normal Monster',
      imageUrl: 'https://exemplo.com/carta_${index + 1}.jpg',
      description: 'Descrição da carta ${index + 1}',
    ),
  );
}

void main() {
  late MockYugiohCardRepository mockRepository;

  setUp(() {
    mockRepository = MockYugiohCardRepository();
  });

  ProviderContainer criarContainer() {
    final container = ProviderContainer(
      overrides: [repositoryProvider.overrideWithValue(mockRepository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  // ─── GRUPO 1: Estado inicial ──────────────────────────────────────────────

  group('build — carregamento inicial', () {
    test('carrega cartas ao inicializar', () async {
      final cartasMock = gerarCartas(20);

      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenAnswer((_) async => cartasMock);

      final container = criarContainer();
      final estado = await container.read(catalogoProvider.future);

      expect(estado.cartas.length, equals(20));
      expect(estado.hasReachedMax, isFalse);
    });

    test('marca hasReachedMax quando API retorna menos que o limite', () async {
      final cartasMock = gerarCartas(5);

      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenAnswer((_) async => cartasMock);

      final container = criarContainer();
      final estado = await container.read(catalogoProvider.future);

      expect(estado.cartas.length, equals(5));
      expect(estado.hasReachedMax, isTrue);
    });

    test('carrega lista vazia quando API não retorna cartas', () async {
      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenAnswer((_) async => []);

      final container = criarContainer();
      final estado = await container.read(catalogoProvider.future);

      expect(estado.cartas, isEmpty);
      expect(estado.hasReachedMax, isTrue);
    });

    test('emite erro quando API lança exceção', () async {
      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenThrow(Exception('Sem internet'));

      final container = criarContainer();

      await container
          .read(catalogoProvider.future)
          .catchError((_) => CatalogoState());

      final asyncValue = container.read(catalogoProvider);
      expect(asyncValue, isA<AsyncError>());
    });
  });

  // ─── GRUPO 2: Paginação ───────────────────────────────────────────────────

  group('buscarMaisCartas — paginação', () {
    test('acumula cartas das páginas seguintes', () async {
      final primeiraPage = gerarCartas(20);
      final segundaPage = gerarCartas(10, nomeBase: 'Extra');

      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenAnswer((_) async => primeiraPage);

      when(
        mockRepository.buscarCartasApi(offset: 20, limit: 20),
      ).thenAnswer((_) async => segundaPage);

      final container = criarContainer();
      await container.read(catalogoProvider.future);

      await container.read(catalogoProvider.notifier).buscarMaisCartas();

      final estado = container.read(catalogoProvider).value!;
      expect(estado.cartas.length, equals(30));
    });

    test('não busca mais quando hasReachedMax é true', () async {
      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenAnswer((_) async => gerarCartas(5));

      final container = criarContainer();
      await container.read(catalogoProvider.future);

      await container.read(catalogoProvider.notifier).buscarMaisCartas();

      verify(mockRepository.buscarCartasApi(offset: 0, limit: 20)).called(1);
    });

    test(
      'marca hasReachedMax quando última página tem menos que o limite',
      () async {
        final primeiraPage = gerarCartas(20);
        final ultimaPage = gerarCartas(8);

        when(
          mockRepository.buscarCartasApi(offset: 0, limit: 20),
        ).thenAnswer((_) async => primeiraPage);

        when(
          mockRepository.buscarCartasApi(offset: 20, limit: 20),
        ).thenAnswer((_) async => ultimaPage);

        final container = criarContainer();
        await container.read(catalogoProvider.future);

        await container.read(catalogoProvider.notifier).buscarMaisCartas();

        final estado = container.read(catalogoProvider).value!;
        expect(estado.hasReachedMax, isTrue);
        expect(estado.cartas.length, equals(28));
      },
    );
  });

  // ─── GRUPO 3: Pesquisa ────────────────────────────────────────────────────

  group('pesquisarCarta', () {
    test('retorna cartas filtradas pelo nome', () async {
      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenAnswer((_) async => gerarCartas(20));

      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20, nome: 'Blue-Eyes'),
      ).thenAnswer((_) async => gerarCartas(3, nomeBase: 'Blue-Eyes'));

      final container = criarContainer();
      await container.read(catalogoProvider.future);

      await container
          .read(catalogoProvider.notifier)
          .pesquisarCarta('Blue-Eyes');

      final estado = container.read(catalogoProvider).value!;
      expect(estado.cartas.length, equals(3));
      expect(estado.termoPesquisa, equals('Blue-Eyes'));
    });

    test('reseta o offset ao pesquisar', () async {
      final cartasIniciais = gerarCartas(20);

      when(
        mockRepository.buscarCartasApi(offset: 0, limit: 20),
      ).thenAnswer((_) async => cartasIniciais);

      final container = criarContainer();
      await container.read(catalogoProvider.future);

      when(
        mockRepository.buscarCartasApi(offset: 20, limit: 20),
      ).thenAnswer((_) async => gerarCartas(20, nomeBase: 'Extra'));

      await container.read(catalogoProvider.notifier).buscarMaisCartas();

      when(
        mockRepository.buscarCartasApi(
          offset: 0,
          limit: 20,
          nome: 'Dark Magician',
        ),
      ).thenAnswer((_) async => gerarCartas(2, nomeBase: 'Dark Magician'));

      await container
          .read(catalogoProvider.notifier)
          .pesquisarCarta('Dark Magician');

      final estado = container.read(catalogoProvider).value!;
      expect(estado.cartas.length, equals(2));
      expect(estado.termoPesquisa, equals('Dark Magician'));
    });

    test(
      'retorna lista vazia quando pesquisa não encontra resultados',
      () async {
        when(
          mockRepository.buscarCartasApi(offset: 0, limit: 20),
        ).thenAnswer((_) async => gerarCartas(20));

        when(
          mockRepository.buscarCartasApi(
            offset: 0,
            limit: 20,
            nome: 'CartaInexistente',
          ),
        ).thenAnswer((_) async => []);

        final container = criarContainer();
        await container.read(catalogoProvider.future);

        await container
            .read(catalogoProvider.notifier)
            .pesquisarCarta('CartaInexistente');

        final estado = container.read(catalogoProvider).value!;
        expect(estado.cartas, isEmpty);
        expect(estado.hasReachedMax, isTrue);
      },
    );
  });
}
