import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meu_deck_state.dart';
import '../models/yugioh_card_model.dart';

class MeuDeckNotifier extends Notifier<MeuDeckState> {
  static const String _chaveDeck = 'meu_deck';

  @override
  MeuDeckState build() {
    _carregarDeck();
    return const MeuDeckState();
  }

  Future<String?> adicionarCarta(YugiohCardModel carta) async {
    if (state.cartas.length >= 60) {
      return 'deck.limite_maximo'.tr();
    }

    final int copiasNoDeck = state.cartas.where((YugiohCardModel c) => c.name == carta.name).length;
    if (copiasNoDeck >= 3) {
      return 'deck.limite_copias'.tr(
        namedArgs: <String, String>{'nome': carta.name},
      );
    }

    state = state.copyWith(cartas: <YugiohCardModel>[...state.cartas, carta]);
    await _salvarDeck();
    return null;
  }

  Future<void> removerCarta(YugiohCardModel carta) async {
    final List<YugiohCardModel> novaLista = List<YugiohCardModel>.from(
      state.cartas,
    );

    novaLista.remove(carta);
    state = state.copyWith(cartas: novaLista);
    await _salvarDeck();
  }

  Future<void> limpar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveDeck);
    state = state.copyWith(cartas: <YugiohCardModel>[]);
  }

  Future<void> _salvarDeck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listaJson = state.cartas.map((YugiohCardModel carta) {
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
    final List<YugiohCardModel> cartas = listaJson.map((String jsonStr) {
      final Map<String, dynamic> map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return YugiohCardModel(
        id: map['id'],
        name: map['name'],
        type: map['type'],
        imageUrl: map['imageUrl'],
        description: map['description'],
      );
    }).toList();
    state = state.copyWith(cartas: cartas);
  }
}
