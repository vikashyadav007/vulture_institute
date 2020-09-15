import 'dart:async';
import 'package:crackit/ScoreClass.dart';
import 'package:crackit/TestClass.dart';
import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:crackit/TestClass.dart';

class ResultView extends StatefulWidget{
 ScoreClass scoreClass;
 ResultView(this.scoreClass);
  @override
  State<StatefulWidget> createState() {
    return ResultViewState(scoreClass);
  }
}

class ResultViewState extends State<ResultView>{
 ScoreClass scoreClass;
  ResultViewState(this.scoreClass);

  StateModel appState;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
     }

view(){
    return Center(
      child:ListView(
      children: [
       Padding(padding: EdgeInsets.all(15)),
       Center(child: Text("You have scored",style: TextStyle(fontSize:27,color: Colors.red,fontWeight: FontWeight.bold)),),
        Padding(padding: EdgeInsets.all(10)),
       Container(
            height:150,
            width:150,
            child:CircleAvatar(
              backgroundColor:Colors.indigo,
              child:Text('${scoreClass.score} / ${scoreClass.total}',style:TextStyle(fontSize: 25))
              ),
          ),
      //  Center(child:  Text('$finalScore / $totalScore',style: TextStyle(fontSize:35),),),
       Padding(padding: EdgeInsets.all(15)),
        Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("ATTEMPTED",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(scoreClass.attempted.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ), 
          // Padding(padding: EdgeInsets.all(1)),
           Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("UN-ATTEMPTED",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(scoreClass.unattempted.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ),
          //  Padding(padding: EdgeInsets.all(1)),
          Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("CORRECT",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(scoreClass.correct.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ),
          //  Padding(padding: EdgeInsets.all(1)),
          // Divider(height:4,color: Colors.black,),
          Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("INCORRECT",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            // Container(color:Colors.black,width:2,),
            Divider(color: Colors.black,thickness: 2,height: 2,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(scoreClass.incorrect.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ),
           Container(color:Colors.black,height:2),
      ],
    ),
    );
}

 
   Center _showCircularProgress(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

 Widget _builtContainer(){
    if(isLoading==true){
     return _showCircularProgress();
    }else{
     return view();
    // return Text("data");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return 
    WillPopScope(
      onWillPop: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(true)));
      },

  child:
    Scaffold(
      appBar: AppBar(
        title: Text("TestPage"),
      ),
      // body: noTestShow(),
      body: _builtContainer(),
    )
    );
  }

}
