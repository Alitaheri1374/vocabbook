import 'package:flutter/material.dart';
import 'package:vocabbook/constants/app_const.dart';
import 'package:vocabbook/layer/presentation/home_page/home_page.dart';
import 'package:vocabbook/layer/presentation/home_page/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConst.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.purple
      ),
      home: SplashScreen(),
    );
  }
}
