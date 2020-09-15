import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget{
  String title;
  String videoUrl;
  YoutubePlayerController _controller;
  YoutubeScreen(this.title,this._controller);
  @override
  State<StatefulWidget> createState() {
    return YoutubeScreenState(this.title,this._controller);
  }
}

class YoutubeScreenState extends State<YoutubeScreen>{
  String title;
  String videoUrl;

  YoutubePlayerController _controller;
 
  YoutubeScreenState(this.title,this._controller);
  bool _isloading = false;
  bool _isEmpty = false;
  List chapterList = [];
  

  

   
     @override
  void initState() {
    super.initState();
    // if(videoUrl.isEmpty){
    //   _isEmpty = true;
    // }
    // else{
    //   _controller = YoutubePlayerController(
    //     initialVideoId: YoutubePlayer.convertUrlToId(videoUrl),
    //     flags: YoutubePlayerFlags(
    //       autoPlay: true,
    //       mute:false,
    //       isLive: true,
    //     )
    //     );
    // } 
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    _controller.dispose();
  }


    Center _showCircularProgress(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Center _showEmptyMessage(){
    return Center(child: Text("Not video found"),
      
    );
  }

 Widget _builtContainer(){
   if(_isEmpty==true){
     return _showEmptyMessage();
   }else
    if(_isloading==true){
     return _showCircularProgress();
    }else{
     return _showOriginal();
    }
  }

  Widget _showOriginal(){
    return _isloading?_showCircularProgress():
    Container(
      child: SingleChildScrollView(
        child: Column(
          children:<Widget>[
              YoutubePlayer(
                controller: _controller
                ),
          ]
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
        _builtContainer();
  }

}