import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';

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
      appBar: AppBar(title: const Text('Reparaciones')),
      body: ListView.builder(
        itemCount: listaRegistrados.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(listaRegistrados[index].codigoAtaud),
              subtitle: Text(
                  '${listaRegistrados[index].modeloAtaud} - ${listaRegistrados[index].colorAtaud}'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                controller.setId(listaRegistrados[index].id);
              },
            ),
          );
        },
      ),
    );
  }
}
