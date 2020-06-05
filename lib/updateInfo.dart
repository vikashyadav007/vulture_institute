import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/colorValue.dart';
import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class UpdateInfo extends StatefulWidget{
  UpdateInfo();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpdateInfoState();
  }
  
}

class UpdateInfoState extends State<UpdateInfo>{

  StateModel appState;
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _number;
  String _errorMessage;
  bool _isLoading;
  String std="";
  String _stdError="";

  int _radioValue1 = -1;
  
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

  bool _validateAndSave(){
    final _form = _formKey.currentState;
    if(_form.validate()){
      _form.save();
      if(std.isEmpty){
        setState(() {
           _stdError = "Standard must not be empty";
           _isLoading = false;
        });
        return false;
      }
      return true;
    }
    else
    return false;

  }
   _validateAndSubmit() async{
    setState(() {
      _errorMessage="";
      _isLoading = true;
    });
    if(_validateAndSave()) {
      try{
        UserUpdateInfo _userUpdateInfo = new UserUpdateInfo();
        _userUpdateInfo.displayName = _name;
          await appState.user.updateProfile(_userUpdateInfo).then((onValue) async{
            FirebaseUser _user = await FirebaseAuth.instance.currentUser();
                appState.user = _user;    
          }) ;

          print(appState.user.uid);
          print(appState.user.email);
          
           Map<String,Map<String,String>> data;
          Map<String,String> mainData = {
            "Email":appState.user.email.toString(),
            "Name":_name,                
            "Phone":_number,
            "Standard":std,
            "Is subscribed":"false"
          };
          print(mainData);
          data = {
            appState.user.uid.toString():mainData,
          };
          print(data);
          DocumentReference dr = await Firestore.instance.collection("Student Info").document("ONnnBBbXJTOVMTDmODqs");
          dr.updateData(data);
          setState(() {
            appState.isloading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home(true)));
      }catch(e){
        print("Error $e");
        setState(() {
          _errorMessage = e;
          _isLoading = false;
          _formKey.currentState.reset();
        });
        
      }
    }
    setState(() {
      _isLoading = false;
    });

  }

  Widget _showErrorMessage() {
    if (_stdError.length > 0 && _stdError != null) {
      return new Text(
        _stdError,
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

  _showNameInput(){
    return  Column(
     mainAxisAlignment: MainAxisAlignment.start,
      children:<Widget>[

        new Align(
              alignment: Alignment.topLeft,
          child:  new Text(
                'Display Name :',
                style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                ),
              ), 
        ),
      
              Padding(
              padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        initialValue: appState.user.displayName,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Update your name",
        ),
         validator: (value)=>value.isEmpty?"Name must not be Empty":null,
         onSaved: (value)=>_name = value.trim(),
      ),
    )
    ]);
  }

  _showStandardSelection(){
     return 
    Center(
      child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

         new Padding(
               padding: new EdgeInsets.all(10.0),
                  ),

        new Align(
          alignment: Alignment.topLeft,
          child: new Text(
            'Standard :',
            style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            ),
          ),
        ),
                       new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                      new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child:
                      Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),),
      ]
      )
    );
  }

  _showNumberInput(){
    return  Column(
     mainAxisAlignment: MainAxisAlignment.start,
      children:<Widget>[
           new Padding(
               padding: new EdgeInsets.all(10.0),
                  ),
        new Align(
              alignment: Alignment.topLeft,
          child:  new Text(
                'Contact Number :',
                style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                ),
              ), 
        ),
      
              Padding(
              padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
      child: TextFormField(
        maxLength: 10,
        //initialValue: '+91',
        maxLines: 1,
        keyboardType: TextInputType.numberWithOptions(decimal:false,signed:false),
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Enter Contact Number",
        ),
         validator: (value)=>value.isEmpty?"Number must not be Empty":null,
         onSaved: (value)=>
         _number = value.trim(),
      ),
    )
    ]);
  }


  _showImageUploader(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        children: <Widget>[
          Text("Select Image"),
          RaisedButton(
            onPressed: null,
            child: Icon(Icons.file_upload),
          ),
        ],
      ),
    );
  }

  _showSubmitButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: SizedBox(
        height: 40,
        child: RaisedButton(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          color: primaryColor,
          child: Text("Submit",style: TextStyle(fontSize: 20,color: Colors.white),),
          onPressed: (){
            _validateAndSubmit();
          },
        ),
      ),
    );
  }

  _showForm(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
          _showNameInput(),
          _showStandardSelection(),
          _showErrorMessage(),
          _showNumberInput(),
         // _showImageUploader(),
          _showSubmitButton(),
        ],),
      ),

    );

  }

  _showCircularProcess(){
  if(_isLoading){
  return Center(child: CircularProgressIndicator(),);
  }else{
    return Container(height: 0,width: 0,);
  }
  }

  @override
  void initState() {
   
    super.initState();
   setState(() {
      _isLoading = false;
      _errorMessage = "";
   });
  
  }
  @override
  Widget build(BuildContext context) {

    appState = StateWidget.of(context).state;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update info"),
      ),
      body:Stack(
      children: <Widget>[
        _showForm(),
        _showCircularProcess(),
      ],
    ));
  }
  
}