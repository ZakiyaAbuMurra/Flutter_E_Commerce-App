import 'package:ecommrac_app/utils/app_theme.dart';
import 'package:ecommrac_app/utils/route/app_router.dart';
import 'package:ecommrac_app/utils/route/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      theme: AppTheme.lightTheme(),
      initialRoute: AppRoutes.bottomNavbar,
      onGenerateRoute: AppRouters.onGenerateRoute,
    );
  }
}
