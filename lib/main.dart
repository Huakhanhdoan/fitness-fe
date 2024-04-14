import 'package:fitness/account/loginPage.dart';
import 'package:fitness/account/registerPage.dart';
import 'package:fitness/home/homePage.dart';
import 'package:fitness/untils/color.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorTheme),
        useMaterial3: true,
      ),
      home:  RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}