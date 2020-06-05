import 'package:crackit/colorValue.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crackit/showChapter.dart';
import 'package:crackit/values.dart';



class SelectSubject extends StatefulWidget{
  var title;
  SelectSubject(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectSubjectState(this.title);
    throw UnimplementedError();
  }
  
}

class SelectSubjectState extends State<SelectSubject>{
  var title;
  SelectSubjectState(this.title);

  StateModel appState;
  String _errorMessage=''; 

  int courseValue=-1;
  int standardValue=-1;
  int subjectValue=-1;

  void courseValueChangeHandler(int value){
    setState(() {
      courseValue = value;
      standardValue = -1;
      subjectValue = -1;
    });
  }

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

  Widget courseView(){
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
                                        'Courses:',
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
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'CBSE',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 2,
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'Pre-Foundation',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Radio(
                                                value: 3,
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'IIT/JEE',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 4,
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'NEET',
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

  Widget standardViewCBSE(){
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
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }

  Widget standardViewPrefoundation(){
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

  Widget standardViewIITJEE(){
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
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }

  Widget subjectCBSE9(){
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

  Widget subjectCBSE11(){
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
                              children: [
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
                                  'Zoology',
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

  Widget subjectIITJEE(){
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
                              children: [
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
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }

  Widget subjectNEET(){
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
                                  value: 5,
                                  groupValue: subjectValue,
                                  onChanged: subjectValueChangeHandler,
                                ),
                                new Text(
                                  'Zoology',
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

  Widget standardView(){
    if(courseValue==1){
      return standardViewCBSE();
    }else if(courseValue ==2){
      return standardViewPrefoundation();
    }else if(courseValue==3 || courseValue ==4){
      return standardViewIITJEE();
    }else{
      return Text("");
    }
  }

  Widget subjectView(){
    if(courseValue==1 && (standardValue==1 || standardValue == 2)){
      return subjectCBSE9();
    }else if((courseValue==1 && (standardValue==3 || standardValue == 4)) || (courseValue==2 && (standardValue==1 || standardValue == 2))){
      return subjectCBSE11();
    }else if(courseValue==3 && (standardValue==3 || standardValue == 4)){
      return subjectIITJEE();
    }else if(courseValue==4 && (standardValue==3 || standardValue == 4)){
      return subjectNEET();
    }else{
      return Text("");
    }
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
            child: new Text('Submit',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
              if(courseValue != -1 && standardValue != -1 && subjectValue !=-1){

                print(course[courseValue-1]);
                print(course[standardValue-1]);
                print(course[subjectValue-1]);
                print(title);

                 Navigator.push(context, MaterialPageRoute(builder: (context)=>
                 ShowChapter(course[courseValue-1],standard[standardValue-1],subject[subjectValue-1],title)));
              }else{
                setState(() {
                  _errorMessage="Select above value";
                });
                  
              }
            },
          ),
        ));
  }

  

  
  Widget _createContent(){

    return ListView(
      children:[
          courseView(),
          standardView(),
         subjectView(),
         submitButton(),
         _showErrorMessage(),
      ]
    );
  }

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
     appState = StateWidget.of(context).state;
     return Scaffold(
       appBar: AppBar(
         title:Text(title),
       ),
       body: _createContent(),
     );
  }
  
}