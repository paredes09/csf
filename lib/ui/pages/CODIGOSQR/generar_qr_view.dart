import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/qr_controller.dart';
import 'package:csf/ui/global/buttons/global_button.dart';
import 'package:csf/ui/global/components/drow_text.dart';

class ViewGenerateQRPage extends GetView<GenerateQRController> {
  const ViewGenerateQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GenerateQRController());
    final List<DropDownValueModel> dropDownListaAtaud = controller
        .salidaConrtoller.listarAtaudes
        .where((element) => element.estadoAtaud == 1)
        .map(
      (element) {
        return DropDownValueModel(
          value: element.id,
          name: element.codigoAtaud,
        );
      },
    ).toList();

    return Scaffold(
        appBar: AppBar(title: const Text('Generar QRs')),
        body: Obx(() => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    left: 25, bottom: 30, right: 25, top: 30),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: inputDropDownTextField(
                              null, controller.codigoController, (value) {
                            if (value == "") {
                              controller.codigoController.clearDropDown();
                            } else if (value is DropDownValueModel) {
                              controller.codigoController.dropDownValue = value;
                              controller.agregarCodigoParaQr(value.name);
                              controller.codigoController.clearDropDown();
                            }
                          }, (p0) => null, dropDownListaAtaud, 'Codigo Ataud',
                              true),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: Obx(
                    () => SizedBox(
                      child: ListView.builder(
                        itemCount: controller.qrList.isEmpty
                            ? 0
                            : controller.qrList.length,
                        itemBuilder: (context, index) {
                          var codigo = controller.qrList[index];
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(5),
                                title: Text(codigo),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Color(0xFFE57373)),
                                  onPressed: () {
                                    controller.qrList.removeAt(index);
                                    controller.qrList.refresh();
                                  },
                                )),
                          );
                        },
                      ),
                    ),
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      child: globalButton('Generar QR', () {
                    Get.toNamed('/pdfViewQr');
                  }))
                ]))));
  }
}
