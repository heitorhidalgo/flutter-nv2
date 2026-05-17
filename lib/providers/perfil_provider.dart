import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/perfil_controller.dart';

final ChangeNotifierProvider<PerfilController> perfilProvider =
  ChangeNotifierProvider<PerfilController>((ref) => PerfilController());