import 'package:crackit/demoClasses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/home2.dart';
import 'PDFScreen.dart';
import 'package:crackit/Practice.dart';
import 'package:firebase_database/firebase_database.dart';
class FirebaseRealTime extends StatefulWidget{
 
  @override
  State<StatefulWidget> createState() {
    return FirebaseRealTimeState();
  }
}

class FirebaseRealTimeState extends State<FirebaseRealTime>{
  bool _isloading = false;
  List chapterList = [];
  String data="";
  final DBref = FirebaseDatabase().reference().child("LiveSchedule");
 
     _fetchFirestoreData() async{
    setState(() {
      _isloading = true;
    });
    var data =  Firestore.instance.collection("std").document("sub");
    data.get().then((value){
       if(value.data == null){
         setState(() {
           _isloading = false;
         });
        }
        else{
          setState(() {
          var mapValue = value.data;
          var innerMapList = [];
          for(int i=1;i<value.data.length+1;i++){
            innerMapList.add(mapValue[i.toString()]);
          }
          chapterList = innerMapList;
         // print(innerMapList);
             _isloading = false;
          });
        }
    });
  }

     @override
  void initState() {
    super.initState();
    //_isloading = false;
    // _fetchFirestoreData();
  }

    Center _showCircularProgress(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

 Widget _builtContainer(){
    if(_isloading==true){
     return _showCircularProgress();
    }else{
     return _showOriginal();
    }
  }

  Widget _optionList(){
    return 
    ListView(
      children:<Widget>[
        RaisedButton(
          onPressed: (){
              DBref.push().set(
                {
                  "Title":"The physical World",
                  "Url":"https://youtu.be/W5HsTeTt4W8",
                  "Time":"07:00 PM",
                  "Date":"18-05-2020",
                  "Description":"We learn about physics chapter one",
                  }
              );
          },
        child:Text("Add")),
        Padding(padding: EdgeInsets.all(8)),
        RaisedButton(
          onPressed: null,
        child:Text("REtrieve")),
        Padding(padding: EdgeInsets.all(8)),
        RaisedButton(
          onPressed: null,
        child:Text("update")),
        Padding(padding: EdgeInsets.all(8)),
        RaisedButton(
          onPressed: null,
        child:Text("delete")),
        Padding(padding: EdgeInsets.all(8)),
        Container(
          child:Text(
            data,
          style: TextStyle(fontSize:15),
          ),
        )

      ],
    );
  }

  Widget _showOriginal(){
    return _isloading?_showCircularProgress():
    Center(
     // child: Text("Something"),
     child: _optionList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    WillPopScope(
      onWillPop: (){
       Navigator.pop(context);
      },

  child:
    Scaffold(
      appBar: AppBar(
        title: Text("Real Time"),
      ),
      body: _builtContainer(),
    )
    );
  }

}