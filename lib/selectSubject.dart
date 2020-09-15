import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/colorValue.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crackit/showChapter.dart';
import 'package:crackit/values.dart';
import 'package:crackit/TrialModeEndMessage.dart';



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
  int mediumValue=-1;

  
  void courseValueChangeHandler(int value){
    setState(() {
      courseValue = value;
      standardValue = -1;
      subjectValue = -1;
      mediumValue=-1;
    });
  }

  void mediumValueChangeHandler(int value){
    setState(() {
      mediumValue = value;
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
                                                value: 3,
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'IIT/JEE',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 6,
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'RBSE',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             
                                              new Radio(
                                                value: 4,
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'NEET',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                                new Radio(
                                                value: 5,
                                                groupValue: courseValue,
                                                onChanged: courseValueChangeHandler,
                                              ),
                                              new Text(
                                                'Other Competitive Exams',
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
                      //       new Radio(
                      //       value: 3,
                      //       groupValue: standardValue,
                      //       onChanged: standardValueChangeHandler,
                      //     ),
                      //     new Text(
                      //       '11',
                      //       style: new TextStyle(fontSize: 16.0),
                      //     ),
                      //        new Padding(
                      //   padding: new EdgeInsets.all(10.0),
                      // ),
                      //     new Radio(
                      //       value: 4,
                      //       groupValue: standardValue,
                      //       onChanged: standardValueChangeHandler,
                      //     ),
                      //     new Text(
                      //       '12',
                      //       style: new TextStyle(
                      //         fontSize: 16.0,
                      //       ),
                      //     ),
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
  Widget mediumView(){
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
                                      'Medium :',
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
                            groupValue: mediumValue,
                            onChanged: mediumValueChangeHandler,
                          ),
                          new Text(
                            'English',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                             new Padding(
                        padding: new EdgeInsets.all(10.0),
                      ),
                          new Radio(
                            value: 2,
                            groupValue: mediumValue,
                            onChanged: mediumValueChangeHandler,
                          ),
                          new Text(
                            'Hindi',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Padding(
                        padding: new EdgeInsets.all(10.0),
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
                          new Radio(
                            value: 8,
                            groupValue: standardValue,
                            onChanged: standardValueChangeHandler,
                          ),
                          new Text(
                            'Target',
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
  Widget otherCompetitiveExams(){
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
                                      'Exams :',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
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
                                  'Botnay',
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
                                  'Botany',
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
    }else if((courseValue==3 || courseValue ==4) && mediumValue!=-1){
      return standardViewIITJEE();
    }else if(courseValue == 5){
      return otherCompetitiveExams();
    }else if(courseValue==6 && mediumValue!=-1){
      return standardViewCBSE();
    }
    else{
      return Text("");
    }
  }

  Widget subjectView(){
    if((courseValue==1 || courseValue==6) && (standardValue==1 || standardValue == 2)){
      return subjectCBSE9();
    }else if((courseValue==1 && (standardValue==3 || standardValue == 4)) || (courseValue==2 && (standardValue==1 || standardValue == 2))){
      return subjectCBSE11();
    }else if(courseValue==3 && (standardValue==3 || standardValue == 4 || standardValue == 8 )){
      return subjectIITJEE();
    }else if(courseValue==4 && (standardValue==3 || standardValue == 4 || standardValue == 8 )){
      return subjectNEET();
    }else if(courseValue==5 && standardValue==5){
      return reetSMView();
    }else if(courseValue==5 && standardValue==6){
      return reetSSTView();
    }else if(courseValue == 5 && standardValue==7){
      return patwarView();
    }else if(courseValue ==5 && standardValue==9){
      return constableView();
    }else if(courseValue ==5 && standardValue==10){
      return highCourtClass4();
    }else if(courseValue ==5 && standardValue==11){
      return highCourtLDC();
    } 
    else{
      return Text("");
    }
  }

  Widget submitButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 25.0, 15, 10.0),
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
                String cour;
                if(mediumValue == 2){
                  cour = course[courseValue-1]+'-'+medium[mediumValue-1];
                  // print(cour);
                }else{
                  cour=course[courseValue-1];
                }
                print(subject[subjectValue-1]);
                print(standard[standardValue-1]);
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>
                 ShowChapter(cour,standard[standardValue-1],subject[subjectValue-1],title)));
              }else{
                setState(() {
                  _errorMessage="Select above value";
                });
                  
              }
            },
          ),
        ));
  }

subjectButtonView(String course,String standard,String type,var subject){
  List<Widget> widget = [];
  if(type =='complete'){
      subject.forEach((value)=>{
     widget.add(
       RaisedButton(
         color:Colors.blue[300],
         child: Text(value.toString()),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                 ShowChapter(course,standard,value,title)));
     },)
     ),
    //  widget.add(Text(value.toString())),
    }
    );
    
    // return Container(
    //   color:Colors.white,
    //   child:GridView.builder(
    //     itemCount: subject.length,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //      itemBuilder: (BuildContext context,int index){
    //     return  Padding(padding: EdgeInsets.all(5),
    //     child:
    //     RaisedButton(
    //       color: Colors.amber,
    //       child: Text(subject[index].toString()),onPressed: (){
    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>
    //              ShowChapter(course,standard,subject[index],title)));
    //  },
    //  ));
    //   },
    //      )
    // );



    
  }else{
    widget.add(Text(subject.toString()));
     widget.add(
       RaisedButton(
        color: Colors.blue[300],
         child: Text(subject.toString()),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                 ShowChapter(course,standard,subject,title)));
     },)
     );

    //  return  RaisedButton(
    //    color: Colors.amber,
    //    child: Text(subject.toString()),onPressed: (){
    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>
    //              ShowChapter(course,standard,subject,title)));
    //  },);
  }
  return widget;

}

  subListView(){
    List<Widget> widget = [];
     List<dynamic> paymentSchema = appState.studentInfo.paymentSchema;
    if(paymentSchema == null){
       widget.add(Center(child:Text("No Current Enrollment")));
    }else{
       Timestamp timestampNow = new Timestamp.now();
      paymentSchema.forEach((element) {
          Timestamp timestamp = element['valid-upto'];
          if(timestampNow.compareTo(timestamp)!=1 ){
                String courses=element['payment-description']['course'] ;
                String type= element['payment-description']['type'] ;
                String standard= element['payment-description']['standard'];
                var subject=(element['payment-description']['subject']) ;
                if(type == 'complete'){
                if(courses == course[4]){
                    subject = subjectsMap[standard].toList();
                  }else{
                    subject = subjectsMap[courses].toList();
                  }

                  // if(courses == course[2]){
                  //   subject = subjectsMap[course[2]].toList();
                  // }else if(courses == course[3]){
                  //   subject = subjectsMap[course[3]].toList();
                  // }else if(courses == course[4]){
                  //   subject = subjectsMap[standard].toList();
                  // }
                  print(subject);
                  // print(courses);
                  // subject = subjectsMap[courses].toList();
                }
              widget.add( 
                Padding(
                    padding: EdgeInsets.all(15),
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
                                          ListTile(
                                            leading: Text("Course:"),
                                            title: Text(courses),
                                          ),
                                          ListTile(
                                            leading: Text("Standard:"),
                                            title: Text(standard),
                                          ),
                                          ListTile(
                                            leading: Text("Subjects:"),
                                            // title: 
                                            // // subjectButtonView(courses,standard,type,subject)
                                            // Container(
                                            //   height: 200,
                                            //   child:
                                            //   subjectButtonView(courses,standard,type,subject)
                                            // // ListView(
                                            // //   scrollDirection: Axis.vertical,
                                            // //   children: subjectButtonView(courses,standard,type,subject),
                                            // //   )
                                            //   )
                                          ),
                                          ListTile(
                                            // leading: Text("Subjects:"),
                                            title: 
                                            // subjectButtonView(courses,standard,type,subject)
                                            Container(
                                              height: 200,
                                              child:
                                              // subjectButtonView(courses,standard,type,subject)
                                            ListView(
                                              scrollDirection: Axis.vertical,
                                              children: subjectButtonView(courses,standard,type,subject),
                                              )
                                              )
                                          ),
                                        ]
                                    ),
                                ),
                            ),
                        ),
                    ),
                    ),
                );
          }
      }
      );
    }
    return widget;
    
  }

  mediumViewHandler(){
    if(courseValue==3 || courseValue==4 || courseValue==6){
      return mediumView();
    }else{
     return Text("");
    }
  }

 subView(){
    return ListView(
      children:subListView(),
    );
 }

 nonSubView(){
     return ListView(
      children:[
          courseView(),
          mediumViewHandler(),
          standardView(),
         subjectView(),
         submitButton(),
         _showErrorMessage(),
      ]
    );
 }

  Widget _createContent(){
    if(appState.studentInfo.isSubscribed== false){
        if(appState.studentInfo.trialPeriod == false){
              return TrialModeEndMessage();
      }else{
        return nonSubView();
      }
    }else{
    //  return nonSubView();
     return subView();
    }
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