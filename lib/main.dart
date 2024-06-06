
import 'package:fitness/components/menu.dart';
import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account/loginPage.dart';

 String isLogin = "";

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  // );
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getString('id') ?? "";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorTheme),
        useMaterial3: true,
      ),

      home:  (isLogin.isNotEmpty) ? const Menu() : LoginPage(),

      debugShowCheckedModeBanner: false,
    );
  }
}
