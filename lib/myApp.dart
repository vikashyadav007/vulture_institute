import 'package:crackit/home.dart';
import 'package:crackit/login.dart';
import 'package:crackit/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:crackit/colorValue.dart';


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Crack It',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        //'/': (context)=>Home(false),
        '/': (context)=>splashScreen(),
        '/Login':(context) => Login(),
      },
    );
  }

}