import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_nv2/core/configs/app_config.dart';
import '../models/api_error.dart';
import '../models/yugioh_card_model.dart';
import '../repositories/yugioh_card_repository.dart';

class CatalogoController extends ChangeNotifier {
  final YugiohCardRepository repository;

  CatalogoController(this.repository);

  List<YugiohCardModel> cartas = [];
  bool isLoading = false;
  bool isFetchingMore = false;
  String? errorMessage;

  int _offset = 0;
  final int _limit = AppConfig.limitePaginacao;
  bool hasReachedMax = false;
  String _termoPesquisa = '';

  Future<void> buscarCartas({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isFetchingMore || hasReachedMax) return;
      isFetchingMore = true;
      notifyListeners();
    } else {
      isLoading = true;
      errorMessage = null;
      _offset = 0;
      hasReachedMax = false;
      cartas.clear();
      notifyListeners();
    }

    try {
      final novasCartas = await repository.buscarCartasApi(
        offset: _offset,
        limit: _limit,
        nome: _termoPesquisa.isNotEmpty ? _termoPesquisa : null,
      );

      if (novasCartas.length < _limit) {
        hasReachedMax = true;
      }

      cartas.addAll(novasCartas);
      _offset += _limit;
    } catch (e) {
      if (!isLoadMore) {
        final mensagem = e is ApiError
            ? 'catalogo.erro_buscar'.tr(namedArgs: {'erro': e.message})
            : 'catalogo.erro_buscar'.tr(namedArgs: {'erro': 'geral.erro_desconhecido'.tr()});
        errorMessage = mensagem;
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