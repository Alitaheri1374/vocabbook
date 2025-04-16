import 'package:flutter/material.dart';
import 'package:vocabbook/constants/app_const.dart';
import 'package:vocabbook/layer/presentation/home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),nextPage,);
  }
  nextPage(){
    Route route=MaterialPageRoute(builder: (context) => HomePage(),);
    Navigator.pushAndRemoveUntil(context, route, (Route<dynamic> route) => false,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text(AppConst.appTitle,style: TextStyle(fontSize: 35),),
      )
    );
  }
}
