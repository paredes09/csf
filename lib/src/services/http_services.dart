// ignore_for_file: file_names

import 'dart:convert';

import 'package:csf/src/class/control_inventario.dart';
import 'package:csf/src/class/list_class.dart';
import 'package:http/http.dart' as http;
import 'package:csf/src/class/salida_class.dart';

class HttpServices {
  // endpoint para obtener la lista de modelos de ataud
  Future<List<ModeloClass>> listarModelosAtaudes() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarModeloAtaud');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ModeloClass.fromJson(data)).toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  Future<List<GenerarReporteClass>> listarRegistroGenerado(
      int mes, int year) async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/GenerarReporte');
    Map<String, String> queryParams = {
      'mes': mes.toString(),
      'año': year.toString()
    };
    var response = await http.get(url.replace(queryParameters: queryParams));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => GenerarReporteClass.fromJson(data))
          .toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  // endpoint para obtener la lista de fabricantes de ataud
  Future<List<FabricanteClass>> listarFabricantesAtaudes() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarFabricanteAtaud');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => FabricanteClass.fromJson(data))
          .toList();
    } else {
      throw Exception('Error al obtener sedes: ${response.statusCode}');
    }
  }

  // endpoint para obtener la lista de tipos de ataud
  Future<List<TipoClass>> listarTiposAtaudes() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarTipoAtaud');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => TipoClass.fromJson(data)).toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  // endpoint para obtener la lista de colores de ataud
  Future<List<ColorClass>> listarColersAtaudes() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarColorAtaud');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ColorClass.fromJson(data)).toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  // endpoint para obtener la lista de tamaños de ataud
  Future<List<TamanoClass>> listarTamanosAtaudes() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarTamanioAtaud');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => TamanoClass.fromJson(data)).toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  Future<List<RegisterSalidaClass>> listarRegistros() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarInventario');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => RegisterSalidaClass.fromJson(data))
          .toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  Future<List<ObservacionesClass>> listarObservaciones() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarObservaciones');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => ObservacionesClass.fromJson(data))
          .toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  Future<List<CodigoAccesoClass>> listarCodigo() async {
    var url = Uri.parse(
        'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/listarCodigo');
    var response = await http.get(Uri.parse(url.toString()));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => CodigoAccesoClass.fromJson(data))
          .toList();
    } else {
      throw Exception('Error al obtener incidencias: ${response.statusCode}');
    }
  }

  Future<int> registrarObservacion(
    String detalles,
    bool estado,
  ) async {
    final response = await http.post(
      Uri.parse(
          'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/registrarObservacion'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'detalles': detalles,
        'estado': estado,
      }),
    );
    if (response.statusCode == 200) {
      return int.parse(
          response.body); // Convertir el cuerpo de la respuesta a entero
    } else {
      throw Exception('Error de inicio de sesión: ${response.statusCode}');
    }
  }

  Future<int> actualizarObservacion(
    int id,
    String detalles,
    bool estado,
  ) async {
    final response = await http.put(
      Uri.parse(
          'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/actualizarObservacion'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'detalles': detalles,
        'estado': estado,
      }),
    );
    if (response.statusCode == 200) {
      return int.parse(
          response.body); // Convertir el cuerpo de la respuesta a entero
    } else {
      throw Exception('Error de inicio de sesión: ${response.statusCode}');
    }
  }

  Future<int> registrarAtaudes(
    int idModelo,
    int idColor,
    int idTipo,
    int idTamano,
    int estadoAtaud,
    double precioCompraAtaud,
    double precioVentaAtaud,
    double largoAtaud,
    String anchoAtaud,
    String altoAtaud,
    String fechaIngreso,
    int idFabricante,
  ) async {
    final response = await http.post(
      Uri.parse(
          'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/registrarInventario'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'idModelo': idModelo,
        'idColor': idColor,
        'idTipo': idTipo,
        'idTamano': idTamano,
        'estadoAtaud': estadoAtaud,
        'precioCompraAtaud': precioCompraAtaud,
        'precioVentaAtaud': precioVentaAtaud,
        'largoAtaud': largoAtaud,
        'anchoAtaud': anchoAtaud,
        'altoAtaud': altoAtaud,
        'fechaIngreso': fechaIngreso,
        'idFabricante': idFabricante
      }),
    );
    if (response.statusCode == 200) {
      return int.parse(
          response.body); // Convertir el cuerpo de la respuesta a entero
    } else {
      throw Exception('Error de inicio de sesión: ${response.statusCode}');
    }
  }

  // actualizar inventario
  Future<int> actualizarAtaudes(
    int id,
    int idModelo,
    int idColor,
    int idTipo,
    int idTamano,
    int estadoAtaud,
    double precioCompraAtaud,
    double precioVentaAtaud,
    double largoAtaud,
    String anchoAtaud,
    String altoAtaud,
    String fechaIngreso,
    String? fechaSalida,
    int idFabricante,
    String? nombreFallecido,
    String? observaciones,
  ) async {
    final response = await http.put(
      Uri.parse(
          'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/ModificarInventario'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'idModelo': idModelo,
        'idColor': idColor,
        'idTipo': idTipo,
        'idTamano': idTamano,
        'estadoAtaud': estadoAtaud,
        'precioCompraAtaud': precioCompraAtaud,
        'precioVentaAtaud': precioVentaAtaud,
        'largoAtaud': largoAtaud,
        'anchoAtaud': anchoAtaud,
        'altoAtaud': altoAtaud,
        'fechaIngreso': fechaIngreso,
        'fechaSalida': fechaSalida,
        'idFabricante': idFabricante,
        'nombreFallecido': nombreFallecido,
        'observaciones': observaciones,
      }),
    );
    if (response.statusCode == 200) {
      return int.parse(
          response.body); // Convertir el cuerpo de la respuesta a entero
    } else {
      throw Exception('Error de inicio de sesión: ${response.statusCode}');
    }
  }

  Future<int> registrarSalidaAtaudes(int id, String nombreFallecido,
      String fechaSalida, String observaciones) async {
    final response = await http.put(
      Uri.parse(
          'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/registrarSalidaInventario'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'nombreFallecido': nombreFallecido,
        'fechaSalida': fechaSalida,
        'observaciones': observaciones,
      }),
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Error de inicio de sesión: ${response.statusCode}');
    }
  }

  Future<int> registarControlInventario(controlsInventario) async {
    final response = await http.post(
      Uri.parse(
          'https://www.jardineshelpdesk.somee.com/api/inventarioAtaudes/ControlInventario'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(controlsInventario), // Convertimos la lista a JSON
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Error de inicio de sesión: ${response.statusCode}');
    }
  }
}
