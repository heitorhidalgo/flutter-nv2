import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/yugioh_card_model.dart';
import '../notifiers/meu_deck_notifier.dart';

final NotifierProvider<MeuDeckNotifier, List<YugiohCardModel>> meuDeckProvider =
    NotifierProvider<MeuDeckNotifier, List<YugiohCardModel>>(MeuDeckNotifier.new);
