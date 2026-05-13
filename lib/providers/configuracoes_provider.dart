import 'package:flutter_riverpod/legacy.dart';
import '../controllers/configuracoes_controller.dart';

final configuracoesProvider =
ChangeNotifierProvider<ConfiguracoesController>((ref) {
  return ConfiguracoesController();
});