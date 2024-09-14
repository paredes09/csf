import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:csf/src/class/salida_class.dart';
import 'package:csf/src/services/http_services.dart';

class SalidaController extends GetxController {
  final isVisible = false.obs;
  var isLoading = false.obs;
  var listarAtaudes = <RegisterSalidaClass>[].obs;
  var listaFiltrada = <RegisterSalidaClass>[].obs;
  var listaFiltradaSalida = <RegisterSalidaClass>[].obs;
  var searchQuery = ''.obs; // Texto de búsqueda
  var searchQuerySalida = ''.obs; // Texto de búsqueda
  SingleValueDropDownController codigoController =
      SingleValueDropDownController();
  TextEditingController observacionesController = TextEditingController();
  TextEditingController nombreFallecidoController = TextEditingController();
  Rx<DateTime> fechaIngreso = DateTime.now().obs;
  Rx<DateTime> fechaVenta = DateTime.now().obs;
  var idObservacion = false.obs;

  void setFechaIngreso(DateTime fecha) {
    fechaIngreso.value = fecha;
    // Asegurar que la fecha de fin no sea menor que la fecha de inicio
    if (fechaVenta.value.isBefore(fecha)) {
      fechaVenta.value = fecha;
    }
    update();
  }

  void setFechaVenta(DateTime fecha) {
    // Asegurar que la fecha de fin no sea menor que la fecha de inicio
    if (fecha.isBefore(fechaIngreso.value)) {
      fecha = fechaVenta.value;
    }
    fechaVenta.value = fecha;
    update();
  }

  final HttpServices httpServices = HttpServices();
  @override
  void onInit() {
    super.onInit();

    ever(searchQuery, (_) => filtrarAtaudes());
    ever(searchQuerySalida, (_) => filtrarAtaudesSalida());
  }

  @override
  void onClose() {
    searchQuery.value = '';
    searchQuerySalida.value = '';
    super.onClose();
  }

  String? validador(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese el dato solicitado';
    }
    return null;
  }

  Future<void> handlelistarRegistros() async {
    try {
      final listarAtaud = await httpServices.listarRegistros();
      listarAtaudes.assignAll(listarAtaud);
      filtrarAtaudes();
      filtrarAtaudesSalida();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> handleRegistrarSalidaAtaud() async {
    isLoading.value = true;
    try {
      int respuesta = await httpServices.registrarSalidaAtaudes(
          codigoController.dropDownValue?.value,
          nombreFallecidoController.text,
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(fechaVenta.value),
          observacionesController.text);

      if (respuesta == 1) {
        await handlelistarRegistros();
        Get.offAndToNamed('/home');
        codigoController.clearDropDown();
        nombreFallecidoController.clear();
        observacionesController.clear();
        fechaVenta = DateTime.now().obs;
        Get.snackbar(
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            'Producto Vendido',
            'Producto registrado como vendido');
      } else {
        Get.snackbar(
            backgroundColor: Colors.red.shade400,
            colorText: Colors.white,
            'Error',
            'Error al ingresar la venta, intente nuevamente');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al actualizar $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filtrarAtaudes() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      listaFiltrada.value =
          listarAtaudes.where((ataud) => ataud.estadoAtaud == 1).toList();
    } else {
      listaFiltrada.value = listarAtaudes
          .where((ataud) =>
              ataud.estadoAtaud == 1 &&
              (ataud.codigoAtaud.toLowerCase().contains(query) ||
                  ataud.modeloAtaud.toLowerCase().contains(query) ||
                  ataud.colorAtaud.toLowerCase().contains(query)))
          .toList();
    }
  }

  void filtrarAtaudesSalida() {
    final query = searchQuerySalida.value.toLowerCase();
    if (query.isEmpty) {
      listaFiltradaSalida.value =
          listarAtaudes.where((ataud) => ataud.estadoAtaud == 2).toList();
    } else {
      listaFiltradaSalida.value = listarAtaudes
          .where((ataud) =>
              ataud.estadoAtaud == 2 &&
              (ataud.codigoAtaud.toLowerCase().contains(query) ||
                  ataud.modeloAtaud.toLowerCase().contains(query) ||
                  ataud.nombreFallecido.toLowerCase().contains(query)))
          .toList();
    }
  }
}
