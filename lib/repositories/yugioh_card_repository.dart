import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/yugioh_card_model.dart';
import '../models/api_error.dart';

class YugiohCardRepository {
  final String _baseUrl = 'https://db.ygoprodeck.com/api/v7/cardinfo.php';

  Future<List<YugiohCardModel>> buscarCartasApi({
    required int offset,
    required int limit,
    String? nome,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'num': limit.toString(),
        'offset': offset.toString(),
      };

      if (nome != null && nome.isNotEmpty) {
        queryParams['fname'] = nome;
      }

      final url = Uri.parse(_baseUrl).replace(queryParameters: queryParams);

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final mapData = jsonDecode(response.body);
        final List<dynamic> listaJson = mapData['data'];
        return listaJson.map((json) => YugiohCardModel.fromJson(json)).toList();
      }

      else if (response.statusCode == 400) {
        return [];
      }
      else {
        final mapData = jsonDecode(response.body);
        throw ApiError.fromJson(mapData, response.statusCode);
      }
    } catch (e) {
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError(message: 'Falha de conexão: $e', statusCode: 0);
    }
  }
}