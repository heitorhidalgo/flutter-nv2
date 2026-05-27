import '../../models/yugioh_card_model.dart';

class DetalhesCardArguments {
  final YugiohCardModel carta;
  final bool modoRemover;
  final String? heroTag;

  const DetalhesCardArguments({
    required this.carta,
    required this.modoRemover,
    this.heroTag,
  });
}