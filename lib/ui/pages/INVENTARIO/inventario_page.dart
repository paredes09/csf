import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:csf/src/controllers/inventario_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/drow_text.dart';
import 'package:csf/ui/global/components/input_text.dart';

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
        appBar: AppBar(
          title: const Text('Control de Inventario'),
          actions: [
            IconButton(
              icon: const Icon(Icons.dashboard_customize),
              onPressed: () {
                Get.toNamed('/reporteInventario');
              },
            )
          ],
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
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 1000));
                            /* while (true) {
                              var resultado = await Get.to(
                                () => const SimpleBarcodeScannerPage(
                                  appBarTitle: 'Escanear Código',
                                  scanType: ScanType.qr,
                                  isShowFlashIcon: true,
                                  cancelButtonText: 'Cancelar',
                                ),
                              );
                              if (resultado is String) {
                                if (resultado != "-1") {
                                  var codigoExistente = controller
                                      .salidaConrtoller.listaFiltrada
                                      .firstWhereOrNull((element) =>
                                          element.codigoAtaud == resultado);
                                  if (codigoExistente == null) {
                                    Get.snackbar('Error',
                                        'El código no existe en la base de datos',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white);
                                    break;
                                  } else {
                                    controller.agregarCodigoAtaud(
                                        resultado.toString());
                                  }
                                } else {
                                  break;
                                }
                              } else {
                                break; // Sale del bucle si el usuario cancela o si no se puede leer el código
                              }
                            } */
                          },
                          icon: const Icon(
                            Icons.qr_code_scanner_sharp,
                            color: Colors.green,
                            size: 40,
                          ))
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
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(5),
                                title: Text(codigo.codigoAtaud),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Color(0xFFE57373)),
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
          title: const Row(
            children: [
              Text(
                "Responsable:",
              ),
            ],
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
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                child: const Text("Confirmar",
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (formatkey.currentState!.validate()) {
                    controller.handleGuardarInventario(
                        controller.responsableController.text);
                    Get.back();
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
