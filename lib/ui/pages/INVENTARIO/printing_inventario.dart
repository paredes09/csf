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
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Control Inventarios')),
        body: Column(
          children: [
            Expanded(
              child: PdfPreview(
                  //useActions: false,
                  allowPrinting: true,
                  allowSharing: true,
                  maxPageWidth: 400,
                  canChangePageFormat: false,
                  canChangeOrientation: false,
                  canDebug: false,
                  scrollViewDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  pdfPreviewPageDecoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    ),
                    color: Colors.white,
                  ),
                  actionBarTheme: const PdfActionBarTheme(
                    backgroundColor: Colors.blue,
                    iconColor: Colors.white,
                  ),
                  build: (format) {
                    // Condición para verificar la ruta y decidir qué función usar
                    if (previus == '/reporteInventario') {
                      return controller
                          .generarReportePDF(); // Si viene de '/reporteInventario'
                    } else {
                      return controller
                          .generarPDF(); // Si viene de cualquier otra ruta
                    }
                  }),
            ),
          ],
        ));
  }
}
