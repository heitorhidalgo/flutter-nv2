import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<bool> fazerLogin(String email, String senha) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if(email.isEmpty || senha.isEmpty){
      errorMessage = 'Preencha todos os campos para realizar o login';
      isLoading = false;
      notifyListeners();
      return false;
    }

    if(!email.contains('@')){
      errorMessage = 'Por favor, digite um e-mail valido';
      isLoading = false;
      notifyListeners();
      return false;
    }

    if(senha.length < 6){
      errorMessage = 'A senha deve preencher os requisitos';
      isLoading = false;
      notifyListeners();
      return false;
    }

    isLoading = false;
    notifyListeners();
    return true;
  }
}