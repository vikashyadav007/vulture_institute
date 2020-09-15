import 'package:firebase_auth/firebase_auth.dart';
import 'package:crackit/studentInfo.dart';


class StateModel{
  bool isloading;
  FirebaseUser user;
  StudentInfo studentInfo;
  
StateModel(
  {
    this.isloading = false,
    this.user,
  }
);
}