import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/catalogo_state.dart';
import '../notifiers/catalogo_notifier.dart';

final AsyncNotifierProvider<CatalogoNotifier, CatalogoState> catalogoProvider =
  AsyncNotifierProvider<CatalogoNotifier, CatalogoState>(CatalogoNotifier.new);