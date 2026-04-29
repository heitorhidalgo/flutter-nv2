import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/personagem_model.dart';

class PersonagensController extends ChangeNotifier {
  List<PersonagemModel> get listaPersonagens => [
    PersonagemModel(
      id: 1,
      nome: 'personagens.yugi_nome'.tr(),
      descricao: 'personagens.yugi_descricao'.tr(),
      imagem: 'assets/personagens/yugi.jpg',
    ),
    PersonagemModel(
      id: 2,
      nome: 'personagens.kaiba_nome'.tr(),
      descricao: 'personagens.kaiba_descricao'.tr(),
      imagem: 'assets/personagens/kaiba.jpg',
    ),
    PersonagemModel(
      id: 3,
      nome: 'personagens.joey_nome'.tr(),
      descricao: 'personagens.joey_descricao'.tr(),
      imagem: 'assets/personagens/joey.jpg',
    ),
    PersonagemModel(
      id: 4,
      nome: 'personagens.mai_nome'.tr(),
      descricao: 'personagens.mai_descricao'.tr(),
      imagem: 'assets/personagens/mai.jpg',
    ),
  ];
}