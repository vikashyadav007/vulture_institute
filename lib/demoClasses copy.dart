import 'package:crackit/AddToFirebase.dart';
import 'package:crackit/VideoPlayerScreen.dart';
import 'package:crackit/VideoPlayerScreen2.dart';
import 'package:flutter/material.dart';
import 'package:crackit/youtubeScreen.dart';

class DemoClasses extends StatefulWidget{
  Map<String,dynamic> mapData;
  DemoClasses(this.mapData);
  @override
  State<StatefulWidget> createState() {
    return DemoClassesState(mapData);
  }
}

class DemoClassesState extends State<DemoClasses>{
  bool _isloading = false;
   Widget something=Text("");
 List listVideo=[];
  Map<String,dynamic> mapData;
  DemoClassesState(this.mapData);

  var liveUrl= "https://youtu.be/h-EpRhNzpuU";
static String videoUrl = "https://www.youtube.com/watch?v=IkzlYyqexB8";

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
       var _padding = Padding(
         padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
         child: GestureDetector(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayerScreen2(list[i]["Title"],list[i]["url"])));
              },
           child: 
           Chip(
           elevation: 5,
           label: Container(
             width: 250,
             height:40,
             child:Center(child:Text(list[i]["Title"],style: TextStyle(fontSize: 25,color: Colors.black54),),)),
            backgroundColor: (Colors.amber),
           avatar: CircleAvatar(
           backgroundColor: Colors.grey.shade100,
           child: Icon(Icons.play_arrow),
           ),
         ),)
         );
         widget.add(_padding);
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
     ListView(
      children:_getTaskTile(listVideo),
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
        title: Text("Demo Classes"),
      ),
      body: _builtContainer(),
    )
    );
  }

}