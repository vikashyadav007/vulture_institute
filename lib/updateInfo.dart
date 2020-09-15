import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/Address.dart';
import 'package:crackit/colorValue.dart';
import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:crackit/studentInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crackit/loginOption.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
// import 'package:location_permissions/location_permissions.dart';

class UpdateInfo extends StatefulWidget{
  AuthCredential googleAuthCredentials;
  UpdateInfo(this.googleAuthCredentials);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpdateInfoState(googleAuthCredentials);
  }
}

class UpdateInfoState extends State<UpdateInfo>{
  bool _isLoading = false;
  AuthCredential googleAuthCredentials;
  UpdateInfoState(this.googleAuthCredentials);
  
   Permission _permission = Permission.location;
   PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  StateModel appState;
  final _formKey = GlobalKey<FormState>();
  String _fathername;
  String _phoneNumber;
  String _finalPhone;
  String _smsCode;
  String _verificationId;

  String _errorMessage;
  
  String _addres="";
  bool _isVerified = false;
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _postalCodeController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();
  TextEditingController _studentNameController = new TextEditingController();
  bool _showOTPInputView= false;
  String finalPhoneNumber;

  String _stdError="";
  bool phoneTextFieldEnabled = true;
  bool addressTextFieldEnabled = true;

  UserAddress userAddress;


void _listenForPermissionStatus() async{
  final status = await _permission.status;
  setState(() {
    _permissionStatus = status;
  });
}

Future<void> requestPermission(Permission permission) async{
  final status = await permission.request();
  setState(() {
    _permissionStatus = status;
  });
}

Widget showVerifiedIcon(){
      if(_isVerified==false){
           return FlatButton(
        onPressed: (){
          setState(() {
            finalPhoneNumber = _phoneNumber;
          });
        if(finalPhoneNumber !=null){
            setState(() {
            _isLoading = true;
          });
        verifyPhone();
        }
      }, 
      child: Text("verify",style: TextStyle(color: Colors.blue),)
      );
      }else{
        return Icon(Icons.verified_user,color: Colors.green,size: 25,);
      }
}
 
// Widget showEmailVerifiedIcon(){
//       if(_isVerified==false){
//            return FlatButton(
//         onPressed: (){
//           setState(() {
//              phoneTextFieldEnabled = false;
//             _isLoading = true;
//           });
//       }, 
//       child: Text("verify",style: TextStyle(color: Colors.blue),)
//       );
//       }else{
//         return Icon(Icons.verified_user,color: Colors.green,size: 25,);
//       }
// }
 

