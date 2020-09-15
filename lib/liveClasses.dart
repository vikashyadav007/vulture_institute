import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:crackit/youtubeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:crackit/TrialModeEndMessage.dart';


class LiveClasses extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LiveClassesState();
  }
}

class LiveClassesState extends State<LiveClasses>{
  StateModel appState;
  bool _isloading = false;
  List chapterList = [];
  final _firebaseRef = FirebaseDatabase().reference().child("LiveSchedule");
  Widget something= Text("");
  static YoutubePlayerController _controller;
  Color activeColor = Colors.blue;
  Color normalColor = Colors.black54;
  int _active = -1;

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


  Widget createContainerView(var item,int index){
    return Card(
        child: Material(
          child: InkWell(
           onTap: (){
           setState(() {
             _active = index;
             if(_controller !=null){
               something = Expanded(
              flex: 4,
              child:  _showCircularProgress(),
            );
               _controller = null;
              Future.delayed(Duration(seconds: 1),(){
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
              flex: 4,
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
              flex: 4,
              child:  YoutubeScreen(item["Title"].toString(), _controller),
            );
             }
            
           });
           },  
           child:Container(
                color: Colors.white70,
                child: ListTile(
                //  leading: Image.asset('assets/education.png',fit: BoxFit.cover,),
                 leading: Icon(Icons.live_tv,size: 25,color: Colors.red,),
                  title: Text(item["Title"].toString(),
                  style: TextStyle(
                    color:_active==index?activeColor:normalColor,
                    fontSize: 16,
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

  Widget buildContent(){
    return SafeArea(
        child: Column(
          children: [
            something,
            Expanded(
              flex: 6,
              child: StreamBuilder(
                    stream:_firebaseRef.onValue,
                    builder: (context,snap){
                          if(snap.hasData && !snap.hasError && snap.data.snapshot.value !=null){
                           
                            Map data = snap.data.snapshot.value;
                            List item=[];
                            item = data.values.toList();
                            return ListView.builder(
                              itemCount:  item.length,
                              itemBuilder: (context,index){
                                return createContainerView(item[index],index);
                              }
                            );
                       
                          }else if(snap.data ==null){
                          return Center(
                            child:  Text("No data"),
                          );
                        }            
                        return Center(child: CircularProgressIndicator(),);
                    }
        ),)
          ],
          )
          );
  }


Widget selection(){
   if(appState.studentInfo.isSubscribed == false){
            if(appState.studentInfo.trialPeriod == false){
                      return TrialModeEndMessage();
            }else{
              return buildContent();
            }
          }else{
              return buildContent();
          }
        
}
  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return 
    WillPopScope(
      onWillPop: (){
       Navigator.pop(context);
      },

  child:
    Scaffold(
      appBar: AppBar(
        title: Text("Live Classes"),
      ),
      body: selection(), 
    )
    );
  }


}