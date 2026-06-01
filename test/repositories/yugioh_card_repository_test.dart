import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_nv2/datasources/yugioh_card_datasource.dart';
import 'package:flutter_nv2/repositories/yugioh_card_repository.dart';
import 'package:flutter_nv2/models/yugioh_card_model.dart';
import 'package:flutter_nv2/models/api_error.dart';
import 'yugioh_card_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<YugiohCardDatasource>()])
void main() {
  late MockYugiohCardDatasource mockDatasource;
  late YugiohCardRepository repository;

  setUp(() {
    mockDatasource = MockYugiohCardDatasource();
    repository = YugiohCardRepository(datasource: mockDatasource);
  });

  group('YugiohCardRepository', () {
    test('deve converter o JSON do Datasource em uma lista de YugiohCardModel', () async {
      final Map<String, dynamic> jsonSimulado = {
        'data': [
          {
            'id': 1,
            'name': 'Dark Magician',
            'type': 'Normal Monster',
            'desc': 'Ultimate wizard',
            'card_images': [{'image_url': 'url1'}]
          },
          {
            'id': 2,
            'name': 'Blue-Eyes White Dragon',
            'type': 'Normal Monster',
            'desc': 'Powerful dragon',
            'card_images': [{'image_url': 'url2'}]
          }
        ]
      };

      when(mockDatasource.buscarCartas(offset: 0, limit: 20))
          .thenAnswer((_) async => jsonSimulado);

      final resultado = await repository.buscarCartasApi(offset: 0, limit: 20);

      expect(resultado, isA<List<YugiohCardModel>>());
      expect(resultado.length, equals(2));
      expect(resultado[0].name, equals('Dark Magician'));
      expect(resultado[1].name, equals('Blue-Eyes White Dragon'));
    });

    test('deve retornar uma lista vazia quando o campo data vier vazio', () async {
      when(mockDatasource.buscarCartas(offset: 0, limit: 20))
          .thenAnswer((_) async => {'data': []});

      final resultado = await repository.buscarCartasApi(offset: 0, limit: 20);

      expect(resultado, isEmpty);
    });

    test('deve repassar os parâmetros exatos (incluindo nome) para o datasource', () async {
      when(mockDatasource.buscarCartas(offset: 0, limit: 20, nome: 'Kuriboh'))
          .thenAnswer((_) async => {'data': []});

      await repository.buscarCartasApi(offset: 0, limit: 20, nome: 'Kuriboh');

      verify(mockDatasource.buscarCartas(offset: 0, limit: 20, nome: 'Kuriboh')).called(1);
    });

    test('deve propagar a exceção quando o datasource falhar', () async {
      when(mockDatasource.buscarCartas(offset: 0, limit: 20))
          .thenThrow(ApiError(message: 'Erro de servidor', statusCode: 500));

      expect(
            () => repository.buscarCartasApi(offset: 0, limit: 20),
        throwsA(isA<ApiError>()),
      );
    });
  });
}