import 'dart:convert';

import 'package:equatable/equatable.dart';

List<RegisterSalidaClass> registerSalidaClassFromJson(String str) =>
    List<RegisterSalidaClass>.from(
        json.decode(str).map((x) => RegisterSalidaClass.fromJson(x)));

String registerSalidaClassToJson(List<RegisterSalidaClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterSalidaClass extends Equatable {
  final int id;
  final String codigoAtaud;
  final String modeloAtaud;
  final String colorAtaud;
  final String tipoAtaud;
  final String tamanoAtaud;
  final double? precioCompraAtaud;
  final double? precioVentaAtaud;
  final int estadoAtaud;
  final double largoAtaud;
  final String anchoAtaud;
  final String altoAtaud;
  final DateTime fechaIngreso;
  final DateTime? fechaSalida;
  final String fabricanteAtaud;
  final dynamic observaciones;
  final dynamic nombreFallecido;

  const RegisterSalidaClass({
    required this.id,
    required this.codigoAtaud,
    required this.modeloAtaud,
    required this.colorAtaud,
    required this.tipoAtaud,
    required this.tamanoAtaud,
    required this.precioCompraAtaud,
    required this.precioVentaAtaud,
    required this.estadoAtaud,
    required this.largoAtaud,
    required this.anchoAtaud,
    required this.altoAtaud,
    required this.fechaIngreso,
    required this.fechaSalida,
    required this.fabricanteAtaud,
    required this.observaciones,
    required this.nombreFallecido,
  });

  factory RegisterSalidaClass.fromJson(Map<String, dynamic> json) =>
      RegisterSalidaClass(
        id: json["id"],
        codigoAtaud: json["codigoAtaud"],
        modeloAtaud: json["modeloAtaud"],
        colorAtaud: json["colorAtaud"],
        tipoAtaud: json["tipoAtaud"],
        tamanoAtaud: json["tamanoAtaud"],
        precioCompraAtaud: json["precioCompraAtaud"]?.toDouble(),
        precioVentaAtaud: json["precioVentaAtaud"]?.toDouble(),
        estadoAtaud: json["estadoAtaud"],
        largoAtaud: json["largoAtaud"]?.toDouble(),
        anchoAtaud: json["anchoAtaud"],
        altoAtaud: json["altoAtaud"],
        fechaIngreso: DateTime.parse(json["fechaIngreso"]),
        fechaSalida: json["fechaSalida"] != null
            ? DateTime.parse(json["fechaSalida"])
            : null,
        fabricanteAtaud: json["fabricanteAtaud"],
        observaciones: json["observaciones"],
        nombreFallecido: json["nombreFallecido"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigoAtaud": codigoAtaud,
        "modeloAtaud": modeloAtaud,
        "colorAtaud": codigoAtaud,
        "tipoAtaud": tipoAtaud,
        "tamanoAtaud": tamanoAtaud,
        "precioCompraAtaud": precioCompraAtaud,
        "precioVentaAtaud": precioVentaAtaud,
        "estadoAtaud": estadoAtaud,
        "largoAtaud": largoAtaud,
        "anchoAtaud": anchoAtaud,
        "altoAtaud": altoAtaud,
        "fechaIngreso": fechaIngreso.toIso8601String(),
        "fechaSalida": fechaSalida,
        "fabricanteAtaud": fabricanteAtaud,
        "observaciones": observaciones,
        "nombreFallecido": nombreFallecido,
      };

  @override
  List<Object?> get props => [
        id,
        codigoAtaud,
        modeloAtaud,
        colorAtaud,
        tipoAtaud,
        tamanoAtaud,
        precioCompraAtaud,
        precioVentaAtaud,
        estadoAtaud,
        largoAtaud,
        anchoAtaud,
        altoAtaud,
        fechaIngreso,
        fechaSalida,
        fabricanteAtaud,
        observaciones,
        nombreFallecido
      ];
}
