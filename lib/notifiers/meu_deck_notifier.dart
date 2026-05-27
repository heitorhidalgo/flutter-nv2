import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meu_deck_state.dart';
import '../models/yugioh_card_model.dart';

class MeuDeckNotifier extends AsyncNotifier<MeuDeckState> {
  static const String _chaveDeck = 'meu_deck';

  @override
  Future<MeuDeckState> build() async {
    return _carregarDeck();
  }

  Future<String?> adicionarCarta(YugiohCardModel carta) async {
    final MeuDeckState atual = state.value!;

    if (atual.cartas.length >= 60) {
      return 'deck.limite_maximo'.tr();
    }

    final int copiasNoDeck = atual.cartas.where((YugiohCardModel c) => c.name == carta.name).length;

    if (copiasNoDeck >= 3) {
      return 'deck.limite_copias'.tr(
        namedArgs: <String, String>{'nome': carta.name},
      );
    }

    state = AsyncData(
      atual.copyWith(cartas: <YugiohCardModel>[...atual.cartas, carta]),
    );
    await _salvarDeck();
    return null;
  }

  Future<void> removerCarta(YugiohCardModel carta) async {
    final MeuDeckState atual = state.value!;
    final List<YugiohCardModel> novaLista = List<YugiohCardModel>.from(
      atual.cartas,
    )..remove(carta);
    state = AsyncData(atual.copyWith(cartas: novaLista));
    await _salvarDeck();
  }

  Future<void> limpar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveDeck);
    state = const AsyncData(MeuDeckState());
  }

  Future<void> _salvarDeck() async {
    final MeuDeckState atual = state.value!;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listaJson = atual.cartas.map((YugiohCardModel carta) {
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

  Future<MeuDeckState> _carregarDeck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listaJson =
        prefs.getStringList(_chaveDeck) ?? <String>[];
    final List<YugiohCardModel> cartas = listaJson.map((String jsonStr) {
      final Map<String, dynamic> map =
          jsonDecode(jsonStr) as Map<String, dynamic>;
      return YugiohCardModel(
        id: map['id'] as int,
        name: map['name'] as String,
        type: map['type'] as String,
        imageUrl: map['imageUrl'] as String,
        description: map['description'] as String,
      );
    }).toList();
    return MeuDeckState(cartas: cartas);
  }
}