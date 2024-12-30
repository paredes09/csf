import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/input_text.dart';
import 'package:hugeicons/hugeicons.dart';

bool ind = false;

class ViewObservacionesPage extends GetView<RegistroController> {
  const ViewObservacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 241, 241),
      appBar: AppBar(
        title: const Text('Observaciones'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                          child: AnimatedPadding(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Form(
                                  key: key,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Nueva Observación',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
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
              icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedAddCircleHalfDot,
                  color: Colors.white))
        ],
      ),
      body: Obx(() => controller.listarObservaciones.isEmpty
          ? const Center(child: Text('No tienes observaciones registradas'))
          : ListView.builder(
              itemCount: controller.listarObservaciones.length,
              itemBuilder: (context, index) {
                final observacion = controller.listarObservaciones[index];
                ind = observacion.estado;
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        observacion.detalles,
                        style: const TextStyle(
                          fontSize: 12.5,
                        ),
                      ),
                      trailing: Obx(() {
                        bool isLoading =
                            controller.isLoadingMap[observacion.id] ?? false;
                        return isLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 3, 
                              )
                            : Checkbox(
                                activeColor: Colors.blue,
                                value: observacion.estado.obs.value,
                                onChanged: (bool? value) {
                                  controller.handleActualizarObservacion(
                                      observacion.id,
                                      observacion.detalles,
                                      observacion.estado.obs.value = value!);
                                });
                      }),
                      onTap: () {
                        controller.observController.text = observacion.detalles;
                        showModalBottomSheet<void>(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                  child: AnimatedPadding(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Form(
                                          key: key,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Editar Observación',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 15,
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
                    const Divider(
                      thickness: 1.5,
                      height: 5,
                      color: Colors.black12,
                    )
                  ],
                );
              },
            )),
    );
  }
}
