import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/yugioh_card_model.dart';

class MeuDeckController extends ChangeNotifier {
  static final MeuDeckController _instancia = MeuDeckController._interno();
  factory MeuDeckController() => _instancia;
  MeuDeckController._interno();

  List<YugiohCardModel> minhasCartas = [];

  static const _chaveDeck = 'meu_deck';

  Future<void> inicializar() async {
    await _carregarDeck();
  }

  String? adicionarCarta(YugiohCardModel carta) {
    if (minhasCartas.length >= 60) {
      return 'deck.limite_maximo'.tr();
    }

    final copiasNoDeck = minhasCartas.where((c) => c.name == carta.name).length;

    if (copiasNoDeck >= 3) {
      return 'deck.limite_copias'.tr(namedArgs: {'nome': carta.name});
    }

    minhasCartas.add(carta);
    _salvarDeck();
    notifyListeners();
    return null;
  }

  void removerCarta(YugiohCardModel carta) {
    minhasCartas.remove(carta);
    _salvarDeck();
    notifyListeners();
  }

  Future<void> _salvarDeck() async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = minhasCartas.map((carta) => jsonEncode({
      'id': carta.id,
      'name': carta.name,
      'type': carta.type,
      'imageUrl': carta.imageUrl,
      'description': carta.description,
    })).toList();
    await prefs.setStringList(_chaveDeck, listaJson);
  }

  Future<void> _carregarDeck() async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = prefs.getStringList(_chaveDeck) ?? [];
    minhasCartas = listaJson.map((jsonStr) {
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return YugiohCardModel(
        id: map['id'],
        name: map['name'],
        type: map['type'],
        imageUrl: map['imageUrl'],
        description: map['description'],
      );
    }).toList();
    notifyListeners();
  }
}