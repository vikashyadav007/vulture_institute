import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/colorValue.dart';
import 'package:crackit/home.dart';
import 'package:crackit/paymentSchema.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:crackit/studentInfo.dart';
import 'package:crackit/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Payment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }
}

class Coupon{
  String code;
  int discount;
  bool used;
  bool gst;
  Coupon(String code,String discount,bool used,bool gst){
    this.code = code;
    this.discount = int.parse(discount.toString());
    this.used = used;
    this.gst = gst;
  }


  getMap(){
    Map<String,dynamic> map={
      'code':code,
      'discount':discount,
      'used':used,
      'gst':gst,
    };
    return map;
  }
}

class PaymentState extends State<Payment>{
  StateModel appState;
  bool _isLoading = false;
  StudentInfo student;
  String _errorMessage=''; 
   TextEditingController _couponController = new TextEditingController();

  bool viewCoupon= false;
  String final_course='';
  String final_type='';
  String final_standard='';
  String final_subject='';
  String merchantKey='';
  String couponUsed='';

  bool payButtonShow = false;

  Map<String,dynamic> iitjeeSubjectwise;
  Map<String,dynamic> iitjeeComplete;
  Map<String,dynamic> neetSubjectwise;
  Map<String,dynamic> neetComplete;
  Map<String,dynamic> otherSubjectwise;
  Map<String,dynamic> otherComplete;
  int count =0;

   int courseValue=-1;
   int choiceValue=-1;
   int subjectValue=-1;
   int durationValue=-1;
   int completeValue=-1;
   
   String finalSummary='';
   String finalPrice = '';

  Razorpay _razorpay;

  static const platform = const MethodChannel('razorpay_flutter');

  List<Coupon> listCoupon=[];
  
