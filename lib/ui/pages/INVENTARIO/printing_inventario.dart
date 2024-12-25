import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/inventario_controller.dart';
import 'package:printing/printing.dart';

class PdfPage extends GetView<InventarioController> {
  const PdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InventarioController());
    final String? previus = Get.arguments;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 241, 241),
        appBar: AppBar(title: const Text('Control Inventario')),
        body: PdfPreview(build: (format) {
          // Condición para verificar la ruta y decidir qué función usar
          if (previus == '/reporteInventario') {
            return controller
                .generarReportePDF(); // Si viene de '/reporteInventario'
          } else {
            return controller.generarPDF(); // Si viene de cualquier otra ruta
          }
        }));
  }
}
