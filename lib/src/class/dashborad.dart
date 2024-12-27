import 'package:equatable/equatable.dart';
import 'dart:convert';

List<TablaEstadosClass> tablaEstadosClassFromJson(String str) =>
    List<TablaEstadosClass>.from(
        json.decode(str).map((x) => TablaEstadosClass.fromJson(x)));

String tablaEstadosClassToJson(List<TablaEstadosClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TablaEstadosClass extends Equatable {
  final String nombreEstado;
  final int cantidad;

  const TablaEstadosClass({
    required this.nombreEstado,
    required this.cantidad,
  });

  factory TablaEstadosClass.fromJson(Map<String, dynamic> json) =>
      TablaEstadosClass(
        nombreEstado: json["nombreEstado"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "nombreEstado": nombreEstado,
        "cantidad": cantidad,
      };

  @override
  List<Object?> get props => [nombreEstado, cantidad];
}

List<GraficoVentasMesyAo> graficoVentasMesyAoFromJson(String str) =>
    List<GraficoVentasMesyAo>.from(
        json.decode(str).map((x) => GraficoVentasMesyAo.fromJson(x)));

String graficoVentasMesyAoToJson(List<GraficoVentasMesyAo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GraficoVentasMesyAo extends Equatable {
  final String mes;
  final int cantidad;

  const GraficoVentasMesyAo({
    required this.mes,
    required this.cantidad,
  });

  factory GraficoVentasMesyAo.fromJson(Map<String, dynamic> json) =>
      GraficoVentasMesyAo(
        mes: json["mes"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "mes": mes,
        "cantidad": cantidad,
      };

  @override
  List<Object?> get props => [mes, cantidad];
}
