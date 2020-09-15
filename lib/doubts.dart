import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/DoubtsLanding.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:crackit/colorValue.dart';
import 'package:crackit/values.dart';

class Doubts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DoubtsState();
  }
}

class DoubtsState extends State<Doubts>{
 StateModel appState;
 String _errorMessage=''; 
 int standardValue=-1;
  int subjectValue=-1;

  void standardValueChangeHandler(int value){
    setState(() {
      standardValue = value;
      subjectValue = -1;
    });
  }
  void subjectValueChangeHandler(int value){
    setState(() {
      subjectValue = value;
    });
  }

     @override
  void initState() {
    super.initState(); 
  }

Widget standardView(){
    return Padding(
            padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
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
                                  new Text(
                                      'Standard :',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                  ),

                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 1,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            '9',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                             new Padding(
                        padding: new EdgeInsets.all(10.0),
                      ),
                          new Radio(
                            value: 2,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            '10',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Padding(
                        padding: new EdgeInsets.all(10.0),
                      ),
                            new Radio(
                            value: 3,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            '11',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                             new Padding(
                        padding: new EdgeInsets.all(10.0),
                      ),
                          new Radio(
                            value: 4,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            '12',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                          new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 5,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            'REET(science/maths)',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                           new Radio(
                            value: 7,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            'Patwar',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                       
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 6,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            'REET(sst)',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                            new Radio(
                            value: 10,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            'High Court class IV',
                            style: new TextStyle(fontSize: 16.0),
                          ),       
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         new Radio(
                            value: 9,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            'Constable',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                            new Radio(
                            value: 11,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            'High Court LDC',
                            style: new TextStyle(fontSize: 16.0),
                          ),   
                        ],
                      ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }
   
   Widget subjectView9(){
      return Padding(
            padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
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
                                   new Text(
                              'Subject:',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 1,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Physics',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Chemistry',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 3,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Mathematics',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 4,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Biology',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }

   Widget subjectView11(){
      return Padding(
            padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
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
                                   new Text(
                              'Subject:',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 1,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Physics',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Chemistry',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 3,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Mathematics',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 5,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'zoology',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 6,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Botney',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }

  Widget reetSMView(){
    return Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                  new Text(
                                      'Subjects :',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                  ),

                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 7,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Hindi',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 8,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'English',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 10,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Science',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                                      ],
                      ),
                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 9,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Psychology',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 3,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Mathematics',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                                      ],
                      ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }
  Widget constableView(){
    return Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                  new Text(
                                      'Subjects :',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                  ),

                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 12,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Rajasthan-GK',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 11,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'India -GK',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                       ],
                      ),
                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 13,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Reasoning',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 14,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Computer',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                  new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            new Radio(
                            value: 10,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Science',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 16,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Kanuni Prabdhan',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }
 
  Widget reetSSTView(){
    return Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                  new Text(
                                      'Subjects :',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                  ),

                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 7,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Hindi',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 8,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'English',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 11,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'India GK',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                                      ],
                      ),
                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 9,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Psychology',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 12,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Rajasthan GK',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                                      ],
                      ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }
 
 Widget patwarView(){
    return Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                  new Text(
                                      'Subjects :',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                  ),

                                       new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 7,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Hindi',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 8,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'English',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 10,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Science',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                                      ],
                      ),
                   new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 3,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Mathematics',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                            new Radio(
                            value: 13,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Reasoning',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                                      ],
                      ),
                   new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 14,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'Computer',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                            new Radio(
                            value: 12,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text(
                            'Rajasthan GK',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                       ],
                      ),
                   new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 15,
                            groupValue: subjectValue,
                            onChanged: subjectValueChangeHandler,
                          ),
                          new Text (
                            'India Gk and Current GK',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                                      ],
                      ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }

  Widget highCourtClass4(){
      return Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                   new Text(
                              'Subject:',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 7,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Hindi',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 8,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'English',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 17,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Rajasthan Arts & Culture',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );

  }
  Widget highCourtLDC(){
      return Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                   new Text(
                              'Subject:',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 7,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Hindi',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 8,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'English',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 11,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'India GK',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 12,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Rajasthan GK',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );

  }


 Widget submitButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 35.0, 15, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: primaryColor,
            child: new Text('Next',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
              if(standardValue != -1 && subjectValue !=-1){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DoubtsLanding(standard[standardValue-1],subject[subjectValue-1])));
              }else{
                setState(() {
                  _errorMessage="Select above value";
                });
                  
              }
            },
          ),
        ));
  }

Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {

      String temp = _errorMessage;
      // _errorMessage = '';
      return Padding(padding: EdgeInsets.all(15),
      child:Center(child:
        new Text(
          temp,
          style: TextStyle(
              fontSize: 15.0,
              color: Colors.red,
              height: 1.0,
              fontWeight: FontWeight.w300),
        ),
      )
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
 
 subjectView(){
   if(standardValue==1 || standardValue==2){
     return subjectView9();
   }else if(standardValue==3 || standardValue==4){
     return subjectView11();
   }else if(standardValue==5){
      return reetSMView();
    }else if( standardValue==6){
      return reetSSTView();
    }else if( standardValue==7){
      return patwarView();
    }else if( standardValue==9){
      return constableView();
    }else if( standardValue==10){
      return highCourtClass4();
    }else if( standardValue==11){
      return highCourtLDC();
    } 
   else{
     return Text("");
   }
 }

  Widget _createContent(){
    return ListView(
      children:[
          standardView(),
          subjectView(),
          submitButton(),
          _showErrorMessage(),
      ]
    );
  }

  getData2() async{
    var query = Firestore.instance.collection('new_doubts');
  query = query.where("userId",isEqualTo: appState.user.uid);
 query = query.where("isResolved",isEqualTo:false);
 
  query.snapshots()
  .listen((data) {
    data.documents.forEach((doc) { 
     DocumentSnapshot ds = doc;
    });
   });
     
  }

getData() async{
  Firestore.instance
  .collection('new_doubts')
  .where("userId",isEqualTo: appState.user.uid)
  . where("isResolved",isEqualTo: false)
  .snapshots()
  .listen((data) {
    data.documents.forEach((doc) { 
     DocumentSnapshot ds = doc;
    });
   });
}
  

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
     getData();
    return 
    WillPopScope(
      onWillPop: (){
       Navigator.pop(context);
      },

  child:
    Scaffold(
      appBar: AppBar(
        title: Text("Ask a doubt"),
      ),
      body: _createContent(),
    )
    );
  }

}