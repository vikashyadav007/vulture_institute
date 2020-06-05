import 'package:crackit/AddToFirebase.dart';
import 'package:crackit/VideoPlayerScreen.dart';
import 'package:crackit/VideoPlayerScreen2.dart';
import 'package:flutter/material.dart';
import 'package:crackit/youtubeScreen.dart';
import 'package:video_player/video_player.dart';

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
 VideoPlayerController _videoPlayerController;
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
       var card = Card(
        child: Material(
          child: InkWell(
           onTap: (){
           setState(() {
            //   something = Expanded(
            //   flex: 1,
            //   child:Padding(
            //     padding: EdgeInsets.all(2),
            //   child:VideoPlayerScreen2(list[i]["Title"],list[i]["url"]),)
            // );

              if(_videoPlayerController !=null){
               something = Text("");
               _videoPlayerController = null;
              Future.delayed(Duration(microseconds: 5),(){
                setState(() {
                   _videoPlayerController = VideoPlayerController.network(list[i]["url"]);
              something = Expanded(
              flex: 1,
              child:  VideoPlayerScreen2(list[i]["title"],_videoPlayerController),
            );
                });

              });
                
             }
             else{
              _videoPlayerController = VideoPlayerController.network(list[i]["url"]);
              something = Expanded(
              flex: 1,
              child:  VideoPlayerScreen2(list[i]["title"],_videoPlayerController),
            );   
             }
            


           });
           },  
           child:Container(
                color: Colors.white70,
                child: ListTile(
                 leading: Image.asset('assets/education.png',fit: BoxFit.cover,),
                  title: Text(list[i]["title"].toString(),
                  style: TextStyle(
                    color:Colors.amber,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  )
                  ),
                  // subtitle: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children:<Widget>[
                  //    Text(item["Date"].toString(),
                  // style: TextStyle(
                  //   color:Colors.black54,
                  //   fontWeight: FontWeight.w800,
                  //   //decoration: TextDecoration.lineThrough
                  // )
                  // ),
                  //    Text(item["Time"].toString(),
                  // style: TextStyle(
                  //   color:Colors.black54,
                  //   fontWeight: FontWeight.w800,
                  //  // decoration: TextDecoration.lineThrough
                  // )
                  // )
                  // ]),
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
        title: Text("Lecture"),
      ),
      body: _builtContainer(),
    )
    );
  }

}