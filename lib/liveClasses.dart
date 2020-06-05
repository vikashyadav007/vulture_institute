import 'package:crackit/youtubeScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveClasses extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LiveClassesState();
  }
}

class LiveClassesState extends State<LiveClasses>{
  bool _isloading = false;
  List chapterList = [];
  final _firebaseRef = FirebaseDatabase().reference().child("LiveSchedule");
  Widget something= Text("");
  static YoutubePlayerController _controller;
  // Widget magic =  Expanded(
  //             flex: 1,
  //             child:  Padding(
  //               padding: EdgeInsets.all(4),
  //             child:
  //             YoutubePlayer(
  //               controller: _controller,
  //               ),
  //           )
  //            );

  var liveUrl= "https://youtu.be/h-EpRhNzpuU";
static String videoUrl = "https://www.youtube.com/watch?v=IkzlYyqexB8";

     @override
  void initState() {
    super.initState();
    _isloading = false;

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
            child: new Text('Watch Live Classes',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed:() async{

              if (await canLaunch(videoUrl)) {
                      await launch(videoUrl);
               } else {
                    throw 'Could not launch $liveUrl';
               }

            },
          ),
        ));
  }

  Widget _showOriginal(){
    return _isloading?_showCircularProgress():
     Center(
      child:_showPrimaryButton(),
    );
  }

  Widget createContainerView(var item){
    return Card(
        child: Material(
          child: InkWell(
           onTap: (){
           setState(() {
             if(_controller !=null){
               something = Text("");
               _controller = null;
              Future.delayed(Duration(microseconds: 5),(){
                setState(() {
                   _controller = YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(item["Url"].toString()),
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute:false,
                      isLive: true,
                    )
                    );
              something = Expanded(
              flex: 1,
              child:  YoutubeScreen(item["Title"].toString(), _controller),
            );
                });

              });
                
             }
             else{
             _controller = YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(item["Url"].toString()),
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute:false,
                      isLive: true,
                    )
                    );
              something = Expanded(
              flex: 1,
              child:  YoutubeScreen(item["Title"].toString(), _controller),
            );
             }
            
           });
           },  
           child:Container(
                color: Colors.white70,
                child: ListTile(
                 leading: Image.asset('assets/education.png',fit: BoxFit.cover,),
                  title: Text(item["Title"].toString(),
                  style: TextStyle(
                    color:Colors.amber,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  )
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget>[
                     Text(item["Date"].toString(),
                  style: TextStyle(
                    color:Colors.black54,
                    fontWeight: FontWeight.w800,
                    //decoration: TextDecoration.lineThrough
                  )
                  ),
                     Text(item["Time"].toString(),
                  style: TextStyle(
                    color:Colors.black54,
                    fontWeight: FontWeight.w800,
                   // decoration: TextDecoration.lineThrough
                  )
                  )
                  ]),
                ),
              ),
             // title: Image.asset('assets/logo.png',fit: BoxFit.cover,),
            
          ),
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
        title: Text("Demo Classes"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            something,
            Expanded(
              flex: 2,
              child: StreamBuilder(
        stream:_firebaseRef.onValue,
        builder: (context,snap){
          if(snap.hasData && !snap.hasError && snap.data.snapshot.value !=null){
            Map data = snap.data.snapshot.value;
            List item=[];
            item = data.values.toList();
            // data.forEach((key, value) =>item.add({"key":key, ...data}));
            return ListView.builder(
              itemCount:  item.length,
              itemBuilder: (context,index){
                 return createContainerView(item[index]);
              }
            );
          }else{
          return Center(
            child:  Text("No data"),
          );
        }
        }
        ),)
          ],
          )
          )
    )
    );
  }


}