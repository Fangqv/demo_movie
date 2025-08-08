import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/routes/app_pages.dart';
import 'package:movie/routes/app_routes.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:halo/halo.dart';

void main() {
  final _ = WidgetsFlutterBinding.ensureInitialized();
  HF.init();
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
