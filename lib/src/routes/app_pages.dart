import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:csf/ui/pages/CODIGOSQR/generar_qr_view.dart';
import 'package:csf/ui/pages/CODIGOSQR/pdf_view_qrs.dart';
import 'package:csf/ui/pages/DASHBOARD/view_stock_modelos.dart';
import 'package:csf/ui/pages/INGRESOS/view_detalle_registro.dart';
import 'package:csf/ui/pages/INGRESOS/view_registro_page.dart';
import 'package:csf/ui/pages/INGRESOS/view_reparaciones_page.dart';
import 'package:csf/ui/pages/INVENTARIO/inventario_page.dart';
import 'package:csf/ui/pages/INVENTARIO/printing_inventario.dart';
import 'package:csf/ui/pages/INVENTARIO/reporte_inventario_page.dart';
import 'package:csf/ui/pages/OBSERVACIONES/view_observaciones.dart';
import 'package:csf/ui/pages/SALIDAS/view_salida_page.dart';
import 'package:csf/ui/pages/home_page.dart';
import 'package:csf/ui/pages/INGRESOS/registro_page.dart';
import 'package:csf/ui/pages/SALIDAS/salida_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegistroPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
        name: Routes.salida,
        page: () => const SalidaPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
      name: Routes.viewRegister,
      page: () => const ViewRegistrosPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: Routes.viewSalida,
      page: () => const ViewSalidaPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
        name: Routes.updateRegister,
        page: () => RegistroUpddatePage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
      name: Routes.reparaciones,
      page: () => const ViewReparacionesPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: Routes.observaciones,
      page: () => const ViewObservacionesPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: Routes.inventario,
      page: () => InventarioPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
        name: Routes.viewPDF,
        page: () => const PdfPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: Routes.viewStockModelo,
        page: () => ViewStockModeloPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: Routes.generarQRs,
        page: () => const ViewGenerateQRPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: Routes.pdfViewQr,
        page: () => const PdfViewQrPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: Routes.reporteInventario,
        page: () => const ReporteInventarioPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200)),
  ];
}
