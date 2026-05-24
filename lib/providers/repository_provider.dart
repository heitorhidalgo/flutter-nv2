import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/yugioh_card_repository.dart';

final Provider<YugiohCardRepository> repositoryProvider =
    Provider<YugiohCardRepository>((Ref ref) {
      return YugiohCardRepository();
    });
