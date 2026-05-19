import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/configs/app_config.dart';
import '../models/api_error.dart';

class YugiohCardDatasource {
  final String _baseUrl = AppConfig.baseUrlApi;

  Future<Map<String, dynamic>> buscarCartas({required int offset, required int limit, String? nome}) async {
    try {
      final Map<String, String> queryParams = <String, String>{
        'num': limit.toString(),
        'offset': offset.toString(),
      };

      if (nome != null && nome.isNotEmpty) {
        queryParams['fname'] = nome;
      }

      final Uri url = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
      final http.Response response = await http.get(url, headers: <String, String> {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }

      if (response.statusCode == 400) {
        return <String, dynamic>{
          'data': <dynamic>[],
        };
      }

      throw ApiError.fromJson(jsonDecode(response.body), response.statusCode);
    } on TimeoutException {
      throw ApiError(
        message: 'Tempo de conexão esgotado. Verifique sua internet.',
        statusCode: 0,
      );
    } catch (e) {
      if (e is ApiError) {
        rethrow;
      }

      throw ApiError(
        message: 'Falha de conexão: $e',
        statusCode: 0,
      );
    }
  }
}