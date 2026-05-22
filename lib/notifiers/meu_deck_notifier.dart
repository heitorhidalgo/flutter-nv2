import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/yugioh_card_model.dart';

class MeuDeckNotifier extends Notifier<List<YugiohCardModel>> {
  static const String _chaveDeck = 'meu_deck';

  @override
  List<YugiohCardModel> build() {
    _carregarDeck();
    return <YugiohCardModel>[];
  }

  Future<String?> adicionarCarta(YugiohCardModel carta) async {
    if (state.length >= 60) {
      return 'deck.limite_maximo'.tr();
    }

    final int copiasNoDeck = state.where((YugiohCardModel c) => c.name == carta.name).length;
    if (copiasNoDeck >= 3) {
      return 'deck.limite_copias'.tr(
        namedArgs: <String, String>{'nome': carta.name},
      );
    }

    state = <YugiohCardModel>[...state, carta];
    await _salvarDeck();
    return null;
  }

  Future<void> removerCarta(YugiohCardModel carta) async {
    final List<YugiohCardModel> novaLista = List<YugiohCardModel>.from(state);
    novaLista.remove(carta);
    state = novaLista;
    await _salvarDeck();
  }

  Future<void> limpar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveDeck);
    state = <YugiohCardModel>[];
  }

  Future<void> _salvarDeck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listaJson = state.map((YugiohCardModel carta) {
      return jsonEncode(<String, dynamic>{
        'id': carta.id,
        'name': carta.name,
        'type': carta.type,
        'imageUrl': carta.imageUrl,
        'description': carta.description,
      });
    }).toList();
    await prefs.setStringList(_chaveDeck, listaJson);
  }

  Future<void> _carregarDeck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listaJson = prefs.getStringList(_chaveDeck) ?? <String>[];
    state = listaJson.map((String jsonStr) {
      final Map<String, dynamic> map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return YugiohCardModel(
        id: map['id'],
        name: map['name'],
        type: map['type'],
        imageUrl: map['imageUrl'],
        description: map['description'],
      );
    }).toList();
  }
}
