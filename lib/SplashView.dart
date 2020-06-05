import 'package:flutter/material.dart';
Widget SplashView(){
  return Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/background1.png'),
        //     fit: BoxFit.cover
        //     ),
        // ),
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Container(
               margin: EdgeInsets.only(bottom: 10),
               child:Hero(
                tag: "main_logo",
                child: Image.asset(
                  'assets/logo.png',
                  // height: 200,
                  // width: 250,
                ),
              ), 
              ) ,
            ],
          ));
}