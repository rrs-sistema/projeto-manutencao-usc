import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/infra/infra.dart';

InputDecoration getInputDecoration(
    String hintText, String labelText, bool aplicaPadding,
    {double? paddingVertical,
    double? paddingHorizontal,
    TextStyle? labelStyle,
    TextStyle? labelStyleHint,
    Color? cor,
    bool? erroSeVazio}) {
  return InputDecoration(
    errorText: erroSeVazio ?? false
        ? ('Por favor, informe o conteúdo desse campo')
        : null,
    fillColor: cor,
    border: const UnderlineInputBorder(),
    hintText: hintText,
    labelText: labelText,
    labelStyle: labelStyle,
    hintStyle: labelStyleHint,
    filled: true,
    contentPadding: aplicaPadding
        ? EdgeInsets.symmetric(
            vertical: paddingVertical ?? 5,
            horizontal: paddingHorizontal ?? 10,
          )
        : null,
  );
}

/// Retorna um DropdownButton
DropdownButtonFormField<String> getDropDownButton(
    String? value, Function(String?) onChanged, List<String> items,
    {Function(String)? validator}) {
  return DropdownButtonFormField<String>(
    isExpanded: true,
    value: value,
    onChanged: onChanged,
    dropdownColor: Constantes.primaryColor,
    validator: validator as String? Function(String?)?,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }).toList(),
  );
}
