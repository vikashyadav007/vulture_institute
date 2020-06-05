import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/SplashView.dart';
import 'package:crackit/colorValue.dart';
import 'package:crackit/doubts.dart';
import 'package:crackit/loginOption.dart';
import 'package:crackit/resolvedDoubt.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:crackit/unResolvedDoubt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class DoubtSelection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoubtSelectionState();
  }
}

class DoubtSelectionState extends State<DoubtSelection>{
  StateModel appState;
  bool _isLoading = true;
  int unResolved;
  int resolved;
  List<Map> unResolvedData=[];
  List<Map> resolvedData=[];

getData() async{
  await getUnResolvedData();
  await getResolvedData();
  setState(() {
    _isLoading = false;
  });
}

  getUnResolvedData() async{
      Firestore.instance
        .collection('new_doubts')
        .where("userId",isEqualTo: appState.user.uid)
        . where("isResolved",isEqualTo: false)
        .snapshots()
        .listen((data) {
            print(data.documents.length);
             setState(() {
                unResolved = data.documents.length;
            });
        data.documents.forEach((doc) { 
               unResolvedData.add(doc.data);
        });
      });
      return;
}
  getResolvedData() async{
  Firestore.instance
  .collection('new_doubts')
  .where("userId",isEqualTo: appState.user.uid)
  . where("isResolved",isEqualTo: true)
  .snapshots()
  .listen((data) {
    print(data.documents.length);
    setState(() {
      resolved = data.documents.length;
    });
    data.documents.forEach((doc) { 
      resolvedData.add(doc.data);
    });
   });
    return;
}

 Widget unResolvedButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 35.0, 15, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: primaryColor,
            child: new Text('Unresolved ${unResolved}',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UnResolvedDoubt(unResolvedData),));
            },
          ),
        ));
  }
 Widget resolvedButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 35.0, 15, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: primaryColor,
            child: new Text('Resolved ${resolved}',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ResolvedDoubt(resolvedData)));
            },
          ),
        ));
  }
 Widget newDoubtButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 35.0, 15, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: primaryColor,
            child: new Text('Submit new Doubt',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Doubts()));
            },
          ),
        ));
  }

  Widget _createContent(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Expanded(
          flex: 7,
          child: 
                 Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child:Card(
                                color:Colors.red,
                                elevation: 15,
                                  child: 
                                    Material(
                                      child: InkWell(
                                        onTap: ()=> null,
                                          child:Container(
                                              color: primaryColor,
                                              child:
                                              Column(
                                                children:[
                                                  Padding(padding: EdgeInsets.all(5)),
                                              Center(child:Text("Your Doubts",style: TextStyle(fontSize:25),)),
                                                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child:
                                                  Divider(
                                                    height: 20.0,
                                                    color: Colors.black,
                                                  ),),
                                               Center(child: unResolvedButton()),
                                                Center(child: resolvedButton()),
                                                
                                                ]
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                    ),

        ),
        Expanded(
          flex: 3,
          child:  Center(child:newDoubtButton()),

        ),
        
      ]
    );
  }

 

    Widget _buildstory({Widget body}){
      return 
      Scaffold(
    appBar: AppBar(
      title: Text("Doubt"),
    ),
    body:
    WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
      },
      child:
      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: _createContent(),)
    
    )
    );
    }


     Widget  _buildLoadingContainer(){
      return Scaffold(
        body:
               Center(
                  child: CircularProgressIndicator(),
                  )
      );
    }

Widget _buildContent(){
      if(_isLoading==true){
            getData();
        return _buildLoadingContainer();
      }
    else{
        return _buildstory();
      }
    }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
     appState = StateWidget.of(context).state;
    return _buildContent();
  }
}
























