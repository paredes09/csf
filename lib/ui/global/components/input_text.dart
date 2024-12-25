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
      labelStyle: const TextStyle(color: Colors.grey),
      alignLabelWithHint: true,
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
  );
}
