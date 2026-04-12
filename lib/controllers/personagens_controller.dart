import 'package:flutter/material.dart';
import '../models/personagem_model.dart';

class PersonagensController extends ChangeNotifier {
  final List<PersonagemModel> listaPersonagens = [
    PersonagemModel(
      id: 1,
      nome: 'Yugi Muto',
      descricao: 'O protagonista da série. Um garoto gentil que, ao montar o Enigma do Milênio, passou a compartilhar seu corpo com o espírito de um antigo Faraó. Seu monstro ás é o lendário Mago Negro.',
      imagem: 'assets/personagens/yugi.jpg',
    ),
    PersonagemModel(
      id: 2,
      nome: 'Seto Kaiba',
      descricao: 'O eterno rival de Yugi e o brilhante presidente da KaibaCorp. Arrogante, bilionário e implacável nos duelos, sua estratégia gira em torno do poderoso Dragão Branco de Olhos Azuis.',
      imagem: 'assets/personagens/kaiba.jpg',
    ),
    PersonagemModel(
      id: 3,
      nome: 'Joey Wheeler',
      descricao: 'O melhor amigo de Yugi. Um duelista passional e corajoso que confia muito na sorte e no "coração das cartas". Seu monstro favorito é o Dragão Negro de Olhos Vermelhos.',
      imagem: 'assets/personagens/joey.jpg',
    ),
    PersonagemModel(
      id: 4,
      nome: 'Mai Valentine',
      descricao: 'Uma duelista profissional e independente. Inicialmente fútil, ela se torna uma grande aliada do grupo. Utiliza o gracioso e letal deck de Lady Harpia.',
      imagem: 'assets/personagens/mai.jpg',
    ),
  ];
}