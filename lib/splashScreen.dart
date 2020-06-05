import 'package:crackit/home.dart';
import 'package:flutter/material.dart';
import 'package:crackit/SplashView.dart';

class  splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 4),(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(false)));
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SplashView(),
   );
  }
}