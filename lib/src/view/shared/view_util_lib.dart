import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manutencao_usc/src/infra/infra.dart';

class ViewUtilLib {
  /// singleton
  factory ViewUtilLib() {
    _this ??= ViewUtilLib._();
    return _this!;
  }
  static ViewUtilLib? _this;
  ViewUtilLib._() : super();

// #region Ícones
  static Icon getIconBotaoExcluir() {
    return const Icon(Icons.delete, color: Colors.white);
  }

  static Icon getIconBotaoAlterar() {
    return const Icon(Icons.edit, color: Colors.white);
  }

  static Icon getIconBotaoInserir() {
    return const Icon(Icons.add);
  }

  static Icon getIconBotaoFiltro() {
    return const Icon(Icons.filter);
  }

  static Icon getIconBotaoPdf() {
    return const Icon(Icons.picture_as_pdf);
  }

  static Icon getIconBotaoSalvar() {
    return const Icon(Icons.save, color: Colors.white);
  }

  static Icon getIconBotaoLookup() {
    return const Icon(Icons.search);
  }
// #endregion Ícones

// #region Cores
  static Color getBackgroundColorBotaoInserir() {
    return Constantes.secondaryColor!;
  }

  static Color getBotaoFocusColor() {
    return Constantes.secondaryColorOme!;
  }

  static Color getBackgroundColorBarraTelaDetalhe() {
    return Colors.blueGrey;
  }

  static Color getBottomAppBarColor() {
    return Constantes.primaryColor!;
  }

  static Color getBottomAppBarFiltroLocalColor() {
    return Colors.blueGrey.shade200;
  }

  static Color getTextFieldReadOnlyColor() {
    return Colors.amber.shade100;
  }

  static Color getBackgroundColorSnackBarVermelho() {
    return Colors.red.shade900;
  }

  static Color getBackgroundColorSnackBarAzul() {
    return Colors.blue.shade900;
  }

  static Color getBackgroundColorCardValor(num valor) {
    if (valor == 0) {
      return Colors.blue.shade100;
    } else if (valor > 0) {
      return Colors.green.shade100;
    } else {
      return Colors.red.shade100;
    }
  }

  static List<Color> kitGradients = [
    Constantes.primaryColor!,
    Colors.blue.shade900,
  ];

  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];
// #endregion Cores

// #region Padding
  static EdgeInsets paddingBootstrapContainerTelaPequena =
      const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0);
  static EdgeInsets paddingBootstrapContainerTelaGrande =
      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
  static EdgeInsets paddingAbaPersistePage =
      const EdgeInsets.symmetric(horizontal: 16.0);
// #region Padding

  static SliderThemeData sliderThemeData(BuildContext context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: Colors.blue[700],
      inactiveTrackColor: Colors.blue[100],
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
      thumbColor: Colors.blueAccent,
      overlayColor: Colors.blue.withAlpha(32),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      activeTickMarkColor: Colors.blue[700],
      inactiveTickMarkColor: Colors.blue[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: Colors.blueAccent,
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}

/// Controla o Date Picker
// ignore: must_be_immutable
class DatePickerItem extends StatelessWidget {
  DatePickerItem(
      {Key? key,
      DateTime? dateTime,
      required this.onChanged,
      this.firstDate,
      this.lastDate,
      this.mascara,
      this.readOnly})
      : date = dateTime == null
            ? null
            : DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);

  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? mascara;
  DateTime? date;
  final ValueChanged<DateTime?> onChanged;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var hoje = DateTime.now();
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: theme.dividerColor))),
              child: InkWell(
                onDoubleTap: () {
                  onChanged(null);
                },
                onTap: () {
                  if (readOnly == null || readOnly == false) {
                    showDatePicker(
                      context: context,
                      initialDate: date ?? hoje,
                      firstDate: firstDate!,
                      lastDate: lastDate!,
                    ).then<void>((DateTime? value) {
                      if (value != null) {
                        onChanged(DateTime(value.year, value.month, value.day));
                      }
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(date != null
                          ? DateFormat(mascara ?? 'EEE, d / MMM / yyyy')
                              .format(date!)
                          : ''),
                    ),
                    const Expanded(
                      flex: 0,
                      child: Icon(Icons.arrow_drop_down, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
