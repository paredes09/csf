import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/inventario_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/drow_text.dart';

class ReporteInventarioPage extends GetView<InventarioController> {
  const ReporteInventarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InventarioController());
    // list dinamico meses
    final List<DropDownValueModel> dropDownListaMeses = [
      const DropDownValueModel(value: 1, name: 'Enero'),
      const DropDownValueModel(value: 2, name: 'Febrero'),
      const DropDownValueModel(value: 3, name: 'Marzo'),
      const DropDownValueModel(value: 4, name: 'Abril'),
      const DropDownValueModel(value: 5, name: 'Mayo'),
      const DropDownValueModel(value: 6, name: 'Junio'),
      const DropDownValueModel(value: 7, name: 'Julio'),
      const DropDownValueModel(value: 8, name: 'Agosto'),
      const DropDownValueModel(value: 9, name: 'Setiembre'),
      const DropDownValueModel(value: 10, name: 'Octubre'),
      const DropDownValueModel(value: 11, name: 'Noviembre'),
      const DropDownValueModel(value: 12, name: 'Diciembre'),
    ];

    int mesActual = DateTime.now().month;
    DropDownValueModel? mesInicial =
        dropDownListaMeses.firstWhere((mes) => mes.value == mesActual);
    controller.mesController.dropDownValue = mesInicial;
    controller.currentRoute = Get.currentRoute;
    // list años del año actual mas 5 años
    final List<DropDownValueModel> dropDownListaAnios = [
      for (int i = DateTime.now().year; i <= DateTime.now().year + 5; i++)
        DropDownValueModel(value: i, name: i.toString())
    ];
    int anioActual = DateTime.now().year;
    DropDownValueModel? anioInicial =
        dropDownListaAnios.firstWhere((anio) => anio.value == anioActual);
    controller.anioController.dropDownValue = anioInicial;
    return Scaffold(
        appBar: AppBar(title: const Text('Generar Reporte Inventario')),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/jde-logo.webp', height: 200, width: 200),
              inputDropDownTextField(null, controller.mesController, (value) {
                if (value == "") {
                  controller.mesController.clearDropDown();
                } else if (value is DropDownValueModel) {
                  controller.mesController.dropDownValue = value;
                }
              }, (p0) => null, dropDownListaMeses, 'Meses', false),
              const SizedBox(height: 20),
              inputDropDownTextField(null, controller.anioController, (value) {
                if (value == "") {
                  controller.anioController.clearDropDown();
                } else if (value is DropDownValueModel) {
                  controller.anioController.dropDownValue = value;
                }
              }, (p0) => null, dropDownListaAnios, 'Año', false),
              const SizedBox(height: 20),
              globalButton('Generar Reporte', () {
                controller.hanfleGenerarReporteD();
              }),
            ],
          ),
        )));
  }
}
