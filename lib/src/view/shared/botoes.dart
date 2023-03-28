import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import './../../view/shared/view_util_lib.dart';
import './../../infra/infra.dart';

Widget getBotaoTelaGrande(
    {required String texto, required Icon icone, Function? onPressed}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.indigo;
          }
          return Constantes.btnPrimary!;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Constantes
              .btnPrimaryOverlay!; //Colors.black54; // Alterado dia: 02/02/2023
        }),
      ),
      label: Text(texto),
      icon: icone,
      onPressed: onPressed as void Function()?,
    ),
  );
}

Widget getBotaoTelaGrandeTop(
    {required String texto, required Icon icone, Function? onPressed}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.indigo;
          }
          return Constantes.btnSecondary!;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Constantes.btnSecondary!;
        }),
      ),
      label: Text(texto),
      icon: icone,
      onPressed: onPressed as void Function()?,
    ),
  );
}

Widget getBotaoTelaPequena(
    {String? tooltip, required Icon icone, Function? onPressed}) {
  return IconButton(
    focusColor: Colors.indigo,
    color: Constantes.btnPrimary,
    tooltip: tooltip,
    icon: icone,
    onPressed: onPressed as void Function()?,
  );
}

Widget getBotaoFiltro({required BuildContext context, Function? chamarFiltro}) {
  if (Biblioteca.isTelaPequena(context)!) {
    return getBotaoTelaPequena(
        tooltip: Constantes.botaoFiltrarDica,
        icone: ViewUtilLib.getIconBotaoFiltro(),
        onPressed: chamarFiltro);
  } else {
    return getBotaoTelaGrande(
      texto: Constantes.botaoFiltrarDescricao,
      icone: ViewUtilLib.getIconBotaoFiltro(),
      onPressed: chamarFiltro,
    );
  }
}

List<Widget> getBotoesNavigationBarListaPage(
    {required BuildContext context,
    Function? chamarFiltro,
    Function? gerarRelatorio}) {
  if (Biblioteca.isTelaPequena(context)!) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoFiltrarDica,
        icone: ViewUtilLib.getIconBotaoFiltro(),
        onPressed: chamarFiltro,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoImprimirDica,
        icone: ViewUtilLib.getIconBotaoPdf(),
        onPressed: gerarRelatorio,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoFiltrarDescricao,
        icone: ViewUtilLib.getIconBotaoFiltro(),
        onPressed: chamarFiltro,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoImprimirDescricao,
        icone: ViewUtilLib.getIconBotaoPdf(),
        onPressed: gerarRelatorio,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarDetalhePage(
    {required BuildContext context, Function? excluir, Function? alterar}) {
  if (Biblioteca.isTelaPequena(context)!) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoExcluirDica,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoAlterarDica,
        icone: ViewUtilLib.getIconBotaoAlterar(),
        onPressed: alterar,
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
        texto: Constantes.botaoAlterarDescricao,
        icone: ViewUtilLib.getIconBotaoAlterar(),
        onPressed: alterar,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarPersistePage(
    {required BuildContext context, Function? salvar}) {
  if (Biblioteca.isTelaPequena(context)!) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrandeTop(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarPersistePageComExclusao(
    {required BuildContext context, Function? salvar, Function? excluir}) {
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
        onPressed: salvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrandeTop(
        texto: Constantes.botaoExcluirDescricao,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaGrandeTop(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  }
}

MaterialButton getBotaoInternoCaixa(
    {required String texto,
    IconData? icone,
    double? tamanhoIcone,
    Color? corBotao,
    required double paddingAll,
    double? height,
    double? minWidth,
    Function? onPressed}) {
  return MaterialButton(
    height: height ?? 70.0,
    padding: EdgeInsets.all(paddingAll),
    textColor: Colors.white,
    minWidth: minWidth ?? 80,
    color: corBotao,
    elevation: 0,
    onPressed: onPressed as void Function()?,
    child: Column(
      children: <Widget>[
        FaIcon(icone, size: tamanhoIcone),
        Text(
          texto,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}

InkWell getBotaoIncrementaCaixa(
    {Function? incrementar, Color corIcone = Colors.green}) {
  return InkWell(
    onTap: incrementar as void Function()?,
    splashColor: Colors.lightBlue,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          Icons.add,
          color: corIcone,
          size: 20,
        ),
      ),
    ),
  );
}

InkWell getBotaoDecrementaCaixa(
    {Function? decrementar, Color corIcone = Colors.redAccent}) {
  return InkWell(
    onTap: decrementar as void Function()?,
    splashColor: Colors.redAccent.shade200,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          Icons.remove,
          color: corIcone,
          size: 20,
        ),
      ),
    ),
  );
}

ElevatedButton getBotaoGenericoPdv({
  required String descricao,
  Color? cor,
  Function? onPressed,
  EdgeInsetsGeometry? padding,
  Size? tamanho,
  Widget? icon,
  TextStyle? textStyle,
}) {
  return ElevatedButton.icon(
    icon: icon ??
        const SizedBox(
          height: 1,
          width: 1,
        ),
    style: ElevatedButton.styleFrom(
        fixedSize: tamanho,
        backgroundColor: cor,
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        padding: padding,
        textStyle: textStyle),
    onPressed: onPressed as void Function()?,
    label: Text(descricao),
  );
}

ElevatedButton getBotaoIconGenericoPdv({
  Color? cor,
  Function? onPressed,
  EdgeInsetsGeometry? padding,
  required Widget icon,
}) {
  return ElevatedButton.icon(
    icon: icon,
    style: ElevatedButton.styleFrom(
      backgroundColor: cor,
      fixedSize: const Size(5, 5),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: padding,
    ),
    onPressed: onPressed as void Function()?,
    label: const Text(''),
  );
}

Widget getBotaoGenerico(
    {required BuildContext context,
    Function? onPressed,
    required IconData icone,
    required String textOuTip}) {
  if (Biblioteca.isTelaPequena(context)!) {
    return getBotaoTelaPequena(
        tooltip: textOuTip, icone: Icon(icone), onPressed: onPressed);
  } else {
    return getBotaoTelaGrande(
      texto: textOuTip,
      icone: Icon(icone),
      onPressed: onPressed,
    );
  }
}
