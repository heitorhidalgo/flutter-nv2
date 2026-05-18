import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regra_model.dart';

final Provider<List<RegraModel>> comoJogarProvider =
Provider<List<RegraModel>>((ref) {
  return <RegraModel>[
    RegraModel(
      titulo: 'como_jogar.objetivo_titulo'.tr(),
      descricao: 'como_jogar.objetivo_descricao'.tr(),
      icone: Icons.gps_fixed,
    ),
    RegraModel(
      titulo: 'como_jogar.campo_titulo'.tr(),
      descricao: 'como_jogar.campo_descricao'.tr(),
      icone: Icons.stadium_outlined,
    ),
    RegraModel(
      titulo: 'como_jogar.fases_titulo'.tr(),
      descricao: 'como_jogar.fases_descricao'.tr(),
      icone: Icons.update,
    ),
    RegraModel(
      titulo: 'como_jogar.monstros_titulo'.tr(),
      descricao: 'como_jogar.monstros_descricao'.tr(),
      icone: Icons.gesture,
    ),
    RegraModel(
      titulo: 'como_jogar.magias_titulo'.tr(),
      descricao: 'como_jogar.magias_descricao'.tr(),
      icone: Icons.storm,
    ),
  ];
});