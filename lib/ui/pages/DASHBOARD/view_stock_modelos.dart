import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:collection/collection.dart';

class ViewStockModeloPage extends GetView<SalidaController> {
  ViewStockModeloPage({super.key});
  final RegistroController controllerR = Get.find<RegistroController>();

  @override
  Widget build(BuildContext context) {
    Get.put(SalidaController());
    var groupedModelos =
        groupBy(controller.listaFiltrada, (e) => e.modeloAtaud);
    var modelosConConteo = groupedModelos.entries.map((entry) {
      return {'modelo': entry.key, 'cantidad': entry.value.length};
    }).toList();
    return Scaffold(
        appBar: AppBar(title: const Text('Stock Modelos')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(color: Colors.grey, width: 1),
                  columnWidths: const {
                    0: FlexColumnWidth(
                        3), // Mayor espacio para la columna de 'Modelo'
                    1: FlexColumnWidth(
                        1), // Menor espacio para la columna de 'Cantidad'
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.blueGrey),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Modelo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Cantidad',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...modelosConConteo.map(
                      (element) => TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                element['modelo'].toString(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                element['cantidad'].toString(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.blueGrey),
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.listaFiltrada.length.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
