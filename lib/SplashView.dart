import 'package:crackit/values.dart';
import 'package:flutter/material.dart';
Widget SplashView(){
  return Container(
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
                  imageUrl,
                  // height: 200,
                  // width: 250,
                ),
              ), 
              ) ,
            ],
          ));
}