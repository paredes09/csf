import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:csf/src/class/list_class.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:csf/src/services/http_services.dart';

final SalidaController sController = Get.find<SalidaController>();

class RegistroController extends GetxController {
  int id = 0;
  var listaModelosAtaudes = <ModeloClass>[].obs;
  var listaFabricantesAtaudes = <FabricanteClass>[].obs;
  var listaTiposAtaudes = <TipoClass>[].obs;
  var listaColoresAtaudes = <ColorClass>[].obs;
  var listaTamanosAtaudes = <TamanoClass>[].obs;
  var listarObservaciones = <ObservacionesClass>[].obs;
  var listarCodigoAcceso = <CodigoAccesoClass>[].obs;
  TextEditingController codigoController = TextEditingController();
  TextEditingController altoController = TextEditingController();
  TextEditingController anchoController = TextEditingController();
  TextEditingController largoController = TextEditingController();
  TextEditingController precioCompraController = TextEditingController();
  TextEditingController precioVentaController = TextEditingController();
  SingleValueDropDownController tController = SingleValueDropDownController();
  SingleValueDropDownController estadoController =
      SingleValueDropDownController();
  SingleValueDropDownController modeloController =
      SingleValueDropDownController();
  SingleValueDropDownController fabricanteController =
      SingleValueDropDownController();
  SingleValueDropDownController tipoController =
      SingleValueDropDownController();
  SingleValueDropDownController colorController =
      SingleValueDropDownController();

  TextEditingController nombreFallecidoController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();
  TextEditingController obaservEditController = TextEditingController();
  TextEditingController observController = TextEditingController();
  TextEditingController accesoController = TextEditingController();
  RestorableDateTime selectedDate = RestorableDateTime(DateTime.now());
  final HttpServices httpServices = HttpServices();
  Rx<DateTime> fechaIngreso = DateTime.now().obs;
  Rx<DateTime> fechaVenta = DateTime.now().obs;
  var isLoading = true.obs;
  var isVisible = false.obs;
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

  // Texto de búsqueda
  final RxString searchQuery = ''.obs;
  String? validarDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor seleccione una opción';
    }
    return null;
  }

  String? validarCodigo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Codigo requerido';
    }
    return null;
  }

  String? validarObservacion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una observación';
    }
    return null;
  }

  String? validadorRegistro(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese el codigo del ataud';
    }
    return null;
  }

  String? validadorAltoAnchoLargo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido';
    }
    return null;
  }

  Future<void> handleModelosAtaudes() async {
    isLoading.value = true;
    try {
      final listarModelos = await httpServices.listarModelosAtaudes();
      listaModelosAtaudes.assignAll(listarModelos);
    } catch (e) {
      Get.snackbar('Error', 'Error al cargar modelos de ataúdes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleFabricantesAtaudes() async {
    try {
      final listarFabricantes = await httpServices.listarFabricantesAtaudes();
      listaFabricantesAtaudes.assignAll(listarFabricantes);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> handleTiposAtaudes() async {
    try {
      final listarTipos = await httpServices.listarTiposAtaudes();
      listaTiposAtaudes.assignAll(listarTipos);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> handleColoresAtaudes() async {
    try {
      final listarColores = await httpServices.listarColersAtaudes();
      listaColoresAtaudes.assignAll(listarColores);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> hableTamanosAtaudes() async {
    try {
      final listarTamanos = await httpServices.listarTamanosAtaudes();
      listaTamanosAtaudes.assignAll(listarTamanos);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> hableObservaciones() async {
    try {
      final listarObser = await httpServices.listarObservaciones();
      listarObservaciones.assignAll(listarObser);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> hableCodigo() async {
    try {
      final listarC = await httpServices.listarCodigo();
      listarCodigoAcceso.assignAll(listarC);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> handleRegistrarObservacion(bool ind) async {
    isLoading.value = true;
    try {
      int respuesta =
          await httpServices.registrarObservacion(observController.text, ind);
      if (respuesta == 1) {
        await hableObservaciones();
        observController.clear();
        Get.snackbar(
            'Observación Registrada',
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            'Observación registrada con éxito');
        isLoading.value = false;
      } else {
        Get.snackbar(
          backgroundColor: Colors.redAccent.shade400,
          colorText: Colors.white,
          'Error al registrar la observación',
          'La observación ya existe',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al registrar la observación $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleActualizarObservacion(
      int id, String detalles, bool estado) async {
    isLoading.value = true;
    try {
      int respuesta =
          await httpServices.actualizarObservacion(id, detalles, estado);
      if (respuesta == 1) {
        await hableObservaciones();
        observController.clear();
        isLoading.value = false;
      } else {
        Get.snackbar(
          backgroundColor: Colors.redAccent.shade400,
          colorText: Colors.white,
          'Error al registrar la observación',
          'La observación ya existe',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al registrar la observación $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleRegistrarAtaud() async {
    isLoading.value = true;
    try {
      int respuesta = await httpServices.registrarAtaudes(
          modeloController.dropDownValue?.value,
          colorController.dropDownValue?.value,
          tipoController.dropDownValue?.value,
          tController.dropDownValue?.value,
          estadoController.dropDownValue?.value,
          precioCompraController.text.isEmpty
              ? 0
              : double.parse(precioCompraController.text),
          precioVentaController.text.isEmpty
              ? 0
              : double.parse(precioVentaController.text),
          double.parse(largoController.text),
          anchoController.text,
          altoController.text,
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(fechaIngreso.value),
          fabricanteController.dropDownValue?.value);

      if (respuesta == 1) {
        await sController.handlelistarRegistros();
        codigoController.clear();
        modeloController.clearDropDown();
        colorController.clearDropDown();
        tipoController.clearDropDown();
        tController.clearDropDown();
        precioCompraController.clear();
        precioVentaController.clear();
        largoController.clear();
        anchoController.clear();
        altoController.clear();
        fechaIngreso.value = DateTime.now();
        fabricanteController.clearDropDown();
        Get.snackbar(
            'Registro Exitoso',
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            'Producto registrado con éxito');
        isLoading.value = false;
      } else {
        Get.snackbar(
          backgroundColor: Colors.redAccent.shade400,
          colorText: Colors.white,
          'Error al registrar el producto',
          'El codigo ${codigoController.text} ya existe',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al actualizar la incidencia $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleActualizarAtaud() async {
    isLoading.value = true;
    try {
      int respuesta = await httpServices.actualizarAtaudes(
          id,
          modeloController.dropDownValue?.value,
          colorController.dropDownValue?.value,
          tipoController.dropDownValue?.value,
          tController.dropDownValue?.value,
          estadoController.dropDownValue?.value,
          precioCompraController.text.isEmpty
              ? 0
              : double.parse(precioCompraController.text),
          precioVentaController.text.isEmpty
              ? 0
              : double.parse(precioVentaController.text),
          double.parse(largoController.text),
          anchoController.text,
          altoController.text,
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(fechaIngreso.value),
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(fechaVenta.value),
          fabricanteController.dropDownValue?.value,
          estadoController.dropDownValue?.value != 2
              ? ''
              : nombreFallecidoController.text,
          estadoController.dropDownValue?.value != 2
              ? ''
              : observacionesController.text);

      if (respuesta == 1) {
        await sController.handlelistarRegistros();
        Get.offAndToNamed('/home');
        modeloController.clearDropDown();
        colorController.clearDropDown();
        tipoController.clearDropDown();
        tController.clearDropDown();
        precioCompraController.clear();
        precioVentaController.clear();
        largoController.clear();
        anchoController.clear();
        altoController.clear();
        fabricanteController.clearDropDown();
        estadoController.clearDropDown();
        fechaIngreso.value = DateTime.now();
        fechaVenta.value = DateTime.now();
        Get.snackbar(
            'Actualización Exitosa',
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            'Producto actualizado con éxito');
      } else {
        Get.snackbar(
          backgroundColor: Colors.redAccent.shade400,
          colorText: Colors.white,
          'Error al registrar el producto',
          'El codigo ya existe',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al actualizar la incidencia $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setId(int idIncidencia) async {
    final registro = sController.listarAtaudes
        .firstWhere((element) => element.id == idIncidencia);

    id = registro.id;

    modeloController.setDropDown(DropDownValueModel(
        value: listaModelosAtaudes
            .where((element) => element.modeloAtaud == registro.modeloAtaud)
            .first
            .id,
        name: registro.modeloAtaud));
    nombreFallecidoController.text = registro.nombreFallecido.toString();
    observacionesController.text = registro.observaciones.toString();
    precioCompraController.text = registro.precioCompraAtaud.toString();
    precioVentaController.text = registro.precioVentaAtaud.toString();
    largoController.text = registro.largoAtaud.toString();
    anchoController.text = registro.anchoAtaud;
    altoController.text = registro.altoAtaud;
    fechaIngreso.value = registro.fechaIngreso;
    fechaVenta.value = registro.fechaSalida ?? registro.fechaIngreso;
    fabricanteController.setDropDown(DropDownValueModel(
        value: listaFabricantesAtaudes
            .where((element) =>
                element.fabricanteAtaud == registro.fabricanteAtaud)
            .first
            .id,
        name: registro.fabricanteAtaud));
    colorController.setDropDown(DropDownValueModel(
        value: listaColoresAtaudes
            .where((element) => element.colorAtaud == registro.colorAtaud)
            .first
            .id,
        name: registro.colorAtaud));
    tipoController.setDropDown(DropDownValueModel(
        value: listaTiposAtaudes
            .where((element) => element.tipoAtaud == registro.tipoAtaud)
            .first
            .id,
        name: registro.tipoAtaud));
    tController.setDropDown(DropDownValueModel(
        value: listaTamanosAtaudes
            .where((element) => element.tamanoAtaud == registro.tamanoAtaud)
            .first
            .id,
        name: registro.tamanoAtaud));
    estadoController.setDropDown(DropDownValueModel(
      // Cambiar a estadoController
      value: registro.estadoAtaud,
      name: registro.estadoAtaud == 1
          ? 'En Stock'
          : registro.estadoAtaud == 2
              ? 'Vendido'
              : 'Reparación',
    ));
    codigoController.text = registro.codigoAtaud;
    Get.toNamed('/updateRegister');
  }
}
