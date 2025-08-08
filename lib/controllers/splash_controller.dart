import 'dart:developer';

import 'package:get/get.dart';
import 'package:halo/halo.dart';
import 'package:movie/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // qr;
    super.onInit();
    // debugger();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    // qr;
    // debugger();
    Get.offAllNamed(AppRoutes.home);
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // qr;
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