  verify(AuthCredential credential) async{
    setState(() {
      _isLoading = true;
    });
        AuthResult result = await FirebaseAuth.instance.signInWithCredential(credential);
        // AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseUser user = result.user;
      if(user != null){
        await FirebaseAuth.instance.signInWithCredential(googleAuthCredentials).then((result){
          if(result.user!=null){
              UserUpdateInfo _userUpdateInfo = new UserUpdateInfo();
        _userUpdateInfo.displayName = _studentNameController.text;
           appState.user.updateProfile(_userUpdateInfo).then((onValue) async{
            FirebaseUser _user = await FirebaseAuth.instance.currentUser();
                appState.user = _user;    
          }) ;
               setState(() {
           _showOTPInputView = false;
           _isLoading = false;
           _isVerified = true;
           phoneTextFieldEnabled = false;
           appState.user = result.user;
         });
          }
        });
      }else{
        print("Error");
        setState(() {
          _isLoading = false;
        });
      }
  }

  
  Future<void> verifyPhone() async{

    final PhoneCodeAutoRetrievalTimeout _autoRetrieve= (String verId){
      this._verificationId = verId;
    };

    PhoneCodeSent smsCodeSent = (String verId,[int forceCodeSent]){
      this._verificationId = verId;
      setState(() {
        _showOTPInputView = true;
        _isLoading = false;
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential) async{
      setState(() {
        _isLoading = false;
      });
        verify(credential);
    };
    
    final PhoneVerificationFailed verifiedFailed = (AuthException exception){
      print('${exception.message}');
      setState(() {
        _errorMessage = exception.message;
        phoneTextFieldEnabled = true;
      });
    };

  String number = "+91"+this.finalPhoneNumber;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number, 
      timeout: const Duration(seconds:5), 
      verificationCompleted: verifiedSuccess, 
      verificationFailed: verifiedFailed, 
      codeSent: smsCodeSent, 
      codeAutoRetrievalTimeout: _autoRetrieve);
  }

    _validateAndSubmit() async{
    // if(_studentNameController.text != null && _addressController.text !=null) {
    if(_studentNameController.text != null && _fathername !=null && _isVerified && _addressController.text !=null) {
      try{
           if(userAddress == null ){
            try{
              var address = await Geocoder.local.findAddressesFromQuery(_addressController.text);
              var first = address.first;
              userAddress = new UserAddress(first.addressLine,first.adminArea,first.countryName,first.locality,first.postalCode,first.coordinates.latitude,first.coordinates.longitude);
            }catch(err){
               userAddress = new UserAddress(_addressController.text,null,"India",null,null,null,null);
            }       
           }
          StudentInfo studentInfo = new StudentInfo(appState.user.uid.toString(), appState.user.email.toString(), _studentNameController.text, _fathername, finalPhoneNumber, userAddress,"Null", false,true,null,null);
          Map<String,dynamic> mainData = studentInfo.getMap();
          setState(() {
            appState.studentInfo = studentInfo;
          });
          var json_data = jsonEncode(mainData);
         
          DocumentReference dr = await Firestore.instance.collection("URL").document('mainUrl');
          dr.get().then((value) async{
            var url = value.data['url'];
            if(url==""){
              CollectionReference cr = await Firestore.instance.collection("studentProfile");
              cr.add(mainData).then((value) => {
                studentInfo.documentID = value.documentID
              });
              
              setState(() {
                _isLoading = false;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home(true)));
            }else{
              try{
                   url +='addUser';
                var resp = await http.post(
                      url,
                    headers:{"Content-Type":"application/json"},
                    body:json_data,
                  );
                  print(resp.statusCode);
                  setState(() {
                    _isLoading = false;
                  });
                  if(resp.statusCode == 201){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home(true)));
                  }else{
                    setState(() {
                      _errorMessage = "Something went wrong";
                    });
                  }
              
              }catch(e){
                print(e);
                setState(() {
                  _errorMessage = "Connection Error";
                  _isLoading = false;
                });
              }           
            }
          });
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home(true)));
      }catch(err){
        print(err);
        setState(() {
          _isLoading = false;
          _errorMessage = "Error";
        });
      }
    }else{
      setState(() {
        _errorMessage= "Above Value can't be empty";
        _isLoading = false;
      });
      print("error");
    }
  }

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

  

  _showOTPInput(){
    if(_showOTPInputView == true){
       setState(() {
      _isLoading = false;
    });
         return Container(
           alignment: Alignment.centerRight,
           width: 20,
          child:ListTile(
  title: TextField(
    decoration: InputDecoration(
        labelText: "OTP"
    ),
    keyboardType: TextInputType.phone,
    onChanged: (value) => _smsCode = value,
    maxLength: 6,
  ),
  trailing: FlatButton(
    onPressed: () {
      setState(() {
        _isLoading = true;
      });
        AuthCredential credential = PhoneAuthProvider
        .getCredential(verificationId: _verificationId,
         smsCode: _smsCode);
      verify(credential);
      // verify();

  }, 
  child: Text("confirm",style: TextStyle(color:Colors.blue),)
  ),
)
         );
    }
    else{
      return Text("");
    }
  }

_showNumberInput(){
  return ListTile(
  leading: Icon(Icons.phone),
  title: TextField(
    enabled: phoneTextFieldEnabled,
    decoration: InputDecoration(
        labelText: "Phone Number"
    ),
    keyboardType: TextInputType.phone,
    onChanged: (value) => _phoneNumber = value,
    maxLength: 10,
  ),
  trailing: showVerifiedIcon(),
);
}
_showStudentNameInput(){
  return ListTile(
  leading: Icon(Icons.person),
  title: TextFormField(
    decoration: InputDecoration(
        labelText: "Student Name"
    ),
    keyboardType: TextInputType.text,
    controller: _studentNameController,
  ),
);
}

_showFatherNameInput(){
  return ListTile(
  leading: Icon(Icons.people),
  title: TextFormField(
    decoration: InputDecoration(
        labelText: "Father Name"
    ),
    keyboardType: TextInputType.text,
    onChanged: (value) => _fathername = value,
  ),
);
}

_showAddressInput(){
  return ListTile(
  leading: Icon(Icons.location_city),
  title: TextFormField(
    maxLines: 4,
    enabled: addressTextFieldEnabled,
    decoration: InputDecoration(
        labelText: "Address"
    ),
    controller: _addressController,
    keyboardType: TextInputType.text,
    onChanged: (value) => _addres = value,
  ),
  trailing: FlatButton(onPressed:(){
    setState(() {
      _isLoading = true;
    });
    _getCurrentLocation();
  }, child: Icon(Icons.add_location,size: 45,)),
);
}

