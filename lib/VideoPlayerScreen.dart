import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen extends StatefulWidget{
  String title;
  String url;
  VideoPlayerScreen(this.title,this.url);
  @override
  State<StatefulWidget> createState() {
    return VideoPlayerScreenState(title,url);
    throw UnimplementedError();
  }
  
}

class VideoPlayerScreenState extends State<VideoPlayerScreen>{
   String title;
  String url;
  VideoPlayerScreenState(this.title,this.url);


  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = VideoPlayerController.network(url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    print(url);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        title:Text(title),
      ),
      body:FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          }else{
            return Center(child:CircularProgressIndicator());
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
          setState(() {
            if(_controller.value.isPlaying){
              _controller.pause();
            }else{
              _controller.play();
            }
          });
        },
        child: Icon(_controller.value.isPlaying?Icons.pause:Icons.play_arrow),
        ),
    );
    throw UnimplementedError();
  }

}