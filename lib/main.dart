import 'package:crackit/myApp.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/material.dart';

void main() {
  StateWidget stateWidget = new StateWidget(child:MyApp()  );
  try{
  runApp(stateWidget);
  }catch(e){
    print("Error in main function : $e\n\n");
  }
}
