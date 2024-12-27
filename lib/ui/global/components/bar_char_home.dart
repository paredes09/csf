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
  String text;

  switch (value.toInt()) {
    case 0:
      text = control.ventasPeriodo[0].mes;
      break;
    case 1:
      text = control.ventasPeriodo[1].mes;
      break;
    case 2:
      text = control.ventasPeriodo[2].mes;
      break;
    case 3:
      text = control.ventasPeriodo[3].mes;
      break;
    case 4:
      text = control.ventasPeriodo[4].mes;
      break;
    case 5:
      text = control.ventasPeriodo[5].mes;
      break;
    case 6:
      text = control.ventasPeriodo[6].mes;
      break;
    case 7:
      text = control.ventasPeriodo[7].mes;
      break;
    case 8:
      text = control.ventasPeriodo[8].mes;
      break;
    case 9:
      text = control.ventasPeriodo[9].mes;
      break;
    case 10:
      text = control.ventasPeriodo[10].mes;
      break;
    case 11:
      text = control.ventasPeriodo[11].mes;
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 5,
    child: Text(text, style: style),
  );
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
  return List.generate(12, (index) {
    double cantidad = control.ventasPeriodo[index].cantidad.toDouble();
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
