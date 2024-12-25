import 'package:csf/ui/global/components/bar_char_home.dart';
import 'package:csf/ui/global/components/card_home.dart';
import 'package:csf/ui/global/components/gridview_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/home_controller.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:csf/ui/global/drawer/drawer.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  final Color color = Colors.green;
  @override
  Widget build(BuildContext context) {
    final SalidaController scontroller = Get.find<SalidaController>();
    final RegistroController controllers = Get.find<RegistroController>();
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
      body: Obx(() => controllers.isLoading.value
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
                          'Stock',
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedTaskDaily02,
                              color: Colors.blue.shade600,
                              size: 20.0),
                          '1000',
                          'Und Disponibles'),
                      gridViewHome(() {
                        Get.toNamed('/viewSalida');
                      },
                          'Vendidos',
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedTag01,
                              color: Colors.blue.shade600,
                              size: 20.0),
                          '7500',
                          'Und Vendidas total'),
                      gridViewHome(() {
                        Get.toNamed('/reparaciones');
                      },
                          'Reparación',
                          HugeIcon(
                              icon: HugeIcons.strokeRoundedRepair,
                              color: Colors.blue.shade600,
                              size: 20.0),
                          '15',
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
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 25, left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text('Venta por mes, periodo 2024',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis)),
                                    Spacer(),
                                    Text('Total',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey))
                                  ],
                                ),
                                Text('125',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900))
                              ],
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 1.8,
                            child: barcharHome(),
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
