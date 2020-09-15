import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/Address.dart';
import 'package:crackit/google-signin-button.dart';
import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:crackit/studentInfo.dart';
import 'package:crackit/updateInfo.dart';
import 'package:crackit/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginOption extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement creaLoginate
    return LoginOptionState();
  }
}

class LoginOptionState extends State<LoginOption>{
  StateModel appState;
  final _formKey = new GlobalKey<FormState>();
  bool _isLoading=false;
  FirebaseUser user;
  AuthCredential authCredential;
  StudentInfo student;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googlesignIn = new GoogleSignIn();


   _fetchFirestoreData() async{
    setState(() {
      _isLoading = true;
    });
    Firestore.instance
    .collection('studentProfile')
    .where("email",isEqualTo: appState.user.email)
    .snapshots()
    .listen((data) {
      if(data.documents.length==0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateInfo(authCredential)));
      }else{
           data.documents.forEach((element) {
         Map<String,dynamic> map = element.data;
        UserAddress useraddress = new UserAddress(map['address']['fullAddress'], map['address']["state"], map['address']["country"], map['address']["district"], map['address']["postalCode"], map['address']["latitude"], map['address']["longitude"]);
         
           student = new  StudentInfo(
           map['uid'], 
           map['email'],
            map['studentName'], 
            map['fatherName'], 
            map['phoneNumber'], 
            useraddress, 
            map['standard'], 
            map['Subscribed'].toString().compareTo("true")==0?true:false,
            map['trialPeriod'].toString().compareTo("true")==0?true:false,
            element.documentID,
            map['payments'],
            );
       });
           setState(() {
            appState.studentInfo = student;
            });

            


         Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(true)));
      }
     });


   
  }

  Future<FirebaseUser> signin() async{
    setState(() {
      _isLoading = true;
    });
    GoogleSignInAccount googleSignInAccount = await googlesignIn.signIn();
    

    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    
    authCredential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );


    await _auth.signInWithCredential(authCredential).then((result){
        user =  result.user;
        setState(() {
          appState.user = user;
        });
    });
    await _fetchFirestoreData();
    setState(() {
      _isLoading = true;
    });
   
  }
 
_showCircularProcess(){
  if(_isLoading== true){
    return Center(child: CircularProgressIndicator(),);
  }
  return Container(height: 0.0,width: 0.0,);
}


_showForm(){
  return new Container(
    padding: EdgeInsets.all(16),
    child: Form(
      key: _formKey,
      child: new Column(
      children: <Widget>[
        Expanded(
          flex: 7,
          child:Center(child: Image.asset(
                  imageUrl,
                ),)
           ),
        Expanded(
          flex: 3,
          child: Center(child:GoogleSignInButton(
                    darkMode: false,
                    onPressed: signin,
                    borderRadius: 19,
                  ) ,)),
      ],
      )),
  );
}

  @override
  void initState() {
    _isLoading = false;
     super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
  
  var stack = Stack(children: <Widget>[
      _showForm(),
      _showCircularProcess(),
    ],);


    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
          onWillPop: (){
            exit(0);
          },
          child: stack
      ),
    );
  }
}



