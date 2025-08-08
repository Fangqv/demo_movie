import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movie/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    if (kDebugMode) {
      await Future.delayed(const Duration(milliseconds: 100));
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    Get.offAllNamed(AppRoutes.home);
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
