import 'package:flutter/material.dart';
import '../models/curiosidades_model.dart';

class CuriosidadesController extends ChangeNotifier {
  final List<CuriosidadesModel> listaCuriosidades = [
    CuriosidadesModel(
      titulo: 'O Mangá Original',
      descricao: 'Lançado em setembro de 1996 na revista Weekly Shōnen Jump, o mangá original teve 343 capítulos compilados em 38 volumes. Curiosamente, os primeiros capítulos focavam em jogos diversos (Shadow Games) e não apenas no jogo de cartas.',
      icone: Icons.menu_book,
    ),
    CuriosidadesModel(
      titulo: 'O Anime e suas Gerações',
      descricao: 'A série principal (Duel Monsters) foi lançada em 2000 e teve 224 episódios. O sucesso foi tanto que gerou diversos spin-offs: GX, 5D\'s, ZEXAL, ARC-V, VRAINS, SEVENS e Go Rush!!, somando mais de 1.000 episódios na franquia.',
      icone: Icons.live_tv,
    ),
    CuriosidadesModel(
      titulo: 'Mundo dos Games',
      descricao: 'Yu-Gi-Oh! é um gigante nos videogames. Títulos clássicos incluem "Forbidden Memories" (PS1). Atualmente, "Duel Links" (Mobile) e "Master Duel" (PC/Consoles) são os simuladores oficiais com milhões de jogadores ativos.',
      icone: Icons.sports_esports,
    ),
    CuriosidadesModel(
      titulo: 'O Criador da Obra',
      descricao: 'Kazuki Takahashi foi o brilhante mangaká por trás da obra. Inicialmente, ele queria escrever um mangá de terror, mas a ideia evoluiu para jogos onde os vilões eram punidos. Takahashi infelizmente faleceu em 2022, mas seu legado é eterno.',
      icone: Icons.draw,
    ),
    CuriosidadesModel(
      titulo: 'As Cartas de Destaque',
      descricao: 'A mais famosa é sem dúvida o "Dragão Branco de Olhos Azuis". A mais utilizada historicamente é o "Pote da Ganância" (tão forte que é banida até hoje). E a carta mais rara é a "Tyler the Great Warrior", que possui apenas 1 cópia impressa no mundo inteiro.',
      icone: Icons.style,
    ),
  ];
}