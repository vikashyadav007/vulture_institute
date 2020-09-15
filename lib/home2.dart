// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crackit/Address.dart';
// import 'package:crackit/Payment.dart';
// import 'package:crackit/Practice.dart';
// import 'package:crackit/Pricing.dart';
// import 'package:crackit/SplashView.dart';
// import 'package:crackit/TrialModeEndMessage.dart';
// import 'package:crackit/doubtsSelection.dart';
// import 'package:crackit/liveClasses.dart';
// import 'package:crackit/loginOption.dart';
// import 'package:crackit/stateModel.dart';
// import 'package:crackit/stateWidget.dart';
// import 'package:crackit/studentInfo.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:crackit/selectSubject.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:crackit/colorValue.dart';
// import 'package:crackit/values.dart';
// import 'package:crackit/showTrialDialog.dart';



// class Home extends StatefulWidget{
//   bool isVerified;
//   Home(this.isVerified);
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return HomeState(isVerified);
//   }
// }

// class HomeState extends State<Home>{
//   StateModel appState;
//   bool _isLoading = false;
//   bool _isVerified;
//   HomeState(this._isVerified);
//   StudentInfo student;

//   Widget singleView(var item){
// return Padding(
//   padding: EdgeInsets.all(15),
//   child:Card(
//     color:Colors.red,
//     elevation: 15,
//       child: 
//          Material(
//           child: InkWell(
//             onTap: ()=>  Navigator.push(context, (MaterialPageRoute(builder: (context) => item['methods'],))),
//             child: GridTile(
//               child:Container(
//                 color: primaryColor,
//                 child:
//               Column(
//                 children:[
//                   Expanded(
//                     flex: 2,
//                     child:Icon(item['image'],size: 60,color: Colors.blue,),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: 
//                    Container(
//                 // color: primaryColor,
//                 child: ListTile(
//                   title: Text(item["item"],
//                   style: TextStyle(
//                     color:Colors.black,
//                     fontWeight: FontWeight.w800,
//                   )
//                   ),
//                 ),
//               ),)
//                 ]
//               ),)
//             ),
//           ),
//         ),
//     ),);



//   }
                       
// var items=[
//     {"item":"Video Lectures","image":Icons.video_library,"methods":SelectSubject(VIDEOLECTURE)},
//     {"item":"Study Material","image":Icons.book,"methods":SelectSubject(STUDYMATERIAL)}, 
//     {"item":"Test Series","image":Icons.view_list,"methods":Practice()},
//     {"item":"Doubts","image":Icons.question_answer,"methods":DoubtSelection()},
//     {"item":"Test Series\n solutions","image":Icons.format_list_numbered,"methods":Practice()},
//     {"item":"Live Classes","image":Icons.desktop_windows,"methods":LiveClasses()},
// ];

//   _gridView(){
//       return 
      
//       Container(
//         color:Colors.white12,
//         child:GridView.builder(
//       itemCount: items.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//       itemBuilder: (BuildContext context,int index){
//         return singleView(items[index]);
//       },
//       )
//       );
//   }

//   _drawer(){
//     var style = TextStyle(fontSize: 20, color: Colors.black54);
//     return Drawer(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           ListView(
//             shrinkWrap: true,
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 child: DrawerHeader(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               image: appState.user.photoUrl ==null?AssetImage('assets/download.png'):
//                               NetworkImage(appState.user.photoUrl)),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 8),
//                       ),
//                       Text(
//                         appState.user.displayName,
//                         style: TextStyle(fontSize: 15, color: Colors.black),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 8),
//                       ),
//                       Text(
//                         appState.user.email,
//                           style: TextStyle(fontSize: 12, color: Colors.black))
//                     ],
//                   ),
//                   decoration: BoxDecoration(color: primaryColor),
//                 ),
//               )
//             ],
//           ),
//           Expanded(
//             child: ListView(children: <Widget>[
 
//             Container(
//               //color: Colors.green[200],
//               child: Column(
//                 children: <Widget>[
//                   ListTile(
//                     title: Text(
//                       'View Info',
//                       style: style,
//                     ),
//                     trailing: Icon(Icons.info),
//                     onTap: () {
//                     //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewInfo()));
//                     },
//                   ),
//                   Divider(
//                     height: 4,
//                   ),
//                   ListTile(
//                     title: Text(
//                       'Contact us',
//                       style: style,
//                     ),
//                     trailing: Icon(Icons.phone),
//                   ),
//                   Divider(
//                     height: 4,
//                   ),
//                   ListTile(
//                     title: Text(
//                       'About us',
//                       style: style,
//                     ),
//                     trailing: Icon(Icons.account_circle),
//                   ),
                  
//                   Divider(
//                     height: 4,
//                   ),
//                    ListTile(
//                      onTap: (){
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
//                      },
//                     title: Text(
//                       'Pay fee',
//                       style: style,
//                     ),
//                     trailing: Icon(Icons.payment),
//                   ),
//                   Divider(
//                     height: 4,
//                   ),
//                    ListTile(
//                      onTap: (){
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Pricing()));
//                      },
//                     title: Text(
//                       'Pricing',
//                       style: style,
//                     ),
//                     trailing: Icon(Icons.attach_money),
//                   ),
//                 ],
//               ),
//             ),
//              ],),
//             flex: 5,
//           ),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: 50,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(bottom: 10),
//                 color: primaryColor,
//                 child: FlatButton(
//                     onPressed: () {
//                       //FirebaseAuth.instance.signOut();
//                       new GoogleSignIn().signOut();
//                       appState.user = null;
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginOption()));
//                     },
//                     child: ListTile(
//                       title: Text(
//                         'Log out',
//                         style: TextStyle(fontSize: 25, color: Colors.black54),
//                       ),
//                       trailing: Icon(Icons.power_settings_new),
//                     )),
//               ),
//             ),
//             flex: 1,
//           ),
//         ],
//       ),
//     );
//   }

