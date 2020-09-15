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
       var _padding = Padding(
         padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
         child: GestureDetector(
           onTap: (){

             if(choice ==STUDYMATERIAL){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => StudyMaterialList(list[i]['name'],list[i]["dpp"])));
             }else if(choice == VIDEOLECTURE){
               Navigator.push(context,MaterialPageRoute(builder: (context)=>DemoClasses(list[i]["lectures"],)));
             }
              },
           child: 
           Chip(
           elevation: 5,
           label: Container(
             width: 250,
             height:40,
             child:Center(child:Text(list[i]["name"],style: TextStyle(fontSize: 25,color: Colors.black54),),)),
            backgroundColor: (Colors.blue[300]),
           avatar: CircleAvatar(
           backgroundColor: Colors.grey.shade100,
           child: Text(list[i]["chapter"]),
           ),
         ),)
         );
         widget.add(_padding);
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