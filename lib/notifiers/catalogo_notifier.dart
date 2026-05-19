import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/configs/app_config.dart';
import '../models/catalogo_state.dart';
import '../models/yugioh_card_model.dart';
import '../repositories/yugioh_card_repository.dart';

class CatalogoNotifier extends AsyncNotifier<CatalogoState> {
  final YugiohCardRepository _repository = YugiohCardRepository();
  int _offset = 0;
  final int _limit = AppConfig.limitePaginacao;

  @override
  Future<CatalogoState> build() async {
    return await _buscarCartasInicial();
  }

  Future<CatalogoState> _buscarCartasInicial() async {
    final List<YugiohCardModel> cartas =
    await _repository.buscarCartasApi(offset: 0, limit: _limit);
    _offset = _limit;
    return CatalogoState(
      cartas: cartas,
      hasReachedMax:
      cartas.length < _limit,
    );
  }

  Future<void> buscarMaisCartas() async {
    final CatalogoState? estadoAtual = state.value;
    if (estadoAtual == null) {
      return;
    }

    if (estadoAtual.isFetchingMore || estadoAtual.hasReachedMax) {
      return;
    }

    state = AsyncData(estadoAtual.copyWith(isFetchingMore: true));

    try {
      final List<YugiohCardModel>
      novasCartas = await _repository.buscarCartasApi(
        offset: _offset,
        limit: _limit,
        nome: estadoAtual.termoPesquisa.isNotEmpty ? estadoAtual.termoPesquisa : null,
      );

      _offset += _limit;
      state = AsyncData(
        estadoAtual.copyWith(
          cartas: <YugiohCardModel>[
            ...estadoAtual.cartas,
            ...novasCartas,
          ],
          isFetchingMore: false,
          hasReachedMax: novasCartas.length < _limit,
        ),
      );
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> pesquisarCarta(String nome) async {
    _offset = 0;
    state = const AsyncLoading();

    try {
      final List<YugiohCardModel>
      cartas = await _repository.buscarCartasApi(
        offset: 0,
        limit: _limit,
        nome: nome.isNotEmpty ? nome : null);
      _offset += _limit;
      state = AsyncData(
        CatalogoState(
          cartas: cartas,
          termoPesquisa: nome,
          hasReachedMax:
          cartas.length < _limit,
        ),
      );
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}