import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';

AlertDialog showDialogFecha(String texto, DateTime fecha, Function onAccept) {
  Get.find<RegistroController>();
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    title: Text(texto),
    content: SizedBox(
        height: 230,
        width: 320,
        child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.single,
            ),
            value: [fecha],
            onValueChanged: (value) {
              onAccept(value[0]);
            })),
  );
}
