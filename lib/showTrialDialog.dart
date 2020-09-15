import 'package:flutter/material.dart';

Future<void> showTrialDialog(context) async{
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return AlertDialog(
        title:Text("You are in Free Trial Mode! "),
        content: SingleChildScrollView(
          child:ListBody(children: <Widget>[
            Text(""),
            
          ],
          )
        ),
        actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Approve"))
        ],
      );
    }
    );
}