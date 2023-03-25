import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/infra/constantes.dart';

gradienteApp() {
  return LinearGradient(
      colors: [
        Constantes.secondaryColor!,
        Constantes.secondaryColorOme!,
      ],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: const [0.0, 1.0],
      tileMode: TileMode.clamp);
}
