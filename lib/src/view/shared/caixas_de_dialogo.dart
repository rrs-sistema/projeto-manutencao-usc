import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/infra/infra.dart';

/// Retorna a dialog box informando que o form foi alterado
Future gerarDialogBoxFormAlterado(BuildContext context,
    {Function? onOkPressed}) async {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      titleTextStyle: const TextStyle(color: Colors.white),
      title: 'Alterações não Concluídas',
      desc: 'Deseja fechar o formulário e perder as alterações?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (onOkPressed != null) {
          onOkPressed();
        }
        Navigator.of(context).pop();
      },
      btnOkColor: Constantes.secondaryColor,
      btnCancelColor: Constantes.primaryColor,
      btnOkText: 'Sim',
      btnCancelText: 'Não',
    ).show();
  } else {
    showDialogDesktop(
        context: context,
        titulo: 'Alterações não Concluídas',
        mensagem: 'Deseja fechar o formulário e perder as alterações?',
        tipo: DialogType.question,
        onOkPressed: () {
          if (onOkPressed != null) {
            onOkPressed();
          }
          Navigator.of(context).pop();
        });
  }
}

/// Retorna um diálogo de exclusão
gerarDialogBoxExclusao(BuildContext context, dynamic Function()? onOkPressed,
    {String? mensagemPersonalizada}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      borderSide: BorderSide(color: Constantes.secondaryColor!, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      titleTextStyle: const TextStyle(color: Colors.white),
      title: 'Exclusão de Registro',
      desc: mensagemPersonalizada ?? 'Deseja excluir esse registro?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: onOkPressed,
      btnOkText: 'Sim',
      btnOkColor: Constantes.secondaryColor,
      btnCancelColor: Constantes.primaryColor,
      btnCancelText: 'Não',
    ).show();
  } else {
    showDialogDesktop(
        context: context,
        titulo: 'Exclusão de Registro',
        mensagem: mensagemPersonalizada ?? 'Deseja excluir esse registro?',
        tipo: DialogType.question,
        onOkPressed: onOkPressed);
  }
}

/// Retorna um diálogo de informação
gerarDialogBoxInformacao(BuildContext context, String mensagem,
    {dynamic Function()? onOkPressed}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      borderSide: BorderSide(color: Constantes.secondaryColor!, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      titleTextStyle: const TextStyle(color: Colors.white),
      title: 'Informação do Sistema',
      desc: mensagem,
      showCloseIcon: true,
      btnOkOnPress: onOkPressed ?? () {},
    ).show();
  } else {
    showDialogDesktop(
        context: context,
        titulo: 'Informação do Sistema',
        mensagem: mensagem,
        tipo: DialogType.info,
        onOkPressed: onOkPressed);
  }
}

/// Retorna um diálogo de confirmação
gerarDialogBoxConfirmacao(
    BuildContext? context, String mensagem, dynamic Function()? onOkPressed,
    {dynamic Function()? onCancelPressed}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context!,
      dialogType: DialogType.question,
      borderSide: BorderSide(color: Constantes.secondaryColor!, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      titleTextStyle: const TextStyle(color: Colors.white),
      title: 'Pergunta do Sistema',
      desc: mensagem,
      showCloseIcon: true,
      btnOkColor: Constantes.secondaryColor,
      btnCancelColor: Constantes.primaryColor,
      btnCancelOnPress: onCancelPressed,
      btnOkOnPress: onOkPressed,
      btnOkText: 'Sim',
      btnCancelText: 'Não',
    ).show();
  } else {
    showDialogDesktop(
        context: context!,
        titulo: 'Pergunta do Sistema',
        mensagem: mensagem,
        tipo: DialogType.question,
        onOkPressed: onOkPressed);
  }
}

/// Retorna um diálogo de informação
gerarDialogBoxErro(BuildContext? context, String mensagem,
    {dynamic Function()? onOkPressed}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context!,
      dialogType: DialogType.error,
      borderSide: const BorderSide(color: Colors.red, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      titleTextStyle: const TextStyle(color: Colors.white),
      title: 'Erro no Sistema',
      desc: mensagem,
      showCloseIcon: true,
      btnOkOnPress: onOkPressed ?? () {},
    ).show();
  } else {
    showDialogDesktop(
        context: context!,
        titulo: 'Erro no Sistema',
        mensagem: mensagem,
        tipo: DialogType.error,
        onOkPressed: onOkPressed);
  }
}

/// exibe uma caixa de diálogo no desktop com possibilidade de focar os botões
showDialogDesktop(
    {required BuildContext context,
    String? titulo,
    String? mensagem,
    DialogType? tipo,
    Function? onOkPressed}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _corpoDialogoDesktop(
            context: context,
            titulo: titulo!,
            mensagem: mensagem,
            tipo: tipo,
            onOkPressed: onOkPressed),
      );
    },
  );
}

_corpoDialogoDesktop(
    {BuildContext? context,
    required String titulo,
    String? mensagem,
    DialogType? tipo,
    Function? onOkPressed}) {
  return Stack(
    children: <Widget>[
      Container(
        width: 400,
        padding:
            const EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
        margin: const EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              titulo,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            tipo == DialogType.error
                ? SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        mensagem!,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Text(
                    mensagem!,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(
              height: 22,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getBotoesRodapeDialogoDesktop(
                          context: context,
                          tipo: tipo,
                          onOkPressed: onOkPressed),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 20,
        right: 20,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 45,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(45)),
            child: _definirImagemDialogo(tipo),
          ),
        ),
      ),
    ],
  );
}

Widget _definirImagemDialogo(DialogType? tipo) {
  switch (tipo) {
    case DialogType.question:
      return Image.asset(Constantes.dialogQuestionIcon);
    case DialogType.info:
      return Image.asset(Constantes.dialogInfoIcon);
    case DialogType.error:
      return Image.asset(Constantes.dialogErrorIcon);
    default:
      return Image.asset(Constantes.dialogInfoIcon);
  }
}

List<Widget> _getBotoesRodapeDialogoDesktop(
    {BuildContext? context, DialogType? tipo, Function? onOkPressed}) {
  List<Widget> listaBotoes = [];

  if (tipo == DialogType.info || tipo == DialogType.error) {
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context!)! ? 130 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            overlayColor: MaterialStateProperty.all<Color>(
                Colors.transparent.withOpacity(0.3)),
          ),
          onPressed: onOkPressed as void Function()? ??
              () {
                Navigator.pop(context);
              },
          child: const Text('OK'),
        ),
      ),
    );
  } else {
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context!)! ? 130 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            overlayColor: MaterialStateProperty.all<Color>(
                Colors.transparent.withOpacity(0.3)),
          ),
          onPressed: onOkPressed == null
              ? () {
                  Navigator.pop(context);
                }
              : () {
                  Navigator.pop(context);
                  onOkPressed.call();
                },
          child: const Text('Sim'),
        ),
      ),
    );
    listaBotoes.add(
      const SizedBox(width: 10.0),
    );
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            overlayColor: MaterialStateProperty.all<Color>(
                Colors.transparent.withOpacity(0.3)),
          ),
          child: const Text('Não'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
  return listaBotoes;
}

/// Mostra uma snackbar com uma mensagem
showInSnackBar(String value, BuildContext context,
    {Color? corFundo, Color? corTexto, double? fontSize, Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value,
        style: TextStyle(
          fontSize: fontSize ?? 18,
          color: corTexto ?? Colors.white,
        )),
    duration: duration ?? const Duration(seconds: 5),
    backgroundColor: corFundo ?? Constantes.btnPrimary,
  ));
}

gerarDialogBoxEspera(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
