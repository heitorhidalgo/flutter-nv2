import 'package:flutter/material.dart';
import 'package:flutter_nv2/repositories/yugioh_card_repository.dart';
import '../models/api_error.dart';
import '../models/yugioh_card_model.dart';

class YugiohCardController extends ChangeNotifier{
  final YugiohCardRepository _repository;

  YugiohCardController(this._repository);

  List<YugiohCardModel> cartas = [];
  bool isLoading = false;
  ApiError? apiError;

  Future<void> loadCards() async {
    isLoading = true;
    apiError = null;
    notifyListeners();

    try {
      cartas = await _repository.fetchCards();
    } on ApiError catch(e){
      apiError = e;
    }catch(e){
      apiError = ApiError(message: 'Erro inesperado: $e', statusCode: 0);
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}