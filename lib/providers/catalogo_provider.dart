import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/catalogo_controller.dart';

final ChangeNotifierProvider<CatalogoController> catalogoProvider =
  ChangeNotifierProvider<CatalogoController>((ref) => CatalogoController());