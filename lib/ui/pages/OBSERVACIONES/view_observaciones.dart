import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/input_text.dart';

bool ind = false;

class ViewObservacionesPage extends GetView<RegistroController> {
  const ViewObservacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Observaciones'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                          child: AnimatedPadding(
                              duration: const Duration(milliseconds: 150),
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                child: Form(
                                  key: key,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const ListTile(
                                        title: Text(
                                          'Nueva Observación',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      inputText(
                                          3,
                                          false,
                                          '',
                                          TextInputType.text,
                                          null,
                                          controller.observController,
                                          controller.validarObservacion),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Obx(() => controller.isLoading.value
                                          ? const CircularProgressIndicator()
                                          : globalButton(
                                              'Registrar Observación', () {
                                              if (key.currentState!
                                                  .validate()) {
                                                controller
                                                    .handleRegistrarObservacion(
                                                        ind);
                                                key.currentState!.reset();
                                                Get.back();
                                              }
                                            }))
                                    ],
                                  ),
                                ),
                              )));
                    });
              },
              icon: const Icon(Icons.add_circle_outlined))
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.listarObservaciones.length,
              itemBuilder: (context, index) {
                final observacion = controller.listarObservaciones[index];
                ind = observacion.estado;
                return Column(
                  children: [
                    ListTile(
                      title: Text(observacion.detalles),
                      trailing: Obx(() => Checkbox(
                          value: observacion.estado.obs.value,
                          onChanged: (bool? value) {
                            controller.handleActualizarObservacion(
                                observacion.id,
                                observacion.detalles,
                                observacion.estado.obs.value = value!);
                          })),
                      onTap: () {
                        controller.observController.text = observacion.detalles;
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                  child: AnimatedPadding(
                                      duration:
                                          const Duration(milliseconds: 150),
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        child: Form(
                                          key: key,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const ListTile(
                                                title: Text(
                                                  'Editar Observación',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              PopScope(
                                                // ignore: deprecated_member_use
                                                onPopInvoked: (didPop) {
                                                  controller.observController
                                                      .clear();
                                                },
                                                child: inputText(
                                                    3,
                                                    false,
                                                    '',
                                                    TextInputType.text,
                                                    null,
                                                    controller.observController,
                                                    controller
                                                        .validarObservacion),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Obx(() => controller
                                                      .isLoading.value
                                                  ? const CircularProgressIndicator()
                                                  : globalButton(
                                                      'Actualizar Observación',
                                                      () {
                                                      if (key.currentState!
                                                          .validate()) {
                                                        controller
                                                            .handleActualizarObservacion(
                                                                observacion.id,
                                                                controller
                                                                    .observController
                                                                    .text,
                                                                observacion
                                                                    .estado
                                                                    .obs
                                                                    .value);
                                                        key.currentState!
                                                            .reset();
                                                        Get.back();
                                                      }
                                                    }))
                                            ],
                                          ),
                                        ),
                                      )));
                            });
                      },
                    ),
                    const Divider()
                  ],
                );
              },
            )),
    );
  }
}
