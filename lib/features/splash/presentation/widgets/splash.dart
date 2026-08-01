import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_lite/app/router/app_routes.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            context.go(AppRoutes.product);
          },
          child: const Text('Splash Page'),
        ),
      ),
    );
  }
}