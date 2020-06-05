import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/DoubtsLanding.dart';
import 'package:crackit/FirebaseRealTimeDemo.dart';
import 'package:crackit/Practice.dart';
import 'package:crackit/SplashView.dart';
import 'package:crackit/demoClasses.dart';
import 'package:crackit/doubts.dart';
import 'package:crackit/doubtsSelection.dart';
import 'package:crackit/liveClasses.dart';
import 'package:crackit/loginOption.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crackit/updateInfo.dart';
import 'package:crackit/selectSubject.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crackit/colorValue.dart';

import 'package:crackit/values.dart';



class Home extends StatefulWidget{
  bool isVerified;
  Home(this.isVerified);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState(isVerified);
  }
}

class HomeState extends State<Home>{
  static StateModel appState;
  bool _isLoading = false;
  bool _isVerified;
  HomeState(this._isVerified);

  Widget singleView(var item){

return Padding(
  padding: EdgeInsets.all(15),
  child:Card(
    color:Colors.red,
    elevation: 15,
      child: 
         Material(
          child: InkWell(
            onTap: ()=>  Navigator.push(context, (MaterialPageRoute(builder: (context) => item['methods'],))),
            child: GridTile(
              
              // footer: Container(
              //   color: primaryColor,
              //   child: ListTile(
              //     title: Text(item["item"],
              //     style: TextStyle(
              //       color:Colors.white,
              //       fontWeight: FontWeight.w800,
              //     )
              //     ),
              //   ),
              // ),
              // child: Image.asset(item["image"],fit: BoxFit.cover,),
              child:Container(
                color: primaryColor,
                child:
              Column(
                children:[
                  Expanded(
                    flex: 2,
                    //child: Image.asset(item["image"],width: 80,height: 80,)
                    
                    child:Icon(item['image'],size: 60,color: Colors.blue,),
                    ),
                    Expanded(
                      flex: 1,
                      child: 
                   Container(
                // color: primaryColor,
                child: ListTile(
                  title: Text(item["item"],
                  style: TextStyle(
                    color:Colors.black,
                    fontWeight: FontWeight.w800,
                  )
                  ),
                ),
              ),)
                ]
              ),)
            ),
          ),
        ),
    ),);



    //  return Card(
    //   child: Hero(
    //     tag: item,
    //     child: Material(
    //       child: InkWell(
    //         onTap: ()=> null,
    //         child: GridTile(
              
    //           child: 
    //          GestureDetector(
    //            onTap: (){
    //              Navigator.push(context, (MaterialPageRoute(builder: (context) => item['methods'],)));
    //            },
    //            child:
    //             Container( 
    //             color:item["color"],
    //             child:
    //             Center(
    //             child:Text(item["item"],
    //               style: TextStyle(
    //                color:Colors.black,
    //                 fontWeight: FontWeight.w800,
    //                 fontSize: 35,
    //               )
    //               ), 
    //           )
    //           ),
    //          ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
                       
var items=[
  //Icons.airplay
    {"item":"Video Lectures","image":Icons.video_library,"methods":SelectSubject(VIDEOLECTURE)},
    {"item":"Study Material","image":Icons.book,"methods":SelectSubject(STUDYMATERIAL)}, 
    {"item":"Test Series","image":Icons.view_list,"methods":Practice()},
    {"item":"Doubts","image":Icons.question_answer,"methods":DoubtSelection()},
    {"item":"Test Series\n solutions","image":Icons.format_list_numbered,"methods":Practice()},
    {"item":"Live Classes","image":Icons.desktop_windows,"methods":LiveClasses()},
];
// var items=[
//     {"item":"Video Lectures","image":"assets/education.png","methods":SelectSubject("Video Lectures")},
//     {"item":"Study Material","image":"assets/2material.png","methods":SelectSubject("Study Material")}, 
//     {"item":"Test Series","image":"assets/2exam2.png","methods":SelectSubject("Test Series")},
//     {"item":"Doubts","image":"assets/2qa.png","methods":Doubts()},
//     {"item":"Test Series\n solutions","image":"assets/2qaAns.png","methods":Practice()},
//     {"item":"Live Classes","image":"assets/2online.png","methods":LiveClasses()},
// ];
// var items=[
//     {"item":"Video Lectures","image":"assets/elearning-2.png","methods":SelectSubject("Demo Classes")},
//     {"item":"Study Material","image":"assets/study-1.png","methods":SelectSubject("Study Material")}, 
//     {"item":"Test Series","image":"assets/learning.png","methods":SelectSubject("Dpp")},
//     {"item":"Doubts","image":"assets/qa-1.png","methods":Doubts()},
//     {"item":"Test Series\n solutions","image":"assets/test.png","methods":Practice()},
//     {"item":"Live Classes","image":"assets/online-learning-1.png","methods":LiveClasses()},
// ];
// var items=[
//     {"item":"Study Material","color":Colors.amber,"methods":SelectSubject("Study Material")}, 
//     {"item":"DPP","color":Colors.lightGreen,"methods":SelectSubject("Dpp")},
//     {"item":"Practice","color":Colors.lightGreen,"methods":Practice()},
//     {"item":"Doubts","color":Colors.amber,"methods":Doubts()},
//     {"item":"Live Classes","color":Colors.amber,"methods":LiveClasses()},
//      {"item":"Demo Classes","color":Colors.lightGreen,"methods":SelectSubject("Demo Classes")},

// ];


  _gridView(){
      return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context,int index){
        return singleView(items[index]);
      },
      );
  }

  _drawer(){
    var style = TextStyle(fontSize: 20, color: Colors.black54);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: appState.user.photoUrl ==null?AssetImage('assets/download.png'):
                              NetworkImage(appState.user.photoUrl)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Text(
                        appState.user.displayName,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Text(appState.user.email,
                          style: TextStyle(fontSize: 12, color: Colors.black))
                    ],
                  ),
                  decoration: BoxDecoration(color: primaryColor),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(children: <Widget>[
 
            Container(
              //color: Colors.green[200],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Update Info',
                      style: style,
                    ),
                    trailing: Icon(Icons.info),
                    onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateInfo()));
                    },
                  ),
                  Divider(
                    height: 4,
                  ),
                  ListTile(
                    title: Text(
                      'Contact us',
                      style: style,
                    ),
                    trailing: Icon(Icons.phone),
                  ),
                  Divider(
                    height: 4,
                  ),
                  ListTile(
                    title: Text(
                      'About us',
                      style: style,
                    ),
                    trailing: Icon(Icons.account_circle),
                  ),
                  
                  Divider(
                    height: 4,
                  ),
                ],
              ),
            ),
             ],),
            flex: 5,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                color: primaryColor,
                child: FlatButton(
                    onPressed: () {
                      //FirebaseAuth.instance.signOut();
                      new GoogleSignIn().signOut();
                      appState.user = null;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginOption()));
                    },
                    child: ListTile(
                      title: Text(
                        'Log out',
                        style: TextStyle(fontSize: 25, color: Colors.black54),
                      ),
                      trailing: Icon(Icons.power_settings_new),
                    )),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

_fetchFirestoreData() async{
    // setState(() {
    //   appState.isloading = true;
    // });
    var data =  Firestore.instance.collection("Student Info").document("ONnnBBbXJTOVMTDmODqs");
    data.get().then((value){
       if(value.data == null){
         setState(() {
           appState.isloading = false;
         });
         Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateInfo()));
        }
        else{
          setState(() {
          Map<String,dynamic> mapValue = value.data;
          List<String> uidList = mapValue.keys.toList();
          String userUid = appState.user.uid.toString();
          bool flag = false;
          for(String id in uidList){
              if(id.compareTo(userUid)==0){
                
               flag = true;
               break;
              }
          }
          if(flag==true){
            setState(() {
             _isVerified = true;
             appState.isloading = false;
              //print("This comes here also 245 ");
            });
          }else{
               Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateInfo()));
          }
          });
        }     
    });
  }



 Widget _buildContent(){
   print(_isVerified);
      if(appState.isloading==true){
        return _buildLoadingContainer();
      }else
      if(!appState.isloading && appState.user==null){
        return new LoginOption();
      }else{
        if(_isVerified==false){
          setState(() {
            appState.isloading = true;
          });
          _fetchFirestoreData();
          return _buildLoadingContainer();
        }else{
           
          return _buildstory();
        }
      }
    }

    Widget _buildstory({Widget body}){
      return 
      Scaffold(

       drawer: _drawer(),
    appBar: AppBar(
      title: Text("Vulture Institute"),
    ),
    body:
    WillPopScope(
      onWillPop: (){
        exit(0);
      },
      child:
      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: _gridView(),)
    
    )
    );
    }


     Widget  _buildLoadingContainer(){
      return Scaffold(
        body:WillPopScope(
          onWillPop: (){
            exit(0);
          },
          child: Stack(
            children:[
               SplashView(),
               Center(
                  child: CircularProgressIndicator(),
                  )
            ]
          )
          //SplashView()
      //   Center(
      //   child: CircularProgressIndicator(),
      // )
      ));
    }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //  _isLoading = true;
    // });
  }

  @override
  Widget build(BuildContext context) {

    appState = StateWidget.of(context).state;
    return _buildContent();
    
  }

}