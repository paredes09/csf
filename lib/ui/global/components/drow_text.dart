import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

DropDownTextField inputDropDownTextField(
  dynamic initialValue,
  SingleValueDropDownController? controlador,
  void Function(dynamic)? onChanged,
  final String? Function(String?)? validador,
  List<DropDownValueModel> estadoItems,
  String label,
  bool shearch,
) {
  return DropDownTextField(
    dropdownRadius: 5,
    listPadding: ListPadding(
      top: 10,
      bottom: 10,
    ),
    listTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
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
      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle:
          WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        final color =
            states.contains(WidgetState.focused) ? Colors.blue : Colors.grey;
        return TextStyle(color: color);
      }),
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    validator: validador,
    dropDownList: estadoItems,
  );
}
