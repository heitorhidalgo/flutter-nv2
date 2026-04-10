import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  // ------- cores ---------
  static const Color fundoApp = Color(0xFFCFAB6D);
  static const Color textoPrimario = Color(0xFF3B1C0A);
  static const Color textoSecundario = Color(0xFF632C12);
  static const Color corErro = Colors.red;
  static const Color corSucesso = Colors.green;



  // ------- fontes ---------
  static TextStyle fonteTitulo(double tamanhoFonte) {
    return GoogleFonts.cinzel(
        color: textoPrimario,
        fontSize: tamanhoFonte,
        fontWeight: FontWeight.w700
    );
  }

  static TextStyle fonteSubtitulo(double tamanhoFonte) {
    return GoogleFonts.cinzel(
        color: textoSecundario,
        fontSize: tamanhoFonte,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle fonteDescricao(double tamanhoFonte) {
    return GoogleFonts.ebGaramond(
        color: textoPrimario,
        fontSize: tamanhoFonte,
        fontWeight: FontWeight.w300
    );
  }

}