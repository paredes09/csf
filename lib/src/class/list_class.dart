import 'dart:convert';
import 'package:equatable/equatable.dart';

List<ModeloClass> modeloClassFromJson(String str) => List<ModeloClass>.from(
    json.decode(str).map((x) => ModeloClass.fromJson(x)));

String modeloClassToJson(List<ModeloClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModeloClass extends Equatable {
  final int id;
  final String modeloAtaud;

  const ModeloClass({
    required this.id,
    required this.modeloAtaud,
  });

  factory ModeloClass.fromJson(Map<String, dynamic> json) => ModeloClass(
        id: json["id"],
        modeloAtaud: json["modeloAtaud"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modeloAtaud": modeloAtaud,
      };

  @override
  List<Object?> get props => [id, modeloAtaud];
}

List<FabricanteClass> fabricanteClassFromJson(String str) =>
    List<FabricanteClass>.from(
        json.decode(str).map((x) => FabricanteClass.fromJson(x)));

String fabricanteClassToJson(List<FabricanteClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FabricanteClass extends Equatable {
  final int id;
  final String fabricanteAtaud;

  const FabricanteClass({
    required this.id,
    required this.fabricanteAtaud,
  });

  factory FabricanteClass.fromJson(Map<String, dynamic> json) =>
      FabricanteClass(
        id: json["id"],
        fabricanteAtaud: json["fabricanteAtaud"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fabricanteAtaud": fabricanteAtaud,
      };

  @override
  List<Object?> get props => [id, fabricanteAtaud];
}

List<TipoClass> tipoClassFromJson(String str) =>
    List<TipoClass>.from(json.decode(str).map((x) => TipoClass.fromJson(x)));

String tipoClassToJson(List<TipoClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoClass extends Equatable {
  final int id;
  final String tipoAtaud;

  const TipoClass({
    required this.id,
    required this.tipoAtaud,
  });

  factory TipoClass.fromJson(Map<String, dynamic> json) => TipoClass(
        id: json["id"],
        tipoAtaud: json["tipoAtaud"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoAtaud": tipoAtaud,
      };

  @override
  List<Object?> get props => [id, tipoAtaud];
}

List<ColorClass> colorClassFromJson(String str) =>
    List<ColorClass>.from(json.decode(str).map((x) => ColorClass.fromJson(x)));

String colorClassToJson(List<ColorClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColorClass extends Equatable {
  final int id;
  final String colorAtaud;

  const ColorClass({
    required this.id,
    required this.colorAtaud,
  });

  factory ColorClass.fromJson(Map<String, dynamic> json) => ColorClass(
        id: json["id"],
        colorAtaud: json["colorAtaud"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "colorAtaud": colorAtaud,
      };

  @override
  List<Object?> get props => [id, colorAtaud];
}

List<TamanoClass> tamanoClassFromJson(String str) => List<TamanoClass>.from(
    json.decode(str).map((x) => TamanoClass.fromJson(x)));

String tamanoClassToJson(List<TamanoClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TamanoClass extends Equatable {
  final int id;
  final String tamanoAtaud;

  const TamanoClass({
    required this.id,
    required this.tamanoAtaud,
  });

  factory TamanoClass.fromJson(Map<String, dynamic> json) => TamanoClass(
        id: json["id"],
        tamanoAtaud: json["tamanoAtaud"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tamanoAtaud": tamanoAtaud,
      };

  @override
  List<Object?> get props => [id, tamanoAtaud];
}

List<ObservacionesClass> observacionesClassFromJson(String str) =>
    List<ObservacionesClass>.from(
        json.decode(str).map((x) => ObservacionesClass.fromJson(x)));

String observacionesClassToJson(List<ObservacionesClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ObservacionesClass extends Equatable {
  final int id;
  final String detalles;
  final bool estado;

  const ObservacionesClass({
    required this.id,
    required this.detalles,
    required this.estado,
  });

  factory ObservacionesClass.fromJson(Map<String, dynamic> json) =>
      ObservacionesClass(
        id: json["id"],
        detalles: json["detalles"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "detalles": detalles,
        "estado": estado,
      };

  @override
  List<Object?> get props => [id, detalles, estado];
}

List<CodigoAccesoClass> codigoAccesoClassFromJson(String str) =>
    List<CodigoAccesoClass>.from(
        json.decode(str).map((x) => CodigoAccesoClass.fromJson(x)));

String codigoAccesoClassToJson(List<CodigoAccesoClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CodigoAccesoClass extends Equatable {
  final int id;
  final String codigo;

  const CodigoAccesoClass({
    required this.id,
    required this.codigo,
  });

  factory CodigoAccesoClass.fromJson(Map<String, dynamic> json) =>
      CodigoAccesoClass(
        id: json["id"],
        codigo: json["codigo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
      };

  @override
  List<Object?> get props => [id, codigo];
}
