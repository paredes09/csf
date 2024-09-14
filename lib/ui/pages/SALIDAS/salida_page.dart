import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final TextStyle style2 = TextStyle(
        color: Colors.blueGrey.shade800,
        fontWeight: FontWeight.bold,
        fontSize: 12);

    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) {
          controller.codigoController.clearDropDown();
          controller.isVisible.value = false;
        }
      },
      child: Scaffold(
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
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Detalles del producto',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey.shade800,
                                          letterSpacing: 1.5,
                                          wordSpacing: 2.5)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('Modelo'),
                                          titleTextStyle: style,
                                          subtitle: Text(
                                              registroIndex[0].modeloAtaud),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('Fabricante'),
                                          titleTextStyle: style,
                                          subtitle: Text(
                                              registroIndex[0].fabricanteAtaud),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('Tamaño'),
                                          titleTextStyle: style,
                                          subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Largo: ${registroIndex[0].largoAtaud.toString()} MT',
                                                  style: style2,
                                                ),
                                                Text(
                                                  'Ancho: ${registroIndex[0].anchoAtaud.toString()} CM',
                                                  style: style2,
                                                ),
                                                Text(
                                                  'Alto: ${registroIndex[0].altoAtaud.toString()} CM',
                                                  style: style2,
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('Tipo'),
                                          titleTextStyle: style,
                                          subtitle:
                                              Text(registroIndex[0].tipoAtaud),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('Color'),
                                          titleTextStyle: style,
                                          subtitle:
                                              Text(registroIndex[0].colorAtaud),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'Precio de compra',
                                          ),
                                          titleTextStyle: style,
                                          subtitle: Text(registroIndex[0]
                                              .precioCompraAtaud
                                              .toString()),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('Precio de venta'),
                                          titleTextStyle: style,
                                          subtitle: Text(registroIndex[0]
                                              .precioVentaAtaud
                                              .toString()),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: const Text(
                                            'Fecha de ingreso',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          titleTextStyle: style,
                                          subtitle: Text(
                                            DateFormat('dd-MM-yyyy').format(
                                                controller.fechaIngreso.obs
                                                        .value.value =
                                                    registroIndex[0]
                                                        .fechaIngreso),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Fecha Venta',
                                                style: style,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                height: 40,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .calendar_month_sharp),
                                                    const SizedBox(width: 5),
                                                    Obx(() => Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(controller
                                                                  .fechaVenta
                                                                  .value),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
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
                                    height: 20,
                                  ),
                                  inputText(
                                      3,
                                      false,
                                      'Observaciones',
                                      TextInputType.text,
                                      null,
                                      controller.observacionesController,
                                      (p0) => null),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Obx(() => controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : globalButton('Registrar Salida', () {
                                          if (formatkey.currentState!
                                              .validate()) {
                                            controller
                                                .handleRegistrarSalidaAtaud();
                                          }
                                        }))
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
