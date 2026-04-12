import 'package:flutter/material.dart';
import '../models/yugioh_card_model.dart';

class MeuDeckController extends ChangeNotifier {
  static final MeuDeckController _instancia = MeuDeckController._interno();
  factory MeuDeckController() => _instancia;
  MeuDeckController._interno();

  List<YugiohCardModel> minhasCartas = [];

  String? adicionarCarta(YugiohCardModel carta) {
    if (minhasCartas.length >= 60) {
      return 'Seu deck já atingiu o limite máximo de 60 cartas!';
    }

    final copiasNoDeck = minhasCartas.where((c) => c.name == carta.name).length;

    if (copiasNoDeck >= 3) {
      return 'Você já possui 3 cópias de ${carta.name} no deck!';
    }

    minhasCartas.add(carta);
    notifyListeners();
    return null;
  }

  void removerCarta(YugiohCardModel carta) {
    minhasCartas.remove(carta);
    notifyListeners();
  }
}