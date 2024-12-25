import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/inventario_controller.dart';
import 'package:csf/ui/global/components/drow_text.dart';
import 'package:hugeicons/hugeicons.dart';

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
      for (int i = 2024; i <= DateTime.now().year + 5; i++)
        DropDownValueModel(value: i, name: i.toString())
    ];
    int anioActual = DateTime.now().year;
    DropDownValueModel? anioInicial =
        dropDownListaAnios.firstWhere((anio) => anio.value == anioActual);
    controller.anioController.dropDownValue = anioInicial;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 241, 241),
        appBar: AppBar(title: const Text('Generar Reporte Inventario')),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        inputDropDownTextField(null, controller.mesController,
                            (value) {
                          if (value == "") {
                            controller.mesController.clearDropDown();
                          } else if (value is DropDownValueModel) {
                            controller.mesController.dropDownValue = value;
                          }
                        }, (p0) => null, dropDownListaMeses, 'Mes', false),
                        const SizedBox(height: 20),
                        inputDropDownTextField(null, controller.anioController,
                            (value) {
                          if (value == "") {
                            controller.anioController.clearDropDown();
                          } else if (value is DropDownValueModel) {
                            controller.anioController.dropDownValue = value;
                          }
                        }, (p0) => null, dropDownListaAnios, 'Año', false),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          controller.hanfleGenerarReporteD();
                        },
                        child: Ink(
                          height: double.tryParse('70'),
                          width: double.tryParse('70'),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: const HugeIcon(
                              icon: HugeIcons.strokeRoundedSearch01,
                              color: Colors.white),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
