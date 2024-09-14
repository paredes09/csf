import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

DropDownTextField inputDropDownTextField(
    dynamic initialValue,
    SingleValueDropDownController? controlador,
    void Function(dynamic)? onChanged,
    final String? Function(String?)? validador,
    List<DropDownValueModel> estadoItems,
    String label,
    bool shearch) {
  return DropDownTextField(
    initialValue: initialValue,
    clearOption: false,
    searchDecoration: const InputDecoration(
      hintText: 'Buscar',
    ),
    enableSearch: shearch,
    controller: controlador,
    onChanged: onChanged,
    textFieldDecoration: InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    validator: validador,
    dropDownList: estadoItems,
  );
}