// _fetchFirestoreData() async{
//     Firestore.instance
//     .collection('studentProfile')
//     .where("email",isEqualTo: appState.user.email)
//     .snapshots()
//     .listen((data) {
//       if(data.documents.length==0){
//         new GoogleSignIn().signOut();
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginOption()));
//       }else{
//        data.documents.forEach((element) {
//          Map<String,dynamic> map = element.data;
//         UserAddress useraddress = new UserAddress(map['address']['fullAddress'], map['address']["state"], map['address']["country"], map['address']["district"], map['address']["postalCode"], map['address']["latitude"], map['address']["longitude"]);
         
//           student = new  StudentInfo(
//            map['uid'], 
//            map['email'],
//             map['studentName'], 
//             map['fatherName'], 
//             map['phoneNumber'], 
//             useraddress, 
//             map['standard'], 
//             map['Subscribed'].toString().compareTo("true")==0?true:false,
//             map['trialPeriod'].toString().compareTo("true")==0?true:false,
//             );

//        });
//            setState(() {
//              _isVerified = true;
//             _isLoading = false;
//             appState.studentInfo = student;
//             });
//       }
//      });



   
//   }

//  Widget _buildContent(){
//       if(appState.isloading==true || _isLoading ==true){
//         return _buildLoadingContainer();
//       }else
//       if(!appState.isloading && appState.user==null){
//         return new LoginOption();
//       }else{
//         if(_isVerified==false){
//           setState(() {
//            _isLoading = true;
//           });
//           _fetchFirestoreData();
//           return _buildLoadingContainer();
//         }else{
//           if(appState.studentInfo.isSubscribed==false){
//             if(appState.studentInfo.trialPeriod==true){
//              Future.delayed(Duration(seconds: 2),(){
//                 // showTrialDialog(context);
//           });
//             return _buildstory();
//           }else{
//            return Scaffold(

//         drawer: _drawer(),
//     appBar: AppBar(
//       title: Text("Vulture Institute"),
//     ),
//     body:
//     WillPopScope(
//       onWillPop: (){
//         exit(0);
//       },
//       child:
//       Padding(
//         padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        
//       child: TrialModeEndMessage(),)
    
//     )
//     );
     
//           }
//           }else{
//                return _buildstory();
//           }
         
         
         
//         }
//       }
//     }

//     Widget newView(){
//       return ListView(
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
//             height:150,
//             width:double.infinity,
//             child:Image.asset("assets/logo3.png",fit:BoxFit.contain),
//           ),
          
//         ],
//       );
//     }

//     Widget _buildstory({Widget body}){
//       return  Scaffold(
//         drawer: _drawer(),
//     body:
//     WillPopScope(
//       onWillPop: (){
//         exit(0);
//       },
//       child:
//       Padding(
//         padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        
//       child:newView())
    
//     )
//     );
     
//     }


//      Widget  _buildLoadingContainer(){
//       return Stack(
//             children:[
//                SplashView(),
//                Center(
//                   child: CircularProgressIndicator(),
//                   )
//             ]
//           );
//     }


//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     appState = StateWidget.of(context).state;
//     return _buildContent();
//   }
// }