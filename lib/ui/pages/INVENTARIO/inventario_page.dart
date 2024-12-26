import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:csf/src/controllers/inventario_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/drow_text.dart';
import 'package:csf/ui/global/components/input_text.dart';
import 'package:hugeicons/hugeicons.dart';

class InventarioPage extends GetView<InventarioController> {
  InventarioPage({super.key});
  final formatkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Get.put(InventarioController());
    final List<DropDownValueModel> dropDownListaAtaud = controller
        .salidaConrtoller.listarAtaudes
        .where((element) => element.estadoAtaud == 1)
        .map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.codigoAtaud,
        );
      },
    ).toList();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 241, 241),
        appBar: AppBar(
          title: const Text('Inventario'),
        ),
        body: Obx(() => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    left: 25, bottom: 30, right: 25, top: 30),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: inputDropDownTextField(
                              null, controller.codigoController, (value) {
                            if (value == "") {
                              controller.codigoController.clearDropDown();
                            } else if (value is DropDownValueModel) {
                              controller.codigoController.dropDownValue = value;
                              controller.agregarCodigoAtaud(
                                value.name,
                              );
                              controller.codigoController.clearDropDown();
                            }
                          }, (p0) => null, dropDownListaAtaud, 'Codigo Ataud',
                              true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: Obx(
                    () => SizedBox(
                      child: ListView.builder(
                        itemCount: controller.controlInventario.isEmpty
                            ? 0
                            : controller.controlInventario.first.codigos.length,
                        itemBuilder: (context, index) {
                          if (controller.controlInventario.isEmpty) {
                            return const Center(
                                child: Text('No hay datos disponibles.'));
                          }
                          var codigoOrdenado =
                              controller.controlInventario.first.codigos;

                          codigoOrdenado.sort(
                              (a, b) => b.codigoAtaud.compareTo(a.codigoAtaud));

                          var codigo = codigoOrdenado[index];
                          return Card(
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Colors.white,
                            child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                title: Text(
                                  codigo.codigoAtaud,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: IconButton(
                                  icon: const HugeIcon(
                                      icon: HugeIcons.strokeRoundedDelete02,
                                      color: Colors.red),
                                  onPressed: () {
                                    controller.controlInventario.first.codigos
                                        .removeAt(index);
                                    controller.controlInventario.refresh();
                                    controller.guardarInventarioEnCache();
                                  },
                                )),
                          );
                        },
                      ),
                    ),
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      child: globalButton('Guardar Inventario', () {
                    if (controller.controlInventario.first.codigos.isEmpty) {
                      Get.snackbar(
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          'Error',
                          'No hay datos para guardar');
                    } else {
                      showLogoutConfirmationDialog(context, () {});
                    }
                  }))
                ]))));
  }

  void showLogoutConfirmationDialog(
      BuildContext context, Function logoutFunction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          shape:
              ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.white,
          title: const Text(
            "Responsable:",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formatkey,
            child: inputText(
              1,
              false,
              'Nombre del Responsable',
              TextInputType.text,
              null,
              controller.responsableController,
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un nombre';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(
              height: 40,
              width: 130,
              child: globalButton('Confirmar', () {
                if (formatkey.currentState!.validate()) {
                  controller.handleGuardarInventario(
                      controller.responsableController.text);
                  Get.back();
                }
              }),
            )
          ],
        );
      },
    );
  }
}
