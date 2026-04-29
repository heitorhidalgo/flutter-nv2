import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/curiosidades_model.dart';

class CuriosidadesController extends ChangeNotifier {
  List<CuriosidadesModel> get listaCuriosidades => [
    CuriosidadesModel(
      titulo: 'curiosidades.manga_titulo'.tr(),
      descricao: 'curiosidades.manga_descricao'.tr(),
      icone: Icons.menu_book,
      imagem: 'assets/curiosidades/manga.png',
    ),
    CuriosidadesModel(
      titulo: 'curiosidades.anime_titulo'.tr(),
      descricao: 'curiosidades.anime_descricao'.tr(),
      icone: Icons.live_tv,
      imagem: 'assets/curiosidades/anime.png',
    ),
    CuriosidadesModel(
      titulo: 'curiosidades.games_titulo'.tr(),
      descricao: 'curiosidades.games_descricao'.tr(),
      icone: Icons.sports_esports,
      imagem: 'assets/curiosidades/game.png',
    ),
    CuriosidadesModel(
      titulo: 'curiosidades.criador_titulo'.tr(),
      descricao: 'curiosidades.criador_descricao'.tr(),
      icone: Icons.draw,
      imagem: 'assets/curiosidades/autor.png',
    ),
    CuriosidadesModel(
      titulo: 'curiosidades.cartas_titulo'.tr(),
      descricao: 'curiosidades.cartas_descricao'.tr(),
      icone: Icons.style,
      imagem: 'assets/curiosidades/raras.png',
    ),
  ];
}