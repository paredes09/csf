import 'package:csf/src/class/dashborad.dart';
import 'package:csf/src/services/http_services.dart';
import 'package:get/get.dart';
import 'package:csf/src/controllers/registro_controller.dart';
import 'package:csf/src/controllers/salida_controller.dart';

class HomeController extends GetxController {
  final RegistroController control = Get.find<RegistroController>();
  final SalidaController salidaController = Get.find<SalidaController>();
  final http = HttpServices();
  var tablaEstados = <TablaEstadosClass>[].obs;
  var ventasPeriodo = <GraficoVentasMesyAo>[].obs;
  var load = false.obs;
  var loading = false.obs;
  void onRefresh() {
    handleListarVentasPeriodo(DateTime.now().year);
    handleListarTablaEstados();
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

  Future<void> handleListarTablaEstados() async {
    load.value = true;
    try {
      final listarEstados = await http.listarTablaEstados();
      tablaEstados.assignAll(listarEstados);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> handleListarVentasPeriodo(int year) async {
    loading.value = true;
    try {
      final vMes = await http.listarVentasPeriodo(year);
      ventasPeriodo.assignAll(vMes);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      load.value = false;
      loading.value = false;
    }
  }
}
