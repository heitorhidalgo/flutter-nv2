import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/perfil_model.dart';
import '../notifiers/perfil_notifier.dart';

final NotifierProvider<PerfilNotifier, PerfilModel> perfilProvider =
  NotifierProvider<PerfilNotifier, PerfilModel>(PerfilNotifier.new);