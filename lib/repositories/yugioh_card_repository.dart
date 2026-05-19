import '../datasources/yugioh_card_datasource.dart';
import '../models/yugioh_card_model.dart';

class YugiohCardRepository {
  YugiohCardRepository({YugiohCardDatasource? datasource}) : _datasource = datasource ?? YugiohCardDatasource();
  final YugiohCardDatasource _datasource;

  Future<List<YugiohCardModel>> buscarCartasApi({required int offset, required int limit, String? nome}) async {
    final Map<String, dynamic> dados =
    await _datasource.buscarCartas(offset: offset, limit: limit, nome: nome);
    final List<dynamic> listaJson = dados['data'] ?? <dynamic>[];
    return listaJson.map((dynamic json) {
        return YugiohCardModel.fromJson(json as Map<String, dynamic>);
      },
    ).toList();
  }
}