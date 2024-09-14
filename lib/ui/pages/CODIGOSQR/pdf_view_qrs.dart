import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/qr_controller.dart';
import 'package:printing/printing.dart';

class PdfViewQrPage extends GetView<GenerateQRController> {
  const PdfViewQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: PdfPreview(build: (format) => controller.pdfQR()));
  }
}
