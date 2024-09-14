import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';

final RegistroController controllers = Get.put(RegistroController());

class ViewSalidaPage extends GetView<SalidaController> {
  const ViewSalidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SalidaController());
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) {
          controller.searchQuerySalida.value = '';
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Salida de Ataudes',
          ),
        ),
        body: Obx(() {
          var listaRegistrados = controller.listaFiltradaSalida;
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: TextField(
                      onChanged: (value) {
                        controller.searchQuerySalida.value = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          hintText: 'Buscar',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ))),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: listaRegistrados.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(listaRegistrados[index].codigoAtaud),
                          subtitle: Text(
                              '${listaRegistrados[index].modeloAtaud} - ${listaRegistrados[index].colorAtaud}'),
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            controllers.setId(listaRegistrados[index].id);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Get.toNamed('/salida');
          },
          child: const Icon(
            Icons.library_add_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