// _showStandardInput(){
//   return ListTile(
//   leading: Icon(Icons.school),
//   title:  Column(children: [
//     new Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           new Radio(
//                             value: 1,
//                             groupValue: standardValue,
//                             onChanged: standardValueChangeHandler,
//                           ),
//                           new Text(
//                             '9',
//                             // style: new TextStyle(fontSize: 10.0),
//                           ),
//                              new Padding(
//                         padding: new EdgeInsets.all(10.0),
//                       ),
//                           new Radio(
//                             value: 2,
//                             groupValue: standardValue,
//                             onChanged: standardValueChangeHandler,
//                           ),
//                           new Text(
//                             '10',
//                             // style: new TextStyle(
//                             //   fontSize: 10.0,
//                             // ),
//                           ),
//                       //     new Padding(
//                       //   padding: new EdgeInsets.all(5.0),
//                       // ),
//                         ],
//                       ),
//                       new Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                             new Radio(
//                             value: 3,
//                             groupValue: standardValue,
//                             onChanged: standardValueChangeHandler,
//                           ),
//                           new Text(
//                             '11',
//                             // style: new TextStyle(fontSize: 10.0),
//                           ),
//                              new Padding(
//                         padding: new EdgeInsets.all(5.0),
//                       ),
//                           new Radio(
//                             value: 4,
//                             groupValue: standardValue,
//                             onChanged: standardValueChangeHandler,
//                           ),
//                           new Text(
//                             '12',
//                             // style: new TextStyle(
//                             //   fontSize: 10.0,
//                             // ),
//                           ),
//                         ],
//                       ),
 
 
//   ],)
// );
// }

  _showSubmitButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: SizedBox(
        height: 40,
        child: RaisedButton(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          color: primaryColor,
          child: Text("Submit",style: TextStyle(fontSize: 20,color: Colors.black),),
          onPressed: (){
            setState(() {
              _isLoading = true;
            });
            _validateAndSubmit();
          },
        ),
      ),
    );
  }

  _getCurrentLocation() async{
    await _listenForPermissionStatus();
    if(_permissionStatus == PermissionStatus.denied){
      requestPermission(_permission);
    }
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude,position.longitude);
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    setState(() {
      _addressController.text = first.addressLine.toString();
      _isLoading = false;
    });

    userAddress = new UserAddress(first.addressLine,first.adminArea,first.countryName,first.locality,first.postalCode,position.latitude,position.longitude);
  }


  // _getLocationButton(){
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
  //     child: SizedBox(
  //       height: 40,
  //       child: RaisedButton(
  //         elevation: 5,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30)
  //         ),
  //         color: primaryColor,
  //         child: Text("Get location",style: TextStyle(fontSize: 20,color: Colors.black),),
  //         onPressed: (){
  //           _getCurrentLocation();
  //         },
  //       ),
  //     ),
  //   );
  // }

//   String _email ='';
//   _showEmailInput(){
//      return ListTile(
//   leading: Icon(Icons.mail),
//   title: TextField(
//     enabled: phoneTextFieldEnabled,
//     decoration: InputDecoration(
//         labelText: "Email"
//     ),
//     keyboardType: TextInputType.phone,
//     onChanged: (value) => _email = value,
//     maxLength: 10,
//   ),
//   trailing: showEmailVerifiedIcon(),
// );
//   }

  _showForm(){
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
          _showStudentNameInput(),
          _showFatherNameInput(),
          _showNumberInput(),
          _showOTPInput(),
          _showAddressInput(),
          // _showStandardInput(),
          _showSubmitButton(),
          _showErrorMessage(),
        ],),
      ),
    );
  }

  _showCircularProcess(){
  if(_isLoading==true){
  return Center(child: CircularProgressIndicator(),);
  }else{
    return Container(height: 0,width: 0,);
  }
  }

  @override
  void initState() {
    // permissionOperation();
    setState(() {
      _isLoading = false;
      _errorMessage = "";
   });
    super.initState();
   
  }
  
  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    setState(() {
      _studentNameController.text = appState.user.displayName;
    });
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Colors.white,
        title: Text("Update info"),
      ),
      body:WillPopScope(
          onWillPop: (){
           new GoogleSignIn().signOut();
           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginOption()));
          },
          child: Stack(
      children: <Widget>[
        _showForm(),
        _showCircularProcess(),
      ],
    )
      ),
      );
  }
  
}




