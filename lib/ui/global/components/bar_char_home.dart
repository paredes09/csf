import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/controllers/home_controller.dart';

Widget barcharHome() {
  Get.put(HomeController());
  final control = Get.find<HomeController>();
  return BarChart(
    BarChartData(
      barTouchData: barTouchData,
      titlesData: titlesData,
      borderData: borderData,
      barGroups: barGroups,
      gridData: const FlGridData(show: false),

      //alignment: BarChartAlignment.spaceAround,
      maxY: control.ventasPeriodo
              .map((e) => e.cantidad)
              .reduce((value, element) => value > element ? value : element)
              .toDouble() +
          10,
    ),
  );
}

BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 3,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            const TextStyle(
                color: Color.fromARGB(255, 54, 101, 107),
                fontWeight: FontWeight.bold,
                fontSize: 13),
          );
        },
      ),
    );

Widget getTitles(double value, TitleMeta meta) {
  final control = Get.find<HomeController>();
  const style = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w800,
    fontSize: 10,
  );
  const defaultMonths = [
    'ENE',
    'FEB',
    'MAR',
    'ABR',
    'MAY',
    'JUN',
    'JUL',
    'AGO',
    'SEP',
    'OCT',
    'NOV',
    'DIC'
  ];
  int index = value.toInt();
  if (index < 0 || index >= defaultMonths.length) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: const Text('', style: style),
    );
  }
  String text =
      defaultMonths[index]; // Por defecto asignamos el mes de defaultMonths
  for (var venta in control.ventasPeriodo) {
    if (_getMonthIndex(venta.mes) == index) {
      text = venta.mes; // Si el índice coincide, asignamos el mes del control
      break; // Salimos del bucle
    }
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 5,
    child: Text(text, style: style),
  );
}

int? _getMonthIndex(String mes) {
  const monthNames = [
    'ENE',
    'FEB',
    'MAR',
    'ABR',
    'MAY',
    'JUN',
    'JUL',
    'AGO',
    'SEP',
    'OCT',
    'NOV',
    'DIC'
  ];

  final lowerMes = mes.toLowerCase();
  return monthNames.contains(lowerMes) ? monthNames.indexOf(lowerMes) : null;
}

FlTitlesData get titlesData => const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

FlBorderData get borderData => FlBorderData(
      show: false,
    );

LinearGradient get _barsGradient => const LinearGradient(
      colors: [Colors.blueAccent, Colors.cyanAccent],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

List<BarChartGroupData> get barGroups {
  final control = Get.find<HomeController>();
  // Lista de meses en orden
  const defaultMonths = [
    'ENE',
    'FEB',
    'MAR',
    'ABR',
    'MAY',
    'JUN',
    'JUL',
    'AGO',
    'SEP',
    'OCT',
    'NOV',
    'DIC'
  ];

  // Crear un mapa para organizar las cantidades por mes
  final monthData = {for (var mes in defaultMonths) mes: 0.0};
  // Rellenar el mapa con los datos disponibles en ventasPeriodo
  for (var venta in control.ventasPeriodo) {
    if (monthData.containsKey(venta.mes)) {
      monthData[venta.mes] = venta.cantidad.toDouble();
    }
  }
  // Generar las barras en el orden correcto de los meses
  return List.generate(12, (index) {
    final mes = defaultMonths[index];
    final cantidad = monthData[mes] ?? 0.0;
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: cantidad,
          gradient: _barsGradient,
        ),
      ],
      showingTooltipIndicators: [0],
    );
  });
}
