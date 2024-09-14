import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/home_controller.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:csf/ui/global/drawer/drawer.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  final Color color = Colors.green;
  @override
  Widget build(BuildContext context) {
    final SalidaController scontroller = Get.find<SalidaController>();
    final RegistroController controllers = Get.find<RegistroController>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.all(0),
                        content: SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 120,
                                child: Center(
                                  child: Image.asset(
                                    'assets/icon.webp',
                                    width: 160,
                                    height: 160,
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
                                      color: Colors.green)),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Aceptar'),
                          )
                        ],
                      );
                    }));
              },
              icon: const Icon(Icons.info_outline_rounded),
            )
          ],
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        drawer: const DrawerPage(),
        body: Obx(() => controllers.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  controller.onRefresh();
                },
                child: ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dashboard',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Column(
                                children: [
                                  Table(
                                    border: TableBorder.all(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromARGB(
                                            255, 255, 254, 254)),
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(1),
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.grey[200],
                                            child: const Text(
                                              'ESTADO',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.grey[200],
                                            child: const Text(
                                              'CANTIDAD',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.grey[200],
                                            child: const Text(
                                              'Disponibles',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.grey[200],
                                            child: Text(
                                              scontroller.listarAtaudes
                                                  .where((ataud) =>
                                                      ataud.estadoAtaud == 1)
                                                  .length
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              color: Colors.grey[200],
                                              child: const Text(
                                                'Vendidos',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              color: Colors.grey[200],
                                              child: Text(
                                                scontroller.listarAtaudes
                                                    .where((ataud) =>
                                                        ataud.estadoAtaud == 2)
                                                    .length
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              color: Colors.grey[200],
                                              child: const Text(
                                                'En reparación',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              color: Colors.grey[200],
                                              child: Text(
                                                scontroller.listarAtaudes
                                                    .where((ataud) =>
                                                        ataud.estadoAtaud == 3)
                                                    .length
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: Colors.green[200],
                        onTap: () {
                          Get.toNamed('/viewStockModelo');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stock por Modelo',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[800]),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: color,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        floatingActionButton: Obx(
          () => controllers.isLoading.value
              ? const SizedBox()
              : ExpandableFab(
                  closeBackgroundColor: Colors.white,
                  closeIcon: Icon(Icons.close, color: color),
                  openIcon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  distance: 60.0,
                  children: [
                    ActionButton(
                      color: color,
                      onPressed: () {
                        controllers.codigoController.clear();
                        Get.toNamed('/register');
                      },
                      icon: const Icon(
                        Icons.inventory_rounded,
                        color: Colors.white,
                      ),
                    ),
                    ActionButton(
                      color: color,
                      onPressed: () {
                        Get.toNamed('/salida');
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ));
  }
}