  @override
  void initState() {
    super.initState();
     setState(() {
      _isLoading = true;
    });

    getData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  getData() async{
     await getKey();
     await getCoupon();
      await getIITJEE();
      await getNEET();
      await getOther();   
    return;
  }

output(){
    print(iitjeeSubjectwise);
    print(iitjeeComplete);
    print(neetSubjectwise);
    print(neetComplete);
    print(otherSubjectwise);
    print(otherComplete);
  }

  getCoupon() async{
      Firestore.instance
        .collection('Coupon')
        .snapshots()
        .listen((data) {
          data.documents.forEach((element) {
            print(element.data);
            Map<String,dynamic> data = element.data;
            listCoupon.add(new Coupon(data['code'],data['discount'].toString(),data['used'],data['gst']));
          });
        });

        listCoupon.forEach((element) { 
          print(element.getMap().toString());
        });
  }

  getKey() async{
    DocumentReference dr = await Firestore.instance.collection("URL").document('key');
    dr.get().then((value){
      var data = value.data['merchantKey'];
        merchantKey = data;
        count++;
          if(count == 4){
            setState(() {
      _isLoading = false;
    });
        }
    });
  }

  getIITJEE() async{
    Firestore.instance.collection('pricing')
  .document('IIT-JEE')
  .snapshots()
    .listen((result) { 
        iitjeeSubjectwise = result.data['subjectwise'];
        iitjeeComplete = result.data['complete'];
        count++;
        if(count == 4){
            setState(() {
      _isLoading = false;
    });
        }
        return;
    });
  }

  getNEET() async{
     Firestore.instance.collection('pricing')
  .document('NEET')
  .snapshots()
    .listen((result) { 
        neetSubjectwise = result.data['subjectwise'];
        neetComplete = result.data['complete'];
    });
    count++;
        if(count == 4){
            setState(() {
      _isLoading = false;
    });
        }
    return;
  }

  getOther() async{
     Firestore.instance.collection('pricing')
  .document('OTHER')
  .snapshots()
    .listen((result) { 
        otherSubjectwise = result.data['subjectwise'];
        otherComplete = result.data['complete'];
    });
        count++;
        if(count == 4){
            setState(() {
      _isLoading = false;
    });
        }
    return;
  }


  void courseValueChangeHandler(int value){
    setState(() {
      courseValue = value;
      choiceValue = -1;
      subjectValue = -1;
      durationValue = -1;
      completeValue = -1;
      payButtonShow = false;
      viewCoupon=false;
      // if(courseValue==1 || courseValue==6){
      //   choiceValue = 2;
      // }
    });
  }
  void choiceValueChangeHandler(int value){
    setState(() {
      choiceValue = value;
      subjectValue = -1;
      durationValue = -1;
      completeValue = -1;
      payButtonShow = false;
    });
  }
  void subjectValueChangeHandler(int value){
    setState(() {
      subjectValue = value;
      durationValue = -1;
      completeValue = -1;
      payButtonShow = false;
    });
  }
  void durationValueChangeHandler(int value){
    setState(() {
      durationValue = value;
      completeValue = -1;
      payButtonShow = false;
    });
  }
  void completeValueChangeHandler(int value){
    setState(() {
      completeValue = value;
      subjectValue= -1;
      payButtonShow = false;
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

 Widget choiceView(){
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
                                      new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             new Radio(
                                                value: 1,
                                                groupValue: choiceValue,
                                                onChanged: choiceValueChangeHandler,
                                              ),
                                              new Text(
                                                'Subject Wise',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Radio(
                                                value: 2,
                                                groupValue: choiceValue,
                                                onChanged: choiceValueChangeHandler,
                                              ),
                                              new Text(
                                                'Complete',
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
 Widget subjectIITView(){
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
                                        'Subjects:',
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
                                                '11 physics',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 6,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '12 physics',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),                                      
                                      new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             new Radio(
                                                value: 2,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '11 Chemistry',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 7,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '12 Chemistry',
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
                                                '11 Maths',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 8,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '12 Maths',
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
  
 Widget subjectNEETView(){
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
                                        'Subjects:',
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
                                                '11 physics',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 6,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '12 physics',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),                                      
                                      new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             new Radio(
                                                value: 2,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '11 Chemistry',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 7,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '12 Chemistry',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),                                      
                                      new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             new Radio(
                                                value: 4,
                                               groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '11 Zoology',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 9,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '12 Zoology',
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
                                                '11 Botney',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 10,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                '12 Botney',
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
 Widget subjectOTHERView(){
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
                                        'Subjects:',
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
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
                                                'Science',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 12,
                                                groupValue: subjectValue,
                                                onChanged: subjectValueChangeHandler,
                                              ),
                                              new Text(
                                                'GK',
                                                style: new TextStyle(fontSize: 16.0),
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
                                                'psychology',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 14,
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
 Widget durationIITView(){
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
                                        'Duration:',
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
                                                groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                'Month',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 2,
                                               groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                '3 Month',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),                                      
                                      new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             new Radio(
                                                value: 3,
                                                groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                '6 Month',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 4,
                                                groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                'Year',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),                                                                                                         
                                      new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             new Radio(
                                                value: 5,
                                                groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                '2 Year',
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
  
 Widget durationNEETView(){
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
                                        'Duration:',
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
                                                groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                'Month',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 2,
                                                groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                '3 Month',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),                                      
                                      new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             new Radio(
                                                value: 3,
                                                groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                '6 Month',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 4,
                                               groupValue: durationValue,
                                                onChanged: durationValueChangeHandler,
                                              ),
                                              new Text(
                                                'Year',
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

 Widget completeIITView(){
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
                                        'Standard:',
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
                                               groupValue: completeValue,
                                               onChanged: completeValueChangeHandler,
                                              ),
                                              new Text(
                                                '11',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 4,
                                                groupValue: completeValue,
                                                onChanged: completeValueChangeHandler,
                                              ),
                                              new Text(
                                                '12',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 8,
                                                groupValue: completeValue,
                                                onChanged: completeValueChangeHandler,
                                              ),
                                              new Text(
                                                'Target',
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
 Widget completeCBSEView(){
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
                                        'Standard:',
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
                                               groupValue: completeValue,
                                               onChanged: completeValueChangeHandler,
                                              ),
                                              new Text(
                                                '9',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                             new Radio(
                                                value: 2,
                                                groupValue: completeValue,
                                                onChanged: completeValueChangeHandler,
                                              ),
                                              new Text(
                                                '10',
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
 Widget completeOTHERView(){
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
                                        'Other Competitive Exams:',
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
                            groupValue: completeValue,
                            onChanged: completeValueChangeHandler,
                          ),
                          new Text(
                            'REET(science/maths)',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                           new Radio(
                            value: 7,
                            groupValue: completeValue,
                            onChanged: completeValueChangeHandler,
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
                            groupValue: completeValue,
                            onChanged: completeValueChangeHandler,
                          ),
                          new Text(
                            'REET(sst)',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                            new Radio(
                            value: 10,
                            groupValue: completeValue,
                            onChanged: completeValueChangeHandler,
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
                            groupValue: completeValue,
                            onChanged: completeValueChangeHandler,
                          ),
                          new Text(
                            'Constable',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                            new Radio(
                            value: 11,
                            groupValue: completeValue,
                            onChanged: completeValueChangeHandler,
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




 @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }


void openCheckout(var amount,String description){
  if(merchantKey==''){
    _errorMessage="Something went Wrong";
  }else{
       var options={
    'key':merchantKey,
    'amount':amount*100,
    'name':'vulture Institute',
    'description':description,
    'prefill':{'contact':appState.studentInfo.phoneNumber,'email':appState.studentInfo.email},
    'external':{
      'wallets':['paytm'],
    },
  };
  try{
    _razorpay.open(options);
  }catch(e){
    debugPrint(e);
  }
  }
 
}

  
void _handlePaymentSuccess(PaymentSuccessResponse response){
      print(response.signature);
      print("\n\n\n");
      print("This comes here very well");
      PaymentDescription paymentDescription = 
      new PaymentDescription(final_course, final_type, final_standard,final_subject);
      var date = new DateTime.now();
      // print(duration)
      var value = durationMap[paymentDuration[durationValue-1]];
      var newDate = new DateTime(date.year,date.month+value,date.day);
      print(newDate);
      PaymentSchema paymentSchema = new PaymentSchema(
        response.paymentId,
      response.orderId,
      appState.studentInfo.uid, 
      new DateTime.now(), newDate, 
      finalPrice.toString(),
       "Success", 
       paymentDescription);

      print(paymentSchema.getMap());

      CollectionReference cr =  Firestore.instance.collection("payments");
      cr.add(paymentSchema.getMap());

      List<dynamic> list =appState.studentInfo.paymentSchema;
      print(appState.studentInfo.paymentSchema);
      print(list);
      if(list == null){
        list = [];
      }
      // print("\n\n\n\n\n");
      // print(list);
      list.add(paymentSchema.getMap());
      // print(list);
      Map<String,dynamic> finalMap = {'payments':list,'Subscribed':true};
      Firestore.instance
      .collection('studentProfile')
      .document(appState.studentInfo.documentID)
      .updateData(finalMap);

      if(couponUsed !=''){

      Firestore.instance
      .collection('Coupon')
      .where('code',isEqualTo: couponUsed)
      .snapshots()
      .listen((event) {
        event.documents.forEach((element) { 
          Map<String,dynamic> map = element.data;
          map['used']=true;
          Firestore.instance.collection('Coupon').document(element.documentID).updateData(map);
        });
      });
      }

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(false)));
      Fluttertoast.showToast(msg: "SUCCESS "+ response.paymentId);






}
void _handlePaymentError(PaymentFailureResponse response){

   FailPaymentSchema failPaymentSchema = new  FailPaymentSchema(
    response.code, 
    response.message,
    appState.studentInfo.uid,
     new DateTime.now(), finalPrice);
  print(failPaymentSchema.getMap());
     CollectionReference cr =  Firestore.instance.collection("failed-payments");
    cr.add(failPaymentSchema.getMap());
 
  Fluttertoast.showToast(msg: "ERROR "+ response.code.toString() + '-' + response.message);
}
void _handleExternalWallet(ExternalWalletResponse response){
  Fluttertoast.showToast(msg: "EXTERNAL WALLET "+ response.walletName);
}

courseViewHandler(){
  if(courseValue==-1 || courseValue==1 || courseValue == 6){
    return Text("");
  }else{
    return choiceView();
  }
}

choiceViewHandler(){
  //Subject Wise
  if(choiceValue==1 && courseValue!= -1){
    if(courseValue==3){
      return subjectIITView();
    }else if(courseValue ==4){
      return subjectNEETView();
    }else if(courseValue == 5){
      return subjectOTHERView();
    }else{
      return Text("");
    }
  }else 
  //Complete
  if(choiceValue ==2 && courseValue != -1){
    if(courseValue==3 || courseValue ==4){
      return completeIITView();
    }else if(courseValue ==5){
      return completeOTHERView();
    }else{
      return Text("");
    }
  }else
  //CBSE or RBSE
  if(courseValue==1 || courseValue==6){
      return completeCBSEView();
  }else
  {
    return Text("");
  }
}


durationViewHandler(){
  if(courseValue == 3 && choiceValue !=-1 && subjectValue != -1){
    return durationIITView();
  }else if(courseValue == 4 && choiceValue !=-1 && subjectValue != -1){
    return durationNEETView();
  }else {
    return Text("");
  }
}

fetchPrice(){
  final_course = course[courseValue-1];
  // final_type = paymentChoiceOption[choiceValue-1];

  String summary = '';
  summary +="You have selected ";
  if(courseValue==1 || courseValue==6){
    final_type = paymentChoiceOption[1];
    summary +=courseValue==1?"CBSE":"RBSE";
    final_standard = standard[completeValue-1];
      summary += "\nComplete Subjects";
      summary += " \nFor class :"+ standard[completeValue-1];
      var price = "1000";
      setState(() {
        finalPrice = price;
      });
      summary += "\nYour Price is : " + price.toString();
  }
  if(courseValue==3){
    final_type = paymentChoiceOption[choiceValue-1];
    summary += "IIT-JEE \n";
    if(choiceValue ==1){
      final_standard = paymentSubjectOption[subjectValue-1].substring(0,2);
      final_subject = paymentSubjectOption[subjectValue-1].substring(2);
      summary += "Subject : " +paymentSubjectOption[subjectValue-1];
      summary +="\nFor Duration: "+ paymentDuration[durationValue-1];
      var price = iitjeeSubjectwise[paymentDuration[durationValue-1].toString()]['physics'];
      setState(() {
        finalPrice = price.toString();
      });
      summary += "\nYour Price is : " + price.toString();
    }else if(choiceValue ==2){
      final_standard = standard[completeValue-1];
      summary += "\nComplete Subjects";
      summary += " \nFor class :"+ standard[completeValue-1];
      var price = iitjeeComplete[standard[completeValue-1]+'pcm/year'].toString();
      setState(() {
        finalPrice = price;
      });
      summary += "\nYour Price is : " + price.toString();

    }
  }else if(courseValue==4){
    final_type = paymentChoiceOption[choiceValue-1];
    summary += "NEET";
     if(choiceValue ==1){
       final_standard = paymentSubjectOption[subjectValue-1].substring(0,2);
      final_subject = paymentSubjectOption[subjectValue-1].substring(2);
       summary += "Subject : " +paymentSubjectOption[subjectValue-1];
      summary +="\nFor Duration: "+ paymentDuration[durationValue-1];
      var price = neetSubjectwise[paymentDuration[durationValue-1].toString()]['physics'];
      setState(() {
        finalPrice = price.toString();
      });
      summary += "\n Your Price is : " + price.toString();
    }else if(choiceValue ==2){
      final_standard = standard[completeValue-1];
      summary += "\nComplete Subjects";
      summary += " \nFor class :"+ standard[completeValue-1];
      var price = neetComplete[standard[completeValue-1]+'pcbz/year'];
      setState(() {
        finalPrice = price;
      });
      summary += "\nYour Price is : " + price.toString();
    }
  }else if(courseValue==5){
    final_type = paymentChoiceOption[choiceValue-1];
    summary += "OTHER COMPETITIVE EXAMS";
     if(choiceValue ==1){
       final_subject = paymentSubjectOption[subjectValue-1];
      summary += "Subject : " + paymentSubjectOption[subjectValue-1];
      var price = otherSubjectwise[paymentSubjectOption[subjectValue-1]];
      setState(() {
        finalPrice = price.toString();
      });
      summary += "\nYour Price is : " + price.toString();
      print("This all works fine till here");
    }else if(choiceValue ==2){
      final_standard = standard[completeValue-1];
      summary += "\nComplete Subjects";
      summary += " \nFor class :"+ standard[completeValue-1];
      var value = otherComplete[standard[completeValue-1]];
      var price = (int.parse(value['price'])-int.parse(value['discount'])).toString();
      setState(() {
        finalPrice = price.toString();
      });
      summary += "\nYour Price is : " + price.toString();
    }
  }
  setState(() {
    finalSummary = summary;
    payButtonShow = true;
    viewCoupon = true;
  });
  print(finalPrice);
  print(finalSummary);
  if(choiceValue == 2 || courseValue == 5 || courseValue == 1 ||courseValue == 6 ){  
    durationValue =4;
  }
}

Widget fetchBalanceButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 25.0, 15, 10.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: primaryColor,
            child: new Text('fetch',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
              if((courseValue==1 ||courseValue==6) && completeValue!=-1){
                print("All Works fine");
                fetchPrice();
              }else
              if(courseValue != -1 && choiceValue != -1){
                if (choiceValue==1 && subjectValue!= -1 && durationValue !=-1){
                  print("All Works fine");
                  fetchPrice();
                }else if(choiceValue==2 && completeValue !=-1){
                  fetchPrice();
                    print("All Works fine");
                }else if(courseValue == 5 && ((choiceValue ==1 && subjectValue != -1) || (choiceValue ==2 && completeValue != -1) )){
                  fetchPrice();
                  print("All Works fine");
                }
                else {
                   _errorMessage="Select above value";
                }  
              }else{
                setState(() {
                  _errorMessage="Select above value";
                });
                  
              }
            },
          ),
        ));
  }
Widget payButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 25.0, 15, 10.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: primaryColor,
            child: new Text(' pay   \u{20B9}$finalPrice',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
             openCheckout(int.parse(finalPrice), finalSummary);
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


     Widget  _buildLoadingContainer(){
      return 
          Center(
             child: CircularProgressIndicator(),
             );
    }

payButtonHandler(){
  if(payButtonShow==false){
    return fetchBalanceButton();
  }else{
    return payButton();
  }
}
cbseCompleteHandler(){
  if((courseValue==1 || courseValue==6)&& completeValue != -1){
    return 
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
                              Padding(
                                padding: EdgeInsets.all(15),
                              child: Text("Complete For Year"),),
                        ),
                    ),
                ),
            ),
    );

  }else{
    return Text("");
  }
}

couponViewButton(){
  if((courseValue == 3 || courseValue==4) && viewCoupon==true && choiceValue==2){
    return  ListTile(
  leading: Icon(Icons.person),
  title: TextFormField(
    decoration: InputDecoration(
        labelText: "Coupon Code"
    ),
    keyboardType: TextInputType.text,
    style: TextStyle(),
    controller: _couponController,
  ),
  trailing: FlatButton(
    child: Text("apply"),
  onPressed: (){
    var code = _couponController.text;
    bool flag = false;
    listCoupon.forEach((element) { 
      if(element.code.compareTo(code)==0 && element.used==false){
        setState(() {
          _errorMessage="";
        });
        flag = true;
        double gst = ((int.parse(finalPrice)*18)/100);
         double price = int.parse(finalPrice) - gst;
         print(price);
         double discounedPrice = price - (price * element.discount/100);
         print(discounedPrice);
         var finalP;
         if(element.gst==true){
           finalP = discounedPrice + gst;
           finalP = finalP.round();
         }else{
           finalP = discounedPrice.round();
         }
         if(finalP==0){
           finalP = 1;
         }
         print(finalP);
         setState(() {
           finalPrice = finalP.toString();
           couponUsed = element.code;
           viewCoupon = false;
         });
         return;
      }
    });

    if(flag==false){
      setState(() {
        _errorMessage = "Invalid Code";
      });
    }
  },),
);
  }else{
    return Text("");
  }
}

     Widget _buildContent(){
      if(_isLoading==true ){
        return _buildLoadingContainer();
      }else{
        // output();
         return ListView(
                 children: [
                       courseView(),
                       courseViewHandler(),
                       choiceViewHandler(),
                       durationViewHandler(),
                       cbseCompleteHandler(),
                       couponViewButton(),
                       payButtonHandler(),
                       _showErrorMessage(),
                 ],
             );
    }
 }

  Widget _buildstory({Widget body}){
      return  Scaffold(
         appBar: AppBar(
               title: Text("Payment"),
        ),
          body: Padding(
               padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
             child: _buildContent(),
         )
      );
     
    }


  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return _buildstory();
  }

}