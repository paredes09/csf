import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerPage extends GetView {
  const DrawerPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> iconName = [
      {
        'icon': Icons.inventory_outlined,
        'name': 'Ingreso de Ataudes',
        'route': "/viewRegister"
      },
      {
        'icon': Icons.folder_open_rounded,
        'name': 'Salida de Ataudes',
        'route': "/viewSalida"
      },
      {
        'icon': Icons.report_gmailerrorred_rounded,
        'name': 'Reparaciones',
        'route': "/reparaciones"
      },
      /*  {
        'icon': Icons.note_add_outlined,
        'name': 'Observaciones',
        'route': "/observaciones"
      }, */
      {
        'icon': Icons.inventory_2_outlined,
        'name': 'Inventario',
        'route': "/inventario"
      },
      {
        'icon': Icons.qr_code_2_outlined,
        'name': 'Generar QRs',
        'route': "/generarQRs"
      },
    ];
    return Drawer(
      backgroundColor: Colors.green.shade900,
      child: ListView.builder(
        itemCount: iconName.length + 1, // +1 para el DrawerHeader
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white54),
                ),
              ),
              height: 130,
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
                              Radius.circular(15),
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
                        const Expanded(
                          child: ListTile(
                            title: Text('Bienvenido a CSF',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            final item = iconName[index - 1];
            return ListTile(
              leading: Icon(
                item['icon'],
                color: Colors.white,
              ),
              title: Text(item['name'],
                  style: const TextStyle(color: Colors.white)),
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
