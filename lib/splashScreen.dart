import 'package:crackit/home.dart';
import 'package:flutter/material.dart';
import 'package:crackit/SplashView.dart';
import 'package:connectivity/connectivity.dart';

class  SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

   var subscription;
   var _scaffoldKey = GlobalKey<ScaffoldState>();

   checkConnection() async {
     await Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
        if(connectivityResult == ConnectivityResult.none){
           var snackBar = SnackBar(
             content: Text("No Healthy Internet connection"),
             duration: Duration(minutes: 2),
          
           );
           _scaffoldKey.currentState.showSnackBar(snackBar);
    }else{
        Future.delayed(Duration(seconds: 4),(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(false)));
    });

    }
      });
   }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
     key: _scaffoldKey,
     body: SplashView(),
   );
  }
}