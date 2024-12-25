import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:hugeicons/hugeicons.dart';

AlertDialog showDialogFecha(String texto, DateTime fecha, Function onAccept) {
  Get.find<RegistroController>();
  return AlertDialog(
    backgroundColor: Colors.grey.shade300,
    shape: Border.all(width: 1, color: Colors.grey.shade300),
    contentPadding: EdgeInsets.zero,
    title: Text(texto,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    content: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
          height: 230,
          width: 320,
          child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                daySplashColor: Colors.transparent,
                monthTextStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
                yearTextStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
                monthBorderRadius: BorderRadius.circular(5),
                yearBorderRadius: BorderRadius.circular(5),
                controlsTextStyle: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700),
                lastMonthIcon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    color: Colors.grey),
                nextMonthIcon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowRight01,
                    color: Colors.grey),
                selectedDayHighlightColor:
                    const Color.fromARGB(255, 255, 193, 78),
                calendarType: CalendarDatePicker2Type.single,
              ),
              value: [fecha],
              onValueChanged: (value) {
                onAccept(value[0]);
              })),
    ),
  );
}
