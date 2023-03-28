import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Map<LogicalKeySet, Intent> getAtalhosListaPage() {
  return <LogicalKeySet, Intent>{
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f2)
            : LogicalKeySet(LogicalKeyboardKey.f2):
        const AtalhoTelaIntent.inserir(),
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f8)
            : LogicalKeySet(LogicalKeyboardKey.f8):
        const AtalhoTelaIntent.imprimir(),
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f11)
            : LogicalKeySet(LogicalKeyboardKey.f11):
        const AtalhoTelaIntent.filtrar(),
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f3)
            : LogicalKeySet(LogicalKeyboardKey.f3):
        const AtalhoTelaIntent.cancelar(),
  };
}

Map<LogicalKeySet, Intent> getAtalhosDetalhePage() {
  return <LogicalKeySet, Intent>{
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f3)
            : LogicalKeySet(LogicalKeyboardKey.f3):
        const AtalhoTelaIntent.alterar(),
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f9)
            : LogicalKeySet(LogicalKeyboardKey.f9):
        const AtalhoTelaIntent.excluir(),
  };
}

Map<LogicalKeySet, Intent> getAtalhosPersistePage() {
  return <LogicalKeySet, Intent>{
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f9)
            : LogicalKeySet(LogicalKeyboardKey.f9):
        const AtalhoTelaIntent.excluir(),
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f12)
            : LogicalKeySet(LogicalKeyboardKey.f12):
        const AtalhoTelaIntent.salvar(),
  };
}

Map<LogicalKeySet, Intent> getAtalhosAbaPage() {
  return <LogicalKeySet, Intent>{
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f2)
            : LogicalKeySet(LogicalKeyboardKey.f2):
        const AtalhoTelaIntent.inserir(),
    kIsWeb == true
            ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f12)
            : LogicalKeySet(LogicalKeyboardKey.f12):
        const AtalhoTelaIntent.salvar(),
  };
}

class AtalhoTelaIntent extends Intent {
  const AtalhoTelaIntent({required this.type});

  const AtalhoTelaIntent.inserir() : type = AtalhoTelaType.inserir;

  const AtalhoTelaIntent.alterar() : type = AtalhoTelaType.alterar;

  const AtalhoTelaIntent.imprimir() : type = AtalhoTelaType.imprimir;

  const AtalhoTelaIntent.excluir() : type = AtalhoTelaType.excluir;

  const AtalhoTelaIntent.filtrar() : type = AtalhoTelaType.filtrar;

  const AtalhoTelaIntent.cancelar() : type = AtalhoTelaType.cancelar;

  const AtalhoTelaIntent.salvar() : type = AtalhoTelaType.salvar;

  const AtalhoTelaIntent.escape() : type = AtalhoTelaType.escape;

  final AtalhoTelaType type;
}

enum AtalhoTelaType {
  inserir,
  alterar,
  imprimir,
  excluir,
  filtrar,
  salvar,
  cancelar,
  escape,
}
