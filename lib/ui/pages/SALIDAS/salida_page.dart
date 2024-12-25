import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/drow_text.dart';
import 'package:csf/ui/global/components/input_text.dart';
import 'package:csf/ui/global/components/show_dialog_fecha.dart';

class SalidaPage extends GetView<SalidaController> {
  const SalidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SalidaController());
    final formatkey = GlobalKey<FormState>();
    final List<DropDownValueModel> dropDownListaAtaud = controller.listarAtaudes
        .where((element) => element.estadoAtaud == 1)
        .map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.codigoAtaud,
        );
      },
    ).toList();

    final TextStyle style = TextStyle(
        color: Colors.blueGrey.shade800,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        fontSize: 15.5,
        wordSpacing: 2.5);

    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) {
          controller.codigoController.clearDropDown();
          controller.isVisible.value = false;
        }
      },
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 242, 241, 241),
          appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (controller.codigoController.dropDownValue?.value == "") {
                    Get.back();
                  } else {
                    controller.codigoController.clearDropDown();
                    controller.isVisible.value = false;
                    Get.back();
                  }
                },
              ),
              title: const Text(
                'Registrar Salida',
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: formatkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: inputDropDownTextField(
                        null, controller.codigoController, (value) {
                      if (value == "") {
                        controller.codigoController.clearDropDown();
                        if (controller.isVisible.value = true) {
                          controller.isVisible.value = false;
                        } else {
                          controller.isVisible.value = false;
                        }
                      } else if (value is DropDownValueModel) {
                        controller.codigoController.dropDownValue = value;
                        controller.isVisible.value = true;
                      }
                    }, (p0) => null, dropDownListaAtaud, 'Codigo Ataud', true),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Obx(() {
                          if (controller.isVisible.value) {
                            var registroIndex = controller.listarAtaudes
                                .where((element) =>
                                    element.id ==
                                    controller
                                        .codigoController.dropDownValue?.value)
                                .toList()
                                .obs;
                            controller.isVisible.value = false;
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(3),
                                    },
                                    border: const TableBorder(
                                      horizontalInside: BorderSide(
                                        color: Colors
                                            .grey, // Color de las líneas entre filas
                                        width: 1, // Ancho de las líneas
                                      ),
                                    ),
                                    children: [
                                      filasColumnas('Modelo',
                                          registroIndex[0].modeloAtaud),
                                      filasColumnas('Fabricante',
                                          registroIndex[0].fabricanteAtaud),
                                      filasColumnas(
                                          'Tipo', registroIndex[0].tipoAtaud),
                                      filasColumnas(
                                          'Color', registroIndex[0].colorAtaud),
                                      filasColumnas('Precio compra',
                                          'S/. ${registroIndex[0].precioCompraAtaud.toString()}0'),
                                      filasColumnas('Precio venta',
                                          'S/. ${registroIndex[0].precioVentaAtaud.toString()}0'),
                                      filasColumnas('Tamaño',
                                          registroIndex[0].tamanoAtaud),
                                      filasColumnas('Dimesiones',
                                          '${registroIndex[0].largoAtaud} | ${registroIndex[0].altoAtaud} | ${registroIndex[0].anchoAtaud}'),
                                      filasColumnas(
                                        'Fecha de compra',
                                        DateFormat('dd-MM-yyyy').format(
                                            controller.fechaIngreso.obs.value
                                                    .value =
                                                registroIndex[0].fechaIngreso),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Fecha Venta',
                                        style: style,
                                      ),
                                      const SizedBox(
                                        width: 37,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  showDialogFecha(
                                                      'Fecha Venta',
                                                      controller.fechaVenta
                                                          .value, (value) {
                                                    controller
                                                        .setFechaVenta(value);
                                                  }));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.transparent),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const HugeIcon(
                                                  icon: HugeIcons
                                                      .strokeRoundedCalendar03,
                                                  color: Colors.black54),
                                              const SizedBox(width: 5),
                                              Obx(() => Text(
                                                    style: const TextStyle(
                                                        color: Colors.black54),
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(controller
                                                            .fechaVenta.value),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  inputText(
                                      1,
                                      false,
                                      'Nombre del Fallecido',
                                      TextInputType.text,
                                      null,
                                      controller.nombreFallecidoController,
                                      controller.validador),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  inputText(
                                      2,
                                      false,
                                      'Observaciones',
                                      TextInputType.text,
                                      null,
                                      controller.observacionesController,
                                      (p0) => null),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() => controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : globalButton('Registrar', () {
                                          if (formatkey.currentState!
                                              .validate()) {
                                            controller
                                                .handleRegistrarSalidaAtaud();
                                          }
                                        })),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

TableRow filasColumnas(String titulo, String detalle) {
  return TableRow(
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            detalle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    ],
  );
}
