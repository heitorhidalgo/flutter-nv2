import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/meu_deck_controller.dart';

final ChangeNotifierProvider<MeuDeckController> meuDeckProvider =
  ChangeNotifierProvider<MeuDeckController>((ref) => MeuDeckController());