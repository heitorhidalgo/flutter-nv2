import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/configuracoes_controller.dart';

final ChangeNotifierProvider<ConfiguracoesController> configuracoesProvider =
  ChangeNotifierProvider<ConfiguracoesController>((ref) => ConfiguracoesController());