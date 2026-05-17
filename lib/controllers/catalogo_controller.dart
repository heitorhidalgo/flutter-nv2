import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/configs/app_config.dart';
import '../models/api_error.dart';
import '../models/yugioh_card_model.dart';
import '../repositories/yugioh_card_repository.dart';

class CatalogoController extends ChangeNotifier {
  CatalogoController({YugiohCardRepository? repository}) : _repository = repository ?? YugiohCardRepository();

  final YugiohCardRepository _repository;
  final List<YugiohCardModel> _cartas = <YugiohCardModel>[];

  List<YugiohCardModel> get cartas => List.unmodifiable(_cartas);

  bool isLoading = false;
  bool isFetchingMore = false;
  bool hasReachedMax = false;
  String? errorMessage;
  int _offset = 0;

  final int _limit = AppConfig.limitePaginacao;
  String _termoPesquisa = '';

  Future<void> buscarCartas({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isFetchingMore || hasReachedMax) {
        return;
      }

      isFetchingMore = true;
      notifyListeners();
    } else {
      isLoading = true;
      errorMessage = null;
      _offset = 0;
      hasReachedMax = false;
      _cartas.clear();
      notifyListeners();
    }

    try {
      final List<YugiohCardModel> novasCartas = await _repository.buscarCartasApi(
        offset: _offset,
        limit: _limit,
        nome: _termoPesquisa.isNotEmpty ? _termoPesquisa : null,
      );

      if (novasCartas.length < _limit) {
        hasReachedMax = true;
      }

      _cartas.addAll(novasCartas);
      _offset += _limit;
    } catch (e) {
      if (!isLoadMore) {
        errorMessage = e is ApiError ? 'catalogo.erro_buscar'.tr(namedArgs: <String, String>{
            'erro': e.message,
          },
        ) : 'catalogo.erro_buscar'.tr(namedArgs: <String, String>{
            'erro': 'geral.erro_desconhecido'.tr(),
          },
        );
      }
    } finally {
      isLoading = false;
      isFetchingMore = false;
      notifyListeners();
    }
  }

  void pesquisarCarta(String nome) {
    _termoPesquisa = nome;
    buscarCartas(isLoadMore: false);
  }
}