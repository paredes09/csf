import 'package:flutter/material.dart';

Widget globalButton(String texto, void Function()? onpress) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      style: ButtonStyle(
        // Cambia el color de fondo y otros estilos según el estado del botón
        backgroundColor: onpress != null
            ? WidgetStateProperty.all(Colors.deepPurpleAccent)
            : WidgetStateProperty.all(Colors.grey), // Color desactivado
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: onpress, // Asigna directamente la función al onPressed
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 17,
          color: onpress != null
              ? Colors.white
              : Colors.black87, // Color de texto desactivado
        ),
      ),
    ),
  );
}
