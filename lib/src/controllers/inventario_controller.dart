import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:csf/src/class/control_inventario.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:csf/src/services/http_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class InventarioController extends GetxController {
  String currentRoute = '';
  final SalidaController salidaConrtoller = Get.put(SalidaController());
  SingleValueDropDownController codigoController =
      SingleValueDropDownController();
  SingleValueDropDownController mesController = SingleValueDropDownController();
  SingleValueDropDownController anioController =
      SingleValueDropDownController();
  TextEditingController responsableController = TextEditingController();
  var controlInventario = <ControlInventarioClass>[].obs;
  var generarReporte = <GenerarReporteClass>[].obs;
  var isLoading = false.obs;
  final GetStorage _storage = GetStorage();
  final String storageKey = 'controlInventario';
  final HttpServices httpServices = HttpServices();
  RxString pdfPath = ''.obs;
  @override
  void onInit() {
    super.onInit();
    cargarInventarioDesdeCache();
  }

  void cargarInventarioDesdeCache() {
    List<dynamic>? jsonData = _storage.read<List<dynamic>>(storageKey);
    if (jsonData != null) {
      controlInventario.value = jsonData
          .map((item) => ControlInventarioClass.fromJson(item))
          .toList();
    }
  }

  void guardarInventarioEnCache() {
    _storage.write(
        storageKey, controlInventario.map((ci) => ci.toJson()).toList());
  }

  void agregarCodigoAtaud(String codigoAtaud) {
    var codigoExistente = salidaConrtoller.listaFiltrada
        .firstWhereOrNull((element) => element.codigoAtaud == codigoAtaud);
    if (codigoExistente != null) {
      ControlInventarioClass? control = controlInventario
          .firstWhereOrNull((ci) => ci.nombreResponsable == "Sin responsable");
      bool codigoExiste = controlInventario.any((ci) =>
          ci.codigos.any((codigo) => codigo.codigoAtaud == codigoAtaud));
      if (control != null) {
        if (codigoExiste) {
          Get.snackbar(
              backgroundColor: Colors.redAccent.shade400,
              colorText: Colors.white,
              'Error',
              'El codigo ingresado ya se encuentra registrado para el inventario');
        } else {
          control.codigos.add(Codigo(codigoAtaud: codigoAtaud));
          controlInventario.refresh();
        }
      } else {
        controlInventario.add(
          ControlInventarioClass(
            nombreResponsable: "Sin responsable",
            codigos: [Codigo(codigoAtaud: codigoAtaud)],
          ),
        );
      }
      // Guardar en cache cada vez que se modifica
      guardarInventarioEnCache();
    } else {
      Get.snackbar(
          backgroundColor: Colors.redAccent.shade400,
          colorText: Colors.white,
          'Error',
          'El código ingresado no existe en el inventario');
    }
  }

  void eliminarCodigo(int index) {
    if (controlInventario.isNotEmpty) {
      controlInventario.first.codigos.removeAt(index);
      controlInventario.refresh();
      guardarInventarioEnCache(); // Actualizar cache después de eliminar
    }
  }

  Future<void> hanfleGenerarReporteD() async {
    isLoading.value = true;
    try {
      final incidencias = await httpServices.listarRegistroGenerado(
        mesController.dropDownValue!.value,
        anioController.dropDownValue!.value,
      );
      generarReporte.assignAll(incidencias);
      if (incidencias.isNotEmpty) {
        await Get.toNamed('/viewPDF', arguments: Get.currentRoute);
      } else {
        Get.snackbar(
            'Error', 'No se encuentan reportes para el mes seleccionado');
      }
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'No se pudo obtener las incidencias');
    }
  }

  Future<void> handleGuardarInventario(String nombre) async {
    isLoading.value = true;
    ControlInventarioClass? control = controlInventario
        .firstWhereOrNull((ci) => ci.nombreResponsable == "Sin responsable");
    controlInventario[0] = ControlInventarioClass(
      nombreResponsable: responsableController.text,
      codigos: control!.codigos,
    );
    controlInventario.refresh();
    try {
      // Guardar en la base de datos
      int respuesta = await httpServices
          .registarControlInventario(controlInventario[0].toJson());
      // Limpiar el controlador
      if (respuesta == 1) {
        await Get.toNamed('/viewPDF', arguments: Get.currentRoute);
        Get.snackbar(
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            'Éxito',
            'Inventario guardado correctamente');
        controlInventario.clear();
        responsableController.clear();
        guardarInventarioEnCache();
      } else {
        ControlInventarioClass? control = controlInventario
            .firstWhereOrNull((ci) => ci.nombreResponsable == nombre);
        controlInventario[0] = ControlInventarioClass(
          nombreResponsable: "Sin responsable",
          codigos: control!.codigos,
        );
        controlInventario.refresh();
        Get.snackbar('Error', 'Error al guardar el inventario');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      ControlInventarioClass? control = controlInventario
          .firstWhereOrNull((ci) => ci.nombreResponsable == nombre);
      controlInventario[0] = ControlInventarioClass(
        nombreResponsable: "Sin responsable",
        codigos: control!.codigos,
      );
      controlInventario.refresh();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Uint8List> generarReportePDF() async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);
    final img = await rootBundle.load('assets/jde-logo.webp');
    final imageBytes = img.buffer.asUint8List();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Control de Inventario',
                        style: pw.TextStyle(
                            font: ttf,
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      height: 50,
                      child: pw.Image(pw.MemoryImage(imageBytes)),
                    )
                  ],
                )),
            pw.Paragraph(
              text:
                  'Responsable: ${generarReporte[0].nombreResponsable.toUpperCase()}',
              style: pw.TextStyle(font: ttf, fontSize: 18),
            ),
            pw.Paragraph(
              text:
                  'Fecha: ${DateFormat('dd/MM/yyyy - HH:MM').format(generarReporte[0].fechaRegistro)}',
              style: pw.TextStyle(font: ttf, fontSize: 18),
            ),
            pw.TableHelper.fromTextArray(
              cellAlignments: {
                0: pw.Alignment.topLeft,
              },
              context: context,
              data: <List<String>>[
                <String>['Codigo de Ataudes Registrados'],
                ...generarReporte.map((codigo) => [codigo.codigoAtaud]),
              ],
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(
                font: ttf,
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
              cellStyle: pw.TextStyle(font: ttf, fontSize: 12),
            ),
            pw.Paragraph(
              text:
                  'Ataúdes contablizados el mes de ${mesController.dropDownValue!.name} : ${generarReporte.length}',
              style: pw.TextStyle(font: ttf, fontSize: 16),
            ),
          ],
        );
      },
    ));
    final outputFile = await _getOutputFile();
    await outputFile.writeAsBytes(await pdf.save());
    pdfPath.value = outputFile.path;
    // Devuelve los bytes del PDF para la previsualización.
    return pdf.save();
  }

  Future<Uint8List> generarPDF() async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);
    final img = await rootBundle.load('assets/jde-logo.webp');
    final imageBytes = img.buffer.asUint8List();
    var ataudesStock = salidaConrtoller.listarAtaudes
        .where((element) => element.estadoAtaud == 1)
        .map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.codigoAtaud,
        );
      },
    ).toList();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Control de Inventario',
                        style: pw.TextStyle(
                            font: ttf,
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      height: 50,
                      child: pw.Image(pw.MemoryImage(imageBytes)),
                    )
                  ],
                )),
            pw.Paragraph(
              text:
                  'Responsable: ${controlInventario[0].nombreResponsable.toUpperCase()}',
              style: pw.TextStyle(font: ttf, fontSize: 18),
            ),
            pw.Paragraph(
              text:
                  'Fecha: ${DateFormat('dd/MM/yyyy - HH:MM').format(DateTime.now())}',
              style: pw.TextStyle(font: ttf, fontSize: 18),
            ),
            pw.TableHelper.fromTextArray(
              cellAlignments: {
                0: pw.Alignment.topLeft,
              },
              context: context,
              data: <List<String>>[
                <String>['Codigo de Ataudes Registrados'],
                ...controlInventario[0]
                    .codigos
                    .map((codigo) => [codigo.codigoAtaud]),
              ],
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(
                font: ttf,
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
              cellStyle: pw.TextStyle(font: ttf, fontSize: 12),
            ),
            pw.Paragraph(
              text:
                  'Ataúdes contablizados: ${controlInventario[0].codigos.length} de ${ataudesStock.length}',
              style: pw.TextStyle(font: ttf, fontSize: 16),
            ),
          ],
        );
      },
    ));

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
