import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/splash_controller.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/gen/l10n.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    const duration = kDebugMode ? Duration(milliseconds: 100) : Duration(milliseconds: 1000);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Title with animation
            TweenAnimationBuilder<double>(
              duration: duration,
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.movie,
                          size: 80,
                          color: AppTheme.secondaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.of(context).appTitle,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 48),
            // Loading indicator
            TweenAnimationBuilder<double>(
              duration: duration,
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondaryColor),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
