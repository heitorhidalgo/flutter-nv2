import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meu_deck_state.dart';
import '../notifiers/meu_deck_notifier.dart';

final NotifierProvider<MeuDeckNotifier, MeuDeckState> meuDeckProvider =
    NotifierProvider<MeuDeckNotifier, MeuDeckState>(MeuDeckNotifier.new);