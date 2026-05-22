import 'yugioh_card_model.dart';

class MeuDeckState {
  final List<YugiohCardModel> cartas;
  final bool isLoading;
  final String? erro;

  const MeuDeckState({
    this.cartas = const <YugiohCardModel>[],
    this.isLoading = false,
    this.erro,
  });

  MeuDeckState copyWith({
    List<YugiohCardModel>? cartas,
    bool? isLoading,
    String? erro,
  }) {
    return MeuDeckState(
      cartas: cartas ?? this.cartas,
      isLoading: isLoading ?? this.isLoading,
      erro: erro ?? this.erro,
    );
  }
}
