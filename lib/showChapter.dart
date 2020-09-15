import 'package:crackit/TestPage.dart';
import 'package:crackit/TestPageLanding.dart';
import 'package:crackit/demoClasses.dart';
import 'package:crackit/studyMaterialList.dart';
import 'package:crackit/values.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ShowChapter extends StatefulWidget{
  String choice;
  String course;
  String standard;
  String subject;
  ShowChapter(this.course,this.standard,this.subject,this.choice);
  @override
  State<StatefulWidget> createState() {
    return ShowChapterState(this.course,this.standard,this.subject,this.choice);
  }
}

class ShowChapterState extends State<ShowChapter>{
  String choice;
  String course;
  String standard;
  String subject;
  ShowChapterState(this.course,this.standard,this.subject,this.choice);
  bool _isloading = false;
  List chapterList = [];

  List<Widget> _getTaskTile(List list){
      List<Widget> widget=[];
           if(list.isEmpty){
        widget.add(Center(child: Text("No data"),));
      }
      else{   
     for(int i=0;i<list.length;i++){
          var card = Card(
        child: Material(
          child: InkWell(
           onTap: (){
              if(choice ==STUDYMATERIAL){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => StudyMaterialList(list[i]['name'],list[i]["dpp"])));
             }else if(choice == VIDEOLECTURE){
               Navigator.push(context,MaterialPageRoute(builder: (context)=>DemoClasses(list[i]["lectures"],)));
             }else if(choice == TESTSERIES){
               Navigator.push(context, MaterialPageRoute(builder: (context) => TestPageLanding(list[i]['name'],list[i]["testSeries"])));
           
                 }
           },  
           child:Container(
                color: Colors.white70,
                child:Row(
                  children: [
                      Expanded(
                        flex: 1,
                        child:Container(
                         color: Colors.green,
                           padding:EdgeInsets.all(15),
                          child: Text((i+1).toString(),style:TextStyle(fontSize: 20,color:Colors.black87,fontWeight:FontWeight.w800 )),
                        ) ,
                        ),
                      Expanded(
                        flex: 9,
                        child:Container(
                          color: Colors.amber,
                          padding:EdgeInsets.all(15),
                          child: Text(list[i]["name"],style:TextStyle(fontSize: 16,color: Colors.black54,fontWeight: FontWeight.w800,)),
                        ) ,
                        ),
                ],
                )
              ), 
          ),
        ),
    
    );
         widget.add(card);
     }
      }
      return widget;
    }

     _fetchFirestoreData() async{
    setState(() {
      _isloading = true;
    });
    var data =  Firestore.instance.collection('course').document(course).collection(standard).document(subject);
    data.get().then((value){
       if(value.data == null){
         setState(() {
           _isloading = false;
         });
        }
        else{
          setState(() {
          chapterList = value.data.values.toList();
             _isloading = false;
          });
        }
    });
  }

     @override
  void initState() {
    super.initState();
    _isloading = false;
     _fetchFirestoreData();
  }

    Center _showCircularProgress(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

 Widget _builtContainer(){
    if(_isloading==true){
     return _showCircularProgress();
    }else{
     return _showOriginal();
    }
  }

  Widget _showOriginal(){
    return _isloading?_showCircularProgress():
    Center(
     // child: Text("Something"),
      child: ListView(
        children: _getTaskTile(chapterList)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    WillPopScope(
      onWillPop: (){
       Navigator.pop(context);
      },

  child:
    Scaffold(
      appBar: AppBar(
        title: Text(subject),
      ),
      body: _builtContainer(),
    )
    );
  }

}