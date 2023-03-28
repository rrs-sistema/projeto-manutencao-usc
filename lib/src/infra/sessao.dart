import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import './../database/app_db.dart';
import './../model/model.dart';

class Sessao {
  /// singleton
  factory Sessao() {
    _this ??= Sessao._();
    return _this!;
  }
  static Sessao? _this;
  Sessao._() : super();

  // objeto de erro estático que armazena o último erro ocorrido na aplicação
  static RetornoJsonErro? objetoJsonErro;
  static late String
      retornoJsonLookup; // será usado para popular a grid da janela de lookup

  static String caminhoBancoDados = '';
  static late AppDb db;

  static Future popularObjetosPrincipais(BuildContext context) async {
    db = Provider.of<AppDb>(context, listen: false);
    await db.statusOrdemServicoDao.consultarLista();
  }

  static void fecharDialogBoxEspera(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void tratarErrosSessao(
      BuildContext context, RetornoJsonErro? objetoJsonErro) {
    if (objetoJsonErro != null) {
      Navigator.pop(context);
    }
  }
}
