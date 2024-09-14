import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/drow_text.dart';
import 'package:csf/ui/global/components/input_text.dart';
import 'package:csf/ui/global/components/show_dialog_fecha.dart';

class RegistroUpddatePage extends GetView<RegistroController> {
  RegistroUpddatePage({super.key});
  final formatkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegistroController());

    final List<DropDownValueModel> dropDownModelos =
        controller.listaModelosAtaudes.map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.modeloAtaud,
        );
      },
    ).toList();
    if (controller.estadoController.dropDownValue?.value != 2) {
      controller.isVisible.value = false;
    } else {
      controller.isVisible.value = true;
    }
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
    final TextStyle style = TextStyle(
        color: Colors.blueGrey.shade800,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        fontSize: 15.5,
        wordSpacing: 2.5);
    String codigo = controller.codigoController.text;
    String model = controller.modeloController.dropDownValue!.name;
    String colors = controller.colorController.dropDownValue!.name;
    String tipos = controller.tipoController.dropDownValue!.name;
    String ta = controller.tController.dropDownValue!.name;
    String fabricantes = controller.fabricanteController.dropDownValue!.name;
    controller.codigoController.text =
        '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        controller.codigoController.clear();
        controller.modeloController.clearDropDown();
        controller.largoController.clear();
        controller.anchoController.clear();
        controller.altoController.clear();
        controller.precioCompraController.clear();
        controller.precioVentaController.clear();
        controller.fabricanteController.clearDropDown();
        controller.nombreFallecidoController.clear();
        controller.observacionesController.clear();
        controller.estadoController.clearDropDown();
        controller.tController.clearDropDown();
        controller.tipoController.clearDropDown();
        controller.colorController.clearDropDown();
      },
      child: Scaffold(
          appBar: AppBar(title: const Text('Actualizar Registro')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Form(
              key: formatkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'CORRELATIVO Nº${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.headlineSmall),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.modeloController,
                          (value) {
                        if (value == "") {
                          controller.modeloController.clearDropDown();
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.modeloController.setDropDown(value);
                          model =
                              controller.modeloController.dropDownValue?.name ??
                                  '';
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownModelos, 'Modelo',
                          true),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.colorController,
                          (value) {
                        if (value == "") {
                          controller.colorController.clearDropDown();
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.colorController.dropDownValue = value;
                          colors =
                              controller.colorController.dropDownValue?.name ??
                                  '';
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownColor, 'Color',
                          false),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.tipoController,
                          (value) {
                        if (value == "") {
                          controller.tipoController.clearDropDown();
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.tipoController.dropDownValue = value;
                          tipos =
                              controller.tipoController.dropDownValue?.name ??
                                  '';
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownTipos, 'Tipo',
                          false),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.tController,
                          (value) {
                        if (value == "") {
                          controller.tController.clearDropDown();
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.tController.dropDownValue = value;
                          ta = controller.tController.dropDownValue?.name ?? '';
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
                        }
                      }, controller.validarDropDown, dropDownT, 'Tamano',
                          false),
                      const SizedBox(height: 20),
                      inputDropDownTextField(
                          null, controller.fabricanteController, (value) {
                        if (value == "") {
                          controller.fabricanteController.clearDropDown();
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}';
                        } else if (value is DropDownValueModel) {
                          controller.fabricanteController.dropDownValue = value;
                          fabricantes = controller
                                  .fabricanteController.dropDownValue?.name ??
                              '';
                          controller.codigoController.text =
                              '${codigo.substring(0, 4).replaceAll(RegExp(r'\D'), '')}/${model.isEmpty ? '' : model.substring(0, 3)}/${colors.isEmpty ? '' : colors.substring(0, 3)}/${tipos.isEmpty ? '' : tipos.substring(0, 3)}/${ta.isEmpty ? '' : ta.substring(0, 3)}/${fabricantes.isEmpty ? '' : fabricantes.substring(0, 3)}';
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
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => showDialogFecha(
                                            'Fecha Compra',
                                            controller.fechaIngreso.value,
                                            (value) {
                                          controller.setFechaIngreso(value);
                                        }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fecha Compra',
                                    style: style,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.calendar_month_sharp),
                                        const SizedBox(width: 5),
                                        Obx(() => Text(
                                              DateFormat('dd-MM-yyyy').format(
                                                  controller.fechaIngreso.obs
                                                      .value.value),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(() => controller.isVisible.value
                              ? const SizedBox(width: 10)
                              : const SizedBox()),
                          Obx(() => controller.isVisible.value
                              ? Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => showDialogFecha(
                                                  'Fecha Venta',
                                                  controller.fechaVenta.value,
                                                  (value) {
                                                controller.setFechaVenta(value);
                                              }));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fecha Venta',
                                          style: style,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                  Icons.calendar_month_sharp),
                                              const SizedBox(width: 5),
                                              Obx(() => Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(controller
                                                            .fechaVenta
                                                            .obs
                                                            .value
                                                            .value),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox())
                        ],
                      ),
                      const SizedBox(height: 20),
                      inputDropDownTextField(null, controller.estadoController,
                          (value) {
                        if (value == '') {
                          controller.estadoController.clearDropDown();
                        } else if (value is DropDownValueModel) {
                          controller.estadoController.dropDownValue = value;
                          if (value.value != 2) {
                            controller.isVisible.value = false;
                          } else {
                            controller.isVisible.value = true;
                          }
                        }
                      },
                          controller.validarDropDown,
                          controller.estadoController.dropDownValue?.value != 2
                              ? [
                                  const DropDownValueModel(
                                      value: 1, name: 'En Stock'),
                                  const DropDownValueModel(
                                      value: 3, name: 'Reparación'),
                                ]
                              : [
                                  const DropDownValueModel(
                                      value: 1, name: 'En Stock'),
                                  const DropDownValueModel(
                                      value: 2, name: 'Vendido'),
                                ],
                          'Estado',
                          false),
                      const SizedBox(height: 20),
                      Obx(() => controller.isVisible.value
                          ? Column(
                              children: [
                                inputText(
                                    1,
                                    false,
                                    'Nombre del Fallecido',
                                    TextInputType.text,
                                    null,
                                    controller.nombreFallecidoController,
                                    (p0) => null),
                                const SizedBox(height: 20),
                                inputText(
                                    3,
                                    false,
                                    'Observaciones',
                                    TextInputType.text,
                                    null,
                                    controller.observacionesController,
                                    (p0) => null),
                              ],
                            )
                          : const SizedBox()),
                      const SizedBox(height: 20),
                      Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : globalButton('Actualizar Registro', () {
                              if (formatkey.currentState!.validate()) {
                                showLogoutConfirmationDialog(context, () {
                                  controller.handleActualizarAtaud();
                                });
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

  void showLogoutConfirmationDialog(
      BuildContext context, Function logoutFunction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.password_rounded,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Codigo de Acceso",
              ),
            ],
          ),
          content: inputText(
              1,
              false,
              'Codigo ',
              TextInputType.visiblePassword,
              const Icon(Icons.password),
              controller.accesoController,
              controller.validarCodigo),
          actions: [
            TextButton(
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Get.back();
                controller.accesoController.clear();
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
                  if (controller.listarCodigoAcceso[0].codigo ==
                      controller.accesoController.text) {
                    logoutFunction();
                    Get.back();
                    controller.accesoController.clear();
                  } else {
                    Get.back();
                    controller.accesoController.clear();
                    Get.snackbar('Error', 'Codigo de Acceso Incorrecto');
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
