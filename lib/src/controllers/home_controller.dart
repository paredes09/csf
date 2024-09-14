import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';

class HomeController extends GetxController {
  final RegistroController control = Get.find<RegistroController>();
  final SalidaController salidaController = Get.find<SalidaController>();

  void onRefresh() {
    control.handleModelosAtaudes();
    control.handleFabricantesAtaudes();
    control.handleTiposAtaudes();
    control.handleColoresAtaudes();
    control.hableTamanosAtaudes();
    control.hableObservaciones();
    control.hableCodigo();
    salidaController.handlelistarRegistros();
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }
}
