import 'package:flutter_nv2/models/yugioh_card_model.dart';

class CatalogoState {
  final List<YugiohCardModel> cartas;
  final bool isFetchingMore;
  final bool hasReachedMax;
  final String termoPesquisa;

  const CatalogoState({
    this.cartas = const <YugiohCardModel>[],
    this.isFetchingMore = false,
    this.hasReachedMax = false,
    this.termoPesquisa = '',
  });

  CatalogoState copyWith({
    List<YugiohCardModel>? cartas,
    bool? isFetchingMore,
    bool? hasReachedMax,
    String? termoPesquisa,
  }) {
    return CatalogoState(
      cartas: cartas ?? this.cartas,
      isFetchingMore:
      isFetchingMore ?? this.isFetchingMore,
      hasReachedMax:
      hasReachedMax ?? this.hasReachedMax,
      termoPesquisa:
      termoPesquisa ?? this.termoPesquisa,
    );
  }
}