import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/drow_text.dart';
import 'package:csf/ui/global/components/input_text.dart';
import 'package:csf/ui/global/components/show_dialog_fecha.dart';

class RegistroPage extends GetView<RegistroController> {
  const RegistroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formatkey = GlobalKey<FormState>();
    final List<DropDownValueModel> dropDownModelos =
        controller.listaModelosAtaudes.map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.modeloAtaud,
        );
      },
    ).toList();
    final List<DropDownValueModel> dropDownfabricantes =
        controller.listaFabricantesAtaudes.map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.fabricanteAtaud,
        );
      },
    ).toList();
    final List<DropDownValueModel> dropDownColor =
        controller.listaColoresAtaudes.map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.colorAtaud,
        );
      },
    ).toList();
    final List<DropDownValueModel> dropDownTipos =
        controller.listaTiposAtaudes.map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.tipoAtaud,
        );
      },
    ).toList();

    final List<DropDownValueModel> dropDownT =
        controller.listaTamanosAtaudes.map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.tamanoAtaud,
        );
      },
    ).toList();
    String model = '';
    String colors = '';
    String tipos = '';
    String ta = '';
    String fabricantes = '';

    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) {
          controller.codigoController.clear();
          controller.modeloController.clearDropDown();
          controller.colorController.clearDropDown();
          controller.tipoController.clearDropDown();
          controller.tController.clearDropDown();
          controller.fabricanteController.clearDropDown();
          controller.largoController.clear();
          controller.anchoController.clear();
          controller.altoController.clear();
          controller.precioCompraController.clear();
          controller.precioVentaController.clear();
          controller.estadoController.clearDropDown();
        }
      },
      child: Scaffold(
          appBar: AppBar(title: const Text('Registrar Ataud')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Form(
              key: formatkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Obx(() => Text(
                                'CORRELATIVO Nº${sController.listarAtaudes.last.id.obs + 1}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.headlineSmall)),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => showDialogFecha(
                                          'Seleccione la fecha de inicio',
                                          controller.fechaIngreso.value,
                                          (value) {
                                        controller.setFechaIngreso(value);
                                      }));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month_sharp),
                                  const SizedBox(width: 5),
                                  Obx(() => Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            controller
                                                .fechaIngreso.obs.value.value),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.modeloController,
                          (value) {
                        if (value == "") {
                          controller.modeloController.clearDropDown();
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.modeloController.setDropDown(value);
                          model =
                              controller.modeloController.dropDownValue?.name ??
                                  '';
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownModelos, 'Modelo',
                          true),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.colorController,
                          (value) {
                        if (value == "") {
                          controller.colorController.clearDropDown();
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.colorController.dropDownValue = value;
                          colors =
                              controller.colorController.dropDownValue?.name ??
                                  '';
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownColor, 'Color',
                          false),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.tipoController,
                          (value) {
                        if (value == "") {
                          controller.tipoController.clearDropDown();
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.tipoController.dropDownValue = value;
                          tipos =
                              controller.tipoController.dropDownValue?.name ??
                                  '';
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownTipos, 'Tipo',
                          false),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.tController,
                          (value) {
                        if (value == "") {
                          controller.tController.clearDropDown();
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.tController.dropDownValue = value;
                          ta = controller.tController.dropDownValue?.name ?? '';
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownT, 'Tamano',
                          false),
                      const SizedBox(height: 20),
                      inputDropDownTextField(
                          null, controller.fabricanteController, (value) {
                        if (value == "") {
                          controller.fabricanteController.clearDropDown();
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.fabricanteController.dropDownValue = value;
                          fabricantes = controller
                                  .fabricanteController.dropDownValue?.name ??
                              '';
                          controller.codigoController.text =
                              '${sController.listarAtaudes.last.id + 1}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownfabricantes,
                          'Fabricante', true),
                      const SizedBox(height: 20),
                      Obx(() {
                        controller.codigoController.text;
                        return inputText(1, true, 'Código', TextInputType.text,
                                null, controller.codigoController, null)
                            .obs
                            .value;
                      }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            child: inputText(
                                1,
                                false,
                                'Largo (mt)',
                                TextInputType.number,
                                null,
                                controller.largoController,
                                controller.validadorAltoAnchoLargo),
                          ),
                          SizedBox(
                            width: 100,
                            child: inputText(
                                1,
                                false,
                                'Ancho (cm)',
                                TextInputType.number,
                                null,
                                controller.anchoController,
                                controller.validadorAltoAnchoLargo),
                          ),
                          SizedBox(
                              width: 100,
                              child: inputText(
                                  1,
                                  false,
                                  'Alto (cm)',
                                  TextInputType.number,
                                  null,
                                  controller.altoController,
                                  controller.validadorAltoAnchoLargo)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: inputText(
                                1,
                                false,
                                'Precio Compra',
                                TextInputType.number,
                                null,
                                controller.precioCompraController,
                                null),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: inputText(
                                1,
                                false,
                                'Precio Venta',
                                TextInputType.number,
                                null,
                                controller.precioVentaController,
                                null),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.estadoController,
                          (value) {
                        if (value == "") {
                          controller.estadoController.clearDropDown();
                        } else if (value is DropDownValueModel) {
                          controller.estadoController.dropDownValue = value;
                        }
                      },
                          controller.validarDropDown,
                          [
                            const DropDownValueModel(
                                value: 1, name: 'En Stock'),
                            const DropDownValueModel(
                                value: 3, name: 'Reparación'),
                          ],
                          'Estado',
                          false),
                      const SizedBox(height: 20),
                      Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : globalButton('Registrar', () {
                              if (formatkey.currentState!.validate()) {
                                controller.handleRegistrarAtaud();
                              }
                            }))
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
