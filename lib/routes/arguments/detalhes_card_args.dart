import '../../models/yugioh_card_model.dart';

class DetalhesCardArguments {
  final YugiohCardModel carta;
  final bool modoRemover;

  const DetalhesCardArguments({
    required this.carta,
    required this.modoRemover,
  });
}