import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_lite/app/router/app_router.dart';
import 'package:shop_lite/app/theme/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
    child: ShopLiteApp(),
  ),);
}

class ShopLiteApp extends StatelessWidget {
  const ShopLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ShopLite',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}


