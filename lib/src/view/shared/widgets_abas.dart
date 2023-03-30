import 'package:flutter/material.dart';

import './../../view/shared/gradiente_app.dart';
import './../../view/shared/view_util_lib.dart';
import './../../view/shared/botoes.dart';
import './../../infra/infra.dart';

/// Utilizado para saber se algo foi alterado em qualquer uma das páginas de detalhe
/// para avisar ao usuário que dados serão perdidos caso ele saia da tela/página.
late bool paginaMestreDetalheFoiAlterada;

/// Retorna o ShapeDecoration para a página de abas
ShapeDecoration? getShapeDecorationAbaPage(String estiloBotoesAba) {
  switch (estiloBotoesAba) {
    case 'iconsAndText':
      return ShapeDecoration(
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              side: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ) +
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              side: BorderSide(
                color: Colors.transparent,
                width: 4.0,
              ),
            ),
      );

    case 'iconsOnly':
      return ShapeDecoration(
        shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white24,
                width: 4.0,
              ),
            ) +
            const CircleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 4.0,
              ),
            ),
      );

    case 'textOnly':
      return ShapeDecoration(
        shape: const StadiumBorder(
              side: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ) +
            const StadiumBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 4.0,
              ),
            ),
      );

    default:
      return null;
  }
}

/// Retorna o Scaffold da página de Abas - Página mestre/detalhe
WillPopScope getScaffoldAbaPage(
    String title,
    BuildContext context,
    TabController? controllerAbas,
    List<Aba> abasAtivas,
    Decoration? indicatorTabBar,
    String estiloBotoesAba,
    Function onPressedIconButton,
    Function(String) onSelectedPopupMenuButton,
    Future<bool> Function() onWillPop,
    {bool comBotaoExclusao = false,
    Function? excluir,
    List<Widget>? botoesPersonalizados}) {
  return WillPopScope(
    onWillPop: onWillPop,
    child: Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: (botoesPersonalizados != null)
            ? botoesPersonalizados
            : comBotaoExclusao
                ? _getBotoesAppBarComExclusao(
                    context,
                    onPressedIconButton as dynamic Function(),
                    onSelectedPopupMenuButton,
                    excluir)
                : _getBotoesAppBar(
                    context,
                    onPressedIconButton as dynamic Function(),
                    onSelectedPopupMenuButton),
        bottom: TabBar(
          controller: controllerAbas,
          isScrollable: true,
          indicator: indicatorTabBar,
          tabs: abasAtivas.map<Tab>((Aba aba) {
            switch (estiloBotoesAba) {
              case 'iconsAndText':
                return Tab(text: aba.text, icon: Icon(aba.icon));
              case 'iconsOnly':
                return Tab(icon: Icon(aba.icon));
              case 'textOnly':
                return Tab(text: aba.text);
            }
            return Tab(text: aba.text);
          }).toList(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradienteApp(),
          ),
        ),
      ),
      body: TabBarView(
        controller: controllerAbas,
        children: abasAtivas.map<Widget>((Aba aba) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Container(
              key: ObjectKey(aba.icon),
              padding: const EdgeInsets.all(0.0), //12.0
              child: aba.pagina ??
                  Card(
                    child: Center(
                      child: Icon(
                        aba.icon,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 128.0,
                      ),
                    ),
                  ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

List<Widget> _getBotoesAppBar(
    BuildContext context,
    Function() onPressedBotaoSalvar,
    Function(String) onSelectedPopupMenuButton) {
  if (Biblioteca.isTelaPequena(context)!) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  }
}

List<Widget> _getBotoesAppBarComExclusao(
    BuildContext context,
    Function() onPressedBotaoSalvar,
    Function(String) onSelectedPopupMenuButton,
    Function? excluir) {
  if (Biblioteca.isTelaPequena(context)!) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoExcluirDica,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoExcluirDescricao,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  }
}

/// Classe usada para montar a aba nas páginas mestre/detalhe
class Aba {
  Aba({this.icon, this.text, this.visible, this.pagina});
  IconData? icon;
  String? text;
  bool? visible;
  Widget? pagina;
}
