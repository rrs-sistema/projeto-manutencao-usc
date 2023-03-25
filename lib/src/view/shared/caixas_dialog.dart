import 'package:flutter/material.dart';

showInSnackBar(String value, BuildContext context,
    {Color? corFundo, Color? corTexto, double? fontSize, Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value,
        style: TextStyle(
          fontSize: fontSize ?? 18,
          color: corTexto ?? Colors.white,
        )),
    duration: duration ?? const Duration(seconds: 5),
    backgroundColor: Colors.white,
  ));
}
