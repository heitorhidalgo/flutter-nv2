import 'package:flutter_nv2/models/yugioh_card_model.dart';

YugiohCardModel cartaMock({
  int id = 1,
  String name = 'Blue-Eyes White Dragon',
}) {
  return YugiohCardModel(
    id: id,
    name: name,
    type: 'Normal Monster',
    imageUrl: 'https://exemplo.com/carta.jpg',
    description: 'Descrição da carta',
  );
}