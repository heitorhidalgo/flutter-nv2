import 'package:flutter/material.dart';
import '../models/regra_model.dart';

class ComoJogarController extends ChangeNotifier {
  final List<RegraModel> listaRegras = [
    RegraModel(
      titulo: 'Objetivo do Jogo',
      descricao: 'Cada jogador começa com 8.000 Pontos de Vida (LP). O objetivo principal é reduzir os LP do seu oponente a 0 atacando com seus monstros. Você também vence se o oponente não puder comprar uma carta quando for obrigado a fazê-lo, ou se reunir as 5 partes do lendário "Exodia".',
      icone: Icons.gps_fixed,
    ),
    RegraModel(
      titulo: 'O Campo de Duelo',
      descricao: 'O campo é dividido em zonas principais:\n\n• Zona de Monstros: Onde suas criaturas lutam.\n• Zona de Magias e Armadilhas: Onde ficam seus suportes.\n• Deck e Cemitério: De onde vêm e para onde vão suas cartas.\n• Zona de Campo: Para cartas mágicas de terreno que afetam todo o jogo.',
      icone: Icons.stadium_outlined,
    ),
    RegraModel(
      titulo: 'As Fases do Turno',
      descricao: '1. Draw Phase: Compre 1 carta.\n2. Standby Phase: Resolve efeitos específicos de cartas.\n3. Main Phase 1: Invoque monstros e ative magias/armadilhas.\n4. Battle Phase: Ataque os monstros ou os Pontos de Vida do oponente.\n5. Main Phase 2: Igual à Main Phase 1 (após a batalha).\n6. End Phase: Passa a vez para o oponente.',
      icone: Icons.update,
    ),
    RegraModel(
      titulo: 'Cartas de Monstro',
      descricao: 'Possuem Pontos de Ataque (ATK) e Defesa (DEF). Você pode Invocá-los Normalmente uma vez por turno em Posição de Ataque (em pé) ou baixá-los em Posição de Defesa (deitados e virados para baixo). Monstros Nível 5 ou superior exigem Tributos (sacrificar monstros que já estão no campo).',
      icone: Icons.gesture,
    ),
    RegraModel(
      titulo: 'Magias e Armadilhas',
      descricao: '• Mágicas (Verdes): Ajudam sua estratégia e normalmente são ativadas no seu próprio turno.\n\n• Armadilhas (Rosas): Devem ser baixadas viradas para baixo e só podem ser ativadas a partir do turno do oponente. São perfeitas para arruinar as jogadas adversárias.',
      icone: Icons.storm,
    ),
  ];
}