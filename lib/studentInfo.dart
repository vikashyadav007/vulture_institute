 import 'package:crackit/Address.dart';
import 'package:crackit/paymentSchema.dart';

class StudentInfo{
   String uid;
   String email;
   String studentName;
   String fatherName;
   String phoneNumber;
   UserAddress userAddress;
   bool isSubscribed;
   String standard;
   bool trialPeriod;
   String documentID;
   List<dynamic> paymentSchema;

   StudentInfo(this.uid,this.email,this.studentName,this.fatherName,this.phoneNumber,this.userAddress,this.standard,this.isSubscribed,this.trialPeriod,this.documentID,this.paymentSchema);
 
  Map<String,dynamic> getMap() {
    Map<String,dynamic> map = {
            "uid":uid,
            "email":email,
            "studentName":studentName,   
            "fatherName":fatherName,
            "phoneNumber":phoneNumber,
            "address":userAddress.getMap(),
            "standard":standard,
            "Subscribed":isSubscribed,
            "trialPeriod":trialPeriod,
            'documentID':documentID,
            'payments':paymentSchema,
    };
    return map;
  }


  void fromMap(Map<String,dynamic> map){
    this.userAddress = new UserAddress(map['address']['fullAddress'], map['address']["state"], map['address']["country"], map['address']["district"], map['address']["postalCode"], map['address']["latitude"], map['address']["longitude"]);
    this.email = map['email'];
    this.uid = map['uid'];
    this.phoneNumber = map['phoneNumber'];
    this.studentName = map['studentName'];
    this.fatherName = map['fatherName'];
    this.isSubscribed = map['subscribed'];
    this.standard = map['standard'];
    this.trialPeriod = map['trialPeriod'];
  }
 
 }
 
 
 
 
 
 
 
 