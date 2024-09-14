import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class GenerateQRController extends GetxController {
  final SalidaController salidaConrtoller = Get.put(SalidaController());
  var qrList = <String>[].obs;
  var isLoading = false.obs;
  RxString pdfPath = ''.obs;
  SingleValueDropDownController codigoController =
      SingleValueDropDownController();

  void agregarCodigoParaQr(String codigoAtaud) {
    qrList.add(codigoAtaud);
  }

  Future<Uint8List> pdfQR() async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.GridView(
            padding: const pw.EdgeInsets.all(00),
            crossAxisCount: 5, // Tres columnas
            childAspectRatio: 1.0,

            children: qrList.map((data) {
              return pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.BarcodeWidget(
                      barcode: pw.Barcode.qrCode(),
                      data: data,
                      width: 50,
                      height: 50,
                    ),
                    pw.SizedBox(height: 7), // Espacio entre QR y texto
                    pw.Container(
                        width: 50,
                        child: pw.Text(data,
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 7,
                                fontWeight: pw.FontWeight.bold)))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );

    // Guarda el PDF en el dispositivo (si es necesario)
    final outputFile = await _getOutputFile();
    await outputFile.writeAsBytes(await pdf.save());
    pdfPath.value = outputFile.path;

    // Devuelve los bytes del PDF para la previsualización.
    return pdf.save();
  }

  Future<File> _getOutputFile() async {
    final directory = await getTemporaryDirectory();
    // final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/reportess.pdf';
    return File(path);
  }
}
