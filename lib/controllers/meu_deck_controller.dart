import 'package:flutter/material.dart';
import '../models/yugioh_card_model.dart';

class MeuDeckController extends ChangeNotifier {
  static final MeuDeckController _instancia = MeuDeckController._interno();
  factory MeuDeckController() => _instancia;
  MeuDeckController._interno();

  List<YugiohCardModel> minhasCartas = [];

  void adicionarCarta(YugiohCardModel carta) {
    minhasCartas.add(carta);
    notifyListeners();
  }

  void removerCarta(YugiohCardModel carta) {
    minhasCartas.remove(carta);
    notifyListeners();
  }
}