import 'package:flutter_riverpod/legacy.dart';
import '../controllers/perfil_controller.dart';

final perfilProvider = ChangeNotifierProvider<PerfilController>((ref) {
  return PerfilController();
});