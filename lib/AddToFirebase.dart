import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'List.dart';

class AddToFirebase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddToFirebaseState();
    throw UnimplementedError();
  }
  
}

class AddToFirebaseState extends State<AddToFirebase>{

  StateModel appState;
     add()async {
       addToFireBase(bio11,"Biology_11");
       addToFireBase(che11,"Chemistry_11");
       addToFireBase(phy11,"Physics_11");
       addToFireBase(mth11,"Mathematics_11");
       addToFireBase(bio12,"Biology_12");
       addToFireBase(che12,"Chemistry_12");
       addToFireBase(phy12,"Physics_12");
       addToFireBase(mth12,"Mathematics_12");
     }

     addToFireBase(List<String> list,String sub) async{
        for(int i=0;i<list.length;i++){

            Map<String,Map<String,String>> finalMap={};
                  Map<String,String> temp ={
                    "Title":"",
                     "Url":"",
                   };
                  finalMap[(1).toString()]=temp;
                   DocumentReference dr = await Firestore.instance.collection(sub).document(list[i]);
                    dr.setData(finalMap);
          
            for(int k=2;k<=5;k++){
                Map<String,Map<String,String>> finalMap={};
                  Map<String,String> temp ={
                    "Title":"",
                     "Url":"",
                   };
                  finalMap[(k).toString()]=temp;
                   DocumentReference dr = await Firestore.instance.collection(sub).document(list[i]);
                    dr.updateData(finalMap);
            }
        }
     }

     

    


  @override
  Widget build(BuildContext context) {
     appState = StateWidget.of(context).state;

     return Scaffold(
       appBar: AppBar(
         title:Text("Add to firebase"),
       ),
       body: 
       Column(
         children: [
            Center(
         child:RaisedButton(
           onPressed: (){
            add();
           },
         child:Text("Add"))
       ),
         ],
       )
      
     );
    // TODO: implement build
    throw UnimplementedError();
  }
  
}