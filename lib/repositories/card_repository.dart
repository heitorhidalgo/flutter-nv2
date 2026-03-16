import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_model.dart';
import '../models/api_error.dart';

class CardRepository {
  // A URL fica encapsulada aqui. A tela não precisa saber de onde os dados vêm.
  final String _baseUrl = 'https://db.ygoprodeck.com/api/v7/cardinfo.php?staple=yes';

  // O método agora promete retornar uma Lista de YugiohCard
  Future<List<CardModel>> fetchCards() async {
    try {
      final url = Uri.parse(_baseUrl);
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final mapData = jsonDecode(response.body);
        final List<dynamic> listaJson = mapData['data'];

        // Mapeia o JSON para objetos Dart e retorna a lista pronta
        return listaJson.map((json) => CardModel.fromJson(json)).toList();
      } else {
        // Se a API retornar erro (Caminho Triste), nós decodificamos a mensagem
        // e "lançamos" (throw) o erro para quem chamou a função.
        final mapData = jsonDecode(response.body);
        throw ApiError.fromJson(mapData, response.statusCode);
      }
    } catch (e) {
      // Se o erro já for o nosso ApiError (lançado no bloco else acima), repassamos ele.
      if (e is ApiError) {
        rethrow;
      }
      // Se for um erro externo (ex: falta de internet, timeout), envelopamos no nosso modelo.
      throw ApiError(message: 'Falha de conexão: $e', statusCode: 0);
    }
  }
}