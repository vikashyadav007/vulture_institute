import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/google-signin-button.dart';
import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:crackit/updateInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crackit/login.dart';
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


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googlesignIn = new GoogleSignIn();


   _fetchFirestoreData() async{
    setState(() {
      _isLoading = true;
    });
    var data =  Firestore.instance.collection("Student Info").document("ONnnBBbXJTOVMTDmODqs");
    data.get().then((value){
       if(value.data == null){
         setState(() {
           _isLoading = false;
         });
         Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateInfo()));
        }
        else{
          setState(() {
          Map<String,dynamic> mapValue = value.data;
          List<String> uidList = mapValue.keys.toList();
          String userUid = user.uid.toString();
          bool flag = false;
          for(String id in uidList){
              if(id.compareTo(userUid)==0){
               flag = true;
               break;
              }
          }
          if(flag==true){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(true)));
          }else{
               Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateInfo()));
          }
          });
        }     
    });
  }

  Future<FirebaseUser> signin() async{
    setState(() {
      _isLoading = true;
    });
    GoogleSignInAccount googleSignInAccount = await googlesignIn.signIn();
    

    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    
    AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );

    await _auth.signInWithCredential(credential).then((result){
        user =  result.user;
        setState(() {
          appState.user = user;
        });
    });
    print("\n\n\n");
    await _fetchFirestoreData();
    setState(() {
      _isLoading = true;
    });
   
  }
 

 
  
   Widget _showLogo() {
    return new Hero(
      tag: 'app-logo',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100.0,
          child: Image.asset('assets/logo.png',),
        ),
      ),
    );
  }

  
 

// Widget _signinWithEmail() {
//     return new Padding(
//         padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
//         child: SizedBox(
//           height: 40.0,
//           child: new RaisedButton(
//             elevation: 5.0,
//             shape: new RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(30.0)),
//             color: Colors.teal,
//             child: new Text("Sign in with Email",
//                 style: new TextStyle(fontSize: 20.0, color: Colors.white)),
//             onPressed:(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//             },
//           ),
//         ));
//   }
//   Widget _googleSignIn() {
//     return new Padding(
//         padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
//         child: SizedBox(
//           height: 40.0,
//           child: new RaisedButton(
//             elevation: 5.0,
//             shape: new RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(30.0)),
//             color: Colors.red,
//             child: new Text("Google signin",
//                 style: new TextStyle(fontSize: 20.0, color: Colors.white)),
//             onPressed:(){
//               signin();
//             },
//           ),
//         ));
//   }



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
      child: new ListView(
     // shrinkWrap: true,
      children: <Widget>[
       Image.asset(
                  'assets/logo.png',
                 // fit:BoxFit.cover
                //  width: 600,
                //  height: 500,

                ),
      //  Padding(padding: EdgeInsets.all(20),),
        GoogleSignInButton(
                    darkMode: false,
                    onPressed: signin,
                    borderRadius: 19,
                  ),
        Padding(padding: EdgeInsets.all(20),),
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
  
  var scaffold = Scaffold(
    backgroundColor: Colors.white,
    body: Stack(children: <Widget>[
      _showForm(),
      _showCircularProcess(),
    ],)
  );
    return scaffold;
  }
}



