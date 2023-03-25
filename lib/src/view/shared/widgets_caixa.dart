import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/infra/infra.dart';

Container getItemResumoValor({
  required String descricao,
  required String valor,
  Color? corFundo,
  Color? corStyle,
}) {
  return Container(
    padding:
        const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 3.0),
    child: Card(
      color: corFundo,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text(
              descricao,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: corStyle ?? Colors.black),
            ),
            const SizedBox(
              width: 5,
            ),
            const Spacer(),
            Text(
              valor,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: corStyle ?? Colors.black),
            )
          ],
        ),
      ),
    ),
  );
}

Card getCardValorUnitario(
    {required BuildContext context, double? valorUnitario}) {
  return Card(
    elevation: 0.5,
    child: SizedBox(
      width: Biblioteca.isTelaPequena(context)! ? 60 : 120,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Constantes.formatoDecimalValor.format(valorUnitario),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Biblioteca.isTelaPequena(context)! ? 11.0 : 14.0,
            ),
          )),
    ),
  );
}

Card getCardQuantidade({required BuildContext context, double? quantidade}) {
  return Card(
    child: SizedBox(
      width: Biblioteca.isTelaPequena(context)! ? 50 : 100,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Constantes.formatoDecimalQuantidade.format(quantidade),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Biblioteca.isTelaPequena(context)! ? 11.0 : 14.0,
            ),
          )),
    ),
  );
}

Card getCardValorTotal({required BuildContext context, double? valorTotal}) {
  return Card(
    elevation: 0.5,
    child: SizedBox(
      width: Biblioteca.isTelaPequena(context)! ? 80 : 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Constantes.formatoDecimalValor.format(valorTotal),
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Biblioteca.isTelaPequena(context)! ? 13.0 : 16.0,
          ),
        ),
      ),
    ),
  );
}
