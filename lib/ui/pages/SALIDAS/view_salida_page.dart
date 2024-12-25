import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';
import 'package:hugeicons/hugeicons.dart';

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
        backgroundColor: const Color.fromARGB(255, 242, 241, 241),
        appBar: AppBar(
          title: const Text(
            'Vendidos',
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
                      cursorColor: Colors.grey.shade500,
                      onChanged: (value) {
                        controller.searchQuerySalida.value = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          hintText:
                              'Busque por código, modelo o nombre del fallecido',
                          hintStyle: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                          prefixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedSearch02,
                              color: Colors.grey.shade600,
                              size: 20.0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.blue)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                ),
                const SizedBox(height: 20),
                Expanded(
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
                              icon: HugeIcons.strokeRoundedEdit01,
                              color: Colors.black),
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
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedAdd02,
              color: Colors.white,
              size: 24.0,
            )),
      ),
    );
  }
}
