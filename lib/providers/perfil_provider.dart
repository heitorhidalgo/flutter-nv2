import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/perfil_model.dart';
import '../notifiers/perfil_notifier.dart';

final AsyncNotifierProvider<PerfilNotifier, PerfilModel> perfilProvider =
    AsyncNotifierProvider<PerfilNotifier, PerfilModel>(PerfilNotifier.new);
