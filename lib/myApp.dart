import 'package:crackit/loginOption.dart';
import 'package:crackit/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:crackit/colorValue.dart';


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Vulture Institute',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context)=>SplashScreen(),
        '/Login':(context) => LoginOption(),
      },
    );
  }
}