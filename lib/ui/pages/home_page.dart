import 'package:csf/ui/global/components/bar_char_home.dart';
import 'package:csf/ui/global/components/card_home.dart';
import 'package:csf/ui/global/components/gridview_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/home_controller.dart';
import 'package:csf/ui/global/drawer/drawer.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  final Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    // Lista de años disponibles
    List<int> aos =
        [for (int i = 2024; i <= DateTime.now().year + 2; i++) i].obs;
    // Año seleccionado por defecto
    RxInt aoSeleccionado = DateTime.now().year.obs;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 241, 241),
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      elevation: 10,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      content: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              child: Center(
                                child: Image.asset(
                                  'assets/icon.webp',
                                  width: 180,
                                  height: 180,
                                ),
                              ),
                            ),
                            const Text(
                              'Desarrollado por:',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const Text('Aroldo Paredes Piñeiros',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange)),
                          ],
                        ),
                      ),
                    );
                  }));
            },
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      //floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      drawer: const DrawerPage(),
      body: Obx(() => controller.load.value
          ? const Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Color.fromARGB(255, 255, 193, 78),
            ))
          : RefreshIndicator(
              backgroundColor: Colors.white,
              displacement: 100,
              color: const Color.fromARGB(255, 255, 193, 78),
              onRefresh: () async {
                controller.onRefresh();
              },
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      'Dashboard',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                  ),
                  GridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children: [
                      gridViewHome(() {
                        Get.toNamed('/viewRegister');
                      },
                          controller.tablaEstados[1].nombreEstado,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedTaskDaily02,
                              color: Colors.blue.shade600,
                              size: 20.0),
                          controller.tablaEstados[1].cantidad.toString(),
                          'Und Disponibles'),
                      gridViewHome(() {
                        Get.toNamed('/viewSalida');
                      },
                          controller.tablaEstados[0].nombreEstado,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedTag01,
                              color: Colors.blue.shade600,
                              size: 20.0),
                          controller.tablaEstados[0].cantidad.toString(),
                          'Und Vendidas total'),
                      gridViewHome(() {
                        Get.toNamed('/reparaciones');
                      },
                          controller.tablaEstados[2].nombreEstado,
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedRepair,
                              color: Colors.blue.shade600,
                              size: 20.0),
                          controller.tablaEstados[2].cantidad.toString(),
                          'Und en Reparación'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Fondo blanco
                        borderRadius:
                            BorderRadius.circular(20), // Bordes redondeados
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Text('Venta por mes, periodo ',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis)),
                                    Obx(() {
                                      return DropdownButton<int>(
                                        dropdownColor: Colors.white,
                                        underline: Container(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                        value: aoSeleccionado.value,
                                        onChanged: (int? nuevoAo) {
                                          aoSeleccionado.value = nuevoAo!;
                                          controller.handleListarVentasPeriodo(
                                              aoSeleccionado.value);
                                        },
                                        items: aos.map<DropdownMenuItem<int>>(
                                            (int ao) {
                                          return DropdownMenuItem<int>(
                                            value: ao,
                                            child: Text(ao.toString()),
                                          );
                                        }).toList(),
                                      );
                                    }),
                                    const Spacer(),
                                    const Text('Total',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey))
                                  ],
                                ),
                                Text(
                                    controller.ventasPeriodo.isEmpty
                                        ? '0'
                                        : controller.ventasPeriodo
                                            .map((venta) => venta.cantidad)
                                            .reduce((a, b) => a + b)
                                            .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900))
                              ],
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 1.8,
                            child: controller.loading.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : controller.ventasPeriodo.isEmpty
                                    ? const Center(
                                        child: SizedBox(
                                          width: 180,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'El año seleccionado no tiene ventas registradas',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    : barcharHome(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'GENERAL',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                  ),
                  cardHomeGeneral(() {
                    Get.toNamed('/register');
                  }, HugeIcons.strokeRoundedAddCircleHalfDot, 'Ingresar ataud',
                      'Registrar un nuevo ataud'),
                  cardHomeGeneral(() {
                    Get.toNamed('/salida');
                  }, HugeIcons.strokeRoundedTag01, 'Registrar Salida',
                      'Registrar la salida de un ataud'),
                  cardHomeGeneral(() {
                    Get.toNamed('/viewStockModelo');
                  }, HugeIcons.strokeRoundedTaskDaily02, 'Stock por Modelo',
                      'Ver Stock por Modelo'),
                ],
              ),
            )),
    );
  }
}
