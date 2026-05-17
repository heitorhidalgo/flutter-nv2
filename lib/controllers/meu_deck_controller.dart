import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/yugioh_card_model.dart';

class MeuDeckController extends ChangeNotifier {

  static const String _chaveDeck = 'meu_deck';
  final List<YugiohCardModel> _minhasCartas = <YugiohCardModel>[];
  List<YugiohCardModel> get minhasCartas => List.unmodifiable(_minhasCartas);

  Future<void> inicializar() async {
    await _carregarDeck();
  }

  Future<String?> adicionarCarta(YugiohCardModel carta) async {
    if (_minhasCartas.length >= 60) {
      return 'deck.limite_maximo'.tr();
    }

    final int copiasNoDeck = _minhasCartas.where((YugiohCardModel c) => c.name == carta.name).length;

    if (copiasNoDeck >= 3) {
      return 'deck.limite_copias'.tr(
        namedArgs: <String, String>{
          'nome': carta.name,
        },
      );
    }
    _minhasCartas.add(carta);
    await _salvarDeck();
    notifyListeners();
    return null;
  }

  Future<void> removerCarta(YugiohCardModel carta) async {
    _minhasCartas.remove(carta);
    await _salvarDeck();
    notifyListeners();
  }

  Future<void> limpar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveDeck);
    _minhasCartas.clear();
    notifyListeners();
  }

  Future<void> _salvarDeck() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> listaJson = _minhasCartas.map((YugiohCardModel carta) {
        return jsonEncode(
          <String, dynamic>{
            'id': carta.id,
            'name': carta.name,
            'type': carta.type,
            'imageUrl': carta.imageUrl,
            'description': carta.description,
          },
        );
      },
    ).toList();

    await prefs.setStringList(_chaveDeck, listaJson);
  }

  Future<void> _carregarDeck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listaJson = prefs.getStringList(_chaveDeck) ?? <String>[];
    _minhasCartas.clear();
    _minhasCartas.addAll(listaJson.map((String jsonStr) {
          final Map<String, dynamic> map = jsonDecode(jsonStr) as Map<String, dynamic>;
          return YugiohCardModel(
            id: map['id'],
            name: map['name'],
            type: map['type'],
            imageUrl: map['imageUrl'],
            description: map['description'],
          );
        },
      ),
    );
    notifyListeners();
  }
}