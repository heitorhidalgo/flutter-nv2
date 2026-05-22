import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/configuracoes_state.dart';
import '../notifiers/configuracoes_notifier.dart';

final NotifierProvider<ConfiguracoesNotifier, ConfiguracoesState>configuracoesProvider =
    NotifierProvider<ConfiguracoesNotifier, ConfiguracoesState>(ConfiguracoesNotifier.new);