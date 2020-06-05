import 'package:crackit/AddToFirebase.dart';
import 'package:crackit/PDFScreen.dart';
import 'package:crackit/VideoPlayerScreen.dart';
import 'package:crackit/VideoPlayerScreen2.dart';
import 'package:flutter/material.dart';
import 'package:crackit/youtubeScreen.dart';
import 'package:video_player/video_player.dart';

class StudyMaterialList extends StatefulWidget{
  String name;
  Map<String,dynamic> mapData;
  StudyMaterialList(this.name,this.mapData);
  @override
  State<StatefulWidget> createState() {
    return StudyMaterialListState(name,mapData);
  }
}

class StudyMaterialListState extends State<StudyMaterialList>{
  bool _isloading = false;
   Widget something=Text("");
 List listVideo=[];
 VideoPlayerController _videoPlayerController;
 String name;
  Map<String,dynamic> mapData;
  StudyMaterialListState(this.name,this.mapData);

     @override
  void initState() {
    super.initState();
    setState(() {
      _isloading = true;
    });
       if(mapData!=null){
              for(int i=0;i<mapData.length;i++){
                   var data = mapData[(i+1).toString()];
                   listVideo.add(data);
              }
              setState(() {
                _isloading = false;
              });
              print("\n\n");
              print(listVideo);
            }else{
              setState(() {
                _isloading = false;
              });
            }
  }

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
             String name = "Dpp "+ (i+1).toString();
           Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFScreen(name,list[i]["exercise"],list[i]["solution"])));
           },  
           child:Container(
                color: Colors.white70,
                child: ListTile(
                 leading: Image.asset('assets/education.png',fit: BoxFit.cover,),
                  title: Text("Dpp "+ (i+1).toString(),
                  style: TextStyle(
                    color:Colors.amber,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  )
                  ),
                
                ),
              ),
             // title: Image.asset('assets/logo.png',fit: BoxFit.cover,),
            
          ),
        ),
    
    );
         widget.add(card);
     }
      }
      return widget;
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
    // return Text("data");
    }
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.teal,
            child: new Text('Watch video',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed:(){
             // Navigator.push(context, MaterialPageRoute(builder: (context)=>YoutubeScreen("Video",videoUrl)));
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToFirebase()));
            print(mapData);
         

            },
          ),
        ));
  }

  Widget _showOriginal(){
    return _isloading?_showCircularProgress():
    SafeArea(child: 
    Column(
      children:[
        something,
        Expanded(
          flex:2,
          child:
           ListView(
      children:_getTaskTile(listVideo),
    )
        )
      ]
    )
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
        title: Text(name),
      ),
      body: _builtContainer(),
    )
    );
  }

}