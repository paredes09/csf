import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class DrawerPage extends GetView {
  const DrawerPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> iconName = [
      {
        'icon': HugeIcons.strokeRoundedNoteAdd,
        'name': 'Ingreso de Ataudes',
        'route': "/viewRegister"
      },
      {
        'icon': HugeIcons.strokeRoundedTag01,
        'name': 'Salida de Ataudes',
        'route': "/viewSalida"
      },
      {
        'icon': HugeIcons.strokeRoundedRepair,
        'name': 'Reparaciones',
        'route': "/reparaciones"
      },
      {
        'icon': HugeIcons.strokeRoundedNote,
        'name': 'Observaciones',
        'route': "/observaciones"
      },
      {
        'icon': HugeIcons.strokeRoundedAnalytics01,
        'name': 'Generar Reportes',
        'route': "/reporteInventario"
      },
      {
        'icon': HugeIcons.strokeRoundedCheckList,
        'name': 'Inventario',
        'route': "/inventario"
      },
    ];
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView.builder(
        itemCount: iconName.length + 1, // +1 para el DrawerHeader
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 193, 78),
                border: Border(
                  bottom: BorderSide(color: Colors.white54),
                ),
              ),
              height: 160,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('CSF inventory',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900))
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Versión 1.0.0',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Text('Desarrollado por Aroldo Paredes Piñeiros',
                            style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            final item = iconName[index - 1];

            return ListTile(
              leading: HugeIcon(
                icon: item['icon'],
                size: 23.0,
                color: Colors.black87,
              ),
              title: Text(item['name'],
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87)),
              onTap: () {
                if (item['route'] != null) {
                  Get.offAndToNamed(item['route']);
                } else if (item['action'] != null) {
                  item['action']();
                }
              },
            );
          }
        },
      ),
    );
  }
}
