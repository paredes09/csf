import 'package:flutter/material.dart';

TextFormField inputText(
    int line,
    bool editable,
    String label,
    TextInputType type,
    Widget? prefixIcon,
    TextEditingController controllerText,
    final String? Function(String?)? validador) {
  return TextFormField(
    maxLines: line,
    textInputAction: TextInputAction.next,
    validator: validador,
    readOnly: editable,
    controller: controllerText,
    cursorColor: Colors.blueGrey.shade200,
    cursorWidth: 0.9,
    keyboardType: type,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    decoration: InputDecoration(
      prefixIconConstraints: const BoxConstraints(maxWidth: 40, minWidth: 40),
      prefixIcon: prefixIcon,
      labelText: label,
      alignLabelWithHint: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
