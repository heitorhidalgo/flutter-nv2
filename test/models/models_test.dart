import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_nv2/models/yugioh_card_model.dart';
import 'package:flutter_nv2/models/api_error.dart';

void main() {
  // ─── GRUPO 1: Testes do Modelo de Carta ─────────────────────────────────

  group('YugiohCardModel', () {
    test('deve criar o modelo corretamente a partir de um JSON completo', () {
      final Map<String, dynamic> jsonApi = {
        'id': 89631139,
        'name': 'Dark Magician',
        'type': 'Normal Monster',
        'desc': 'The ultimate wizard in terms of attack and defense.',
        'card_images': [
          {'image_url': 'https://images.ygoprodeck.com/images/cards/89631139.jpg'}
        ]
      };

      final carta = YugiohCardModel.fromJson(jsonApi);

      expect(carta.id, equals(89631139));
      expect(carta.name, equals('Dark Magician'));
      expect(carta.type, equals('Normal Monster'));
      expect(carta.description, equals('The ultimate wizard in terms of attack and defense.'));
      expect(carta.imageUrl, equals('https://images.ygoprodeck.com/images/cards/89631139.jpg'));
    });

    test('deve lidar de forma segura com JSON sem imagens (lista vazia ou nula)', () {
      final Map<String, dynamic> jsonIncompleto = {
        'id': 123,
        'name': 'Carta Teste',
        'type': 'Spell Card',
        'desc': 'Apenas um teste',
      };

      final carta = YugiohCardModel.fromJson(jsonIncompleto);

      expect(carta.name, equals('Carta Teste'));
      expect(carta.imageUrl, isEmpty);
    });
  });

  // ─── GRUPO 2: Testes do Tratamento de Erros ─────────────────────────────

  group('ApiError', () {
    test('deve converter erro da API corretamente', () {
      final jsonErro = {'error': 'No card matching your query was found in the database.'};
      const statusCode = 400;

      final erro = ApiError.fromJson(jsonErro, statusCode);

      expect(erro.message, equals('No card matching your query was found in the database.'));
      expect(erro.statusCode, equals(400));
    });

    test('deve assumir "unknown_error" quando o JSON não vier com a chave de erro', () {
      final jsonInesperado = {'outra_chave_qualquer': 'algo deu errado'};

      final erro = ApiError.fromJson(jsonInesperado, 500);

      expect(erro.message, equals('unknown_error'));
      expect(erro.statusCode, equals(500));
      expect(erro.toString(), equals('unknown_error'));
    });
  });
}