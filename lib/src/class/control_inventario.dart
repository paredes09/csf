import 'dart:convert';

import 'package:equatable/equatable.dart';

ControlInventarioClass controlInventarioClassFromJson(String str) =>
    ControlInventarioClass.fromJson(json.decode(str));

String controlInventarioClassToJson(ControlInventarioClass data) =>
    json.encode(data.toJson());

class ControlInventarioClass extends Equatable {
  final String nombreResponsable;
  final List<Codigo> codigos;

  const ControlInventarioClass({
    required this.nombreResponsable,
    required this.codigos,
  });

  factory ControlInventarioClass.fromJson(Map<String, dynamic> json) =>
      ControlInventarioClass(
        nombreResponsable: json["nombreResponsable"],
        codigos:
            List<Codigo>.from(json["codigos"].map((x) => Codigo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nombreResponsable": nombreResponsable,
        "codigos": List<dynamic>.from(codigos.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Codigo {
  final String codigoAtaud;

  Codigo({
    required this.codigoAtaud,
  });

  factory Codigo.fromJson(Map<String, dynamic> json) => Codigo(
        codigoAtaud: json["codigoAtaud"],
      );

  Map<String, dynamic> toJson() => {
        "codigoAtaud": codigoAtaud,
      };
}

List<GenerarReporteClass> generarReporteClassFromJson(String str) =>
    List<GenerarReporteClass>.from(
        json.decode(str).map((x) => GenerarReporteClass.fromJson(x)));

String generarReporteClassToJson(List<GenerarReporteClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenerarReporteClass extends Equatable {
  final int id;
  final String codigoAtaud;
  final DateTime fechaRegistro;
  final String nombreResponsable;

  const GenerarReporteClass({
    required this.id,
    required this.codigoAtaud,
    required this.fechaRegistro,
    required this.nombreResponsable,
  });

  factory GenerarReporteClass.fromJson(Map<String, dynamic> json) =>
      GenerarReporteClass(
        id: json["id"],
        codigoAtaud: json["codigoAtaud"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        nombreResponsable: json["nombreResponsable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigoAtaud": codigoAtaud,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "nombreResponsable": nombreResponsable,
      };

  @override
  List<Object?> get props =>
      [id, codigoAtaud, fechaRegistro, nombreResponsable];
}
