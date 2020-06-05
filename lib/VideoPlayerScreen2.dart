import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen2 extends StatefulWidget{
  String title;
  String url;
  VideoPlayerController _videoPlayerController;
  VideoPlayerScreen2(this.title,this._videoPlayerController);
  @override
  State<StatefulWidget> createState() {
    return VideoPlayerScreenState2(title,_videoPlayerController);
    throw UnimplementedError();
  } 
}

class VideoPlayerScreenState2 extends State<VideoPlayerScreen2>{
   String title;
  String url;
  VideoPlayerScreenState2(this.title,this._videoPlayerController);


  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // _videoPlayerController = VideoPlayerController.network(url);
    //_videoPlayerController = VideoPlayerController.network('https://youtu.be/PJGVDaSaQWQ');
   _chewieController = ChewieController(

     videoPlayerController: _videoPlayerController,
     aspectRatio: 16/9,
     autoInitialize: true,
     //autoPlay: true,
     looping:  true,
     errorBuilder: (context,errorMessage){
       return Center(
         child: Text(
         errorMessage,
         style:TextStyle(color:Colors.white),
       ),
       );
     }
   );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Chewie(
          controller:_chewieController,
        );
    throw UnimplementedError();
  }

}