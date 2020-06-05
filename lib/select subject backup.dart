import 'package:crackit/colorValue.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crackit/showChapter.dart';



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
    String std ="";
    String sub ="";
    String _errorMessage="";


  int _radioValue1 = -1;
  int _radioValue2 = -1;

  void _handleRadioValueChange1(int value){
    setState(() {
      _radioValue1 = value;
    });

    if(_radioValue1 ==0){
      std="11";
    }else if(_radioValue1 ==1){
      std="12";
    }
  }

  void _handleRadioValueChange2(int value){
    setState(() {
      _radioValue2 = value;
    });

   switch(_radioValue2){
     case 0: sub="Physics"; break;
     case 1: sub="Chemistry"; break;
     case 2: sub="Biology"; break;
     case 3: sub="Mathematics"; break;
   }
  }


  // createAlertDialog(BuildContext context){
  //   TextEditingController contorller = TextEditingController();
  //   return showDialog(context: context,builder:(context){
  //    return AlertDialog(
  //     title: Text("your name"),
  //     content: TextField(
  //       controller:contorller,
  //     ),
  //     actions: <Widget>[
  //       MaterialButton(
  //         onPressed: (){
  //           Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowChapter("12","Mathematics",title)));
  //       },
  //       elevation: 5.0,
  //       child: Text("Submit"),
  //       )
  //     ],
  //   );
  //   });
  // } 


Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 15.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _createContent2(){

     return 
   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    Padding(
            padding: EdgeInsets.all(5),
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
                            value: 0,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            '11',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                             new Padding(
                        padding: new EdgeInsets.all(10.0),
                      ),
                          new Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
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
    ),


    Padding(
            padding: EdgeInsets.all(5),
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
                                  value: 0,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Physics',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
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
                                  value: 2,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Biology',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 3,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Mathematics',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Padding(
                              padding: new EdgeInsets.all(8.0),
                            )
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    ),




        

                      // new Padding(padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      // child:
                      // Divider(
                      //   height: 5.0,
                      //   color: Colors.black,
                      // ),),

                    


                      // new Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                           
                      //       ]
                      //       ),

              // new Padding(padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              //         child:
              //         Divider(
              //           height: 5.0,
              //           color: Colors.black,
              //         ),),

                              new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
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
              if(_radioValue1== -1 && _radioValue2 ==-1){
                setState(() {
                  _errorMessage="Select above value";
                });

              }else{
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowChapter(std,sub,title)));
              }
             
            },
          ),
        )),
        new Padding(
               padding: new EdgeInsets.all(8.0),
                            ),

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
       body: _createContent2(),
     );
    // TODO: implement build
    throw UnimplementedError();
  }
  
}