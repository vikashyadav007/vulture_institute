import 'package:flutter/material.dart';

class TrialModeEndMessage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrialModeEndMessageState();
    throw UnimplementedError();
  }
  
}

class TrialModeEndMessageState extends State<TrialModeEndMessage>{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
      child: Text("Your trial mode period finish"),
    ),
  Padding(padding: EdgeInsets.all(15)),
    RaisedButton(onPressed: (){
      
    },
    color: Colors.blue,
     child: Text("Go to Payment page"))
      ],
    );
  }
  
}