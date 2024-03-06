import 'package:ecommrac_app/utils/app_theme.dart';
import 'package:ecommrac_app/views/pages/custom_bottom_navbar.dart';
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
      home: const CustomButtonNavBar(),
    );
  }
}

