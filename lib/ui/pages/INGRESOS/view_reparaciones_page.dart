import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:hugeicons/hugeicons.dart';

final SalidaController controllerAtaudes = Get.put(SalidaController());

class ViewReparacionesPage extends GetView<RegistroController> {
  const ViewReparacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegistroController());
    var listaRegistrados = controllerAtaudes.listarAtaudes
        .where((element) => element.estadoAtaud == 3)
        .toList();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 241, 241),
      appBar: AppBar(title: const Text('Reparaciones')),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: ListView.builder(
          itemCount: listaRegistrados.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: Border.all(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  listaRegistrados[index].codigoAtaud,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                subtitle: Text(
                  '${listaRegistrados[index].modeloAtaud} - ${listaRegistrados[index].colorAtaud}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                trailing: const HugeIcon(
                    icon: HugeIcons.strokeRoundedEdit01, color: Colors.black),
                onTap: () {
                  controller.setId(listaRegistrados[index].id);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
