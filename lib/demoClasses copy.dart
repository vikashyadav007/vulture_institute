// import 'package:crackit/VideoPlayerScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:connectivity/connectivity.dart';

// class DemoClasses extends StatefulWidget{
//   var mapData;
//   DemoClasses(this.mapData);
//   @override
//   State<StatefulWidget> createState() {
//     return DemoClassesState(mapData);
//   }
// }

// class DemoClassesState extends State<DemoClasses>{
//   bool _isloading = false;
//    Widget something=Text("");
//  List listVideo=[];
//  VideoPlayerController _videoPlayerController;
//   var mapData;
//   DemoClassesState(this.mapData);
//   Color activeColor = Colors.blue;
//   Color normalColor = Colors.black54;
//   int _active = -1;

//     var subscription;
//    var _scaffoldKey = GlobalKey<ScaffoldState>();

 
//   _showVideo(var list){
//      setState(() {

//               if(_videoPlayerController !=null){
//                something = Expanded(
//               flex: 4,
//               child:  _showCircularProgress(),
//             );   
//                _videoPlayerController = null;
//               Future.delayed(Duration(seconds: 1),(){
//                 setState(() {
//                    _videoPlayerController = VideoPlayerController.network(list["url"]);
//               something = Expanded(
//               flex: 4,
//               child:  VideoPlayerScreen2(list["title"],_videoPlayerController),
//             );
//                 });

//               });
                
//              }
//              else{
//               _videoPlayerController = VideoPlayerController.network(list["url"]);
//               something = Expanded(
//               flex: 4,
//               child:  VideoPlayerScreen2(list["title"],_videoPlayerController),
//             );   
//              }
//            });
//   }

// checkConnection() async {
//     await  Connectivity().checkConnectivity().then((value){
//         if(value == ConnectivityResult.none){
//           setState(() {
//             _isloading = false;
//           });
//            var snackBar = SnackBar(
//              content: Text("No Healthy Internet connection"),
//              duration: Duration(minutes: 2),
          
//            );
//            _scaffoldKey.currentState.showSnackBar(snackBar);
//     }else{
//             if(mapData==""){
//          setState(() {
//            _isloading = false;
//          });
//        }else{
//             if(mapData!=null){
//               for(int i=0;i<mapData.length;i++){
//                    var data = mapData[(i+1).toString()];
//                    listVideo.add(data);
//               }
//               setState(() {
//                 _isloading = false;
//               });
//             }else{
//               setState(() {
//                 _isloading = false;
//               });
//             }
//        } 
//     }
//       });
//    }

// checkConnection2() async {
//     await  Connectivity().onConnectivityChanged.listen((event) {
//         if(event == ConnectivityResult.none){
//           setState(() {
//             _isloading = false;
//           });
//            var snackBar = SnackBar(
//              content: Text("No Healthy Internet connection"),
//              duration: Duration(minutes: 2),
          
//            );
//            _scaffoldKey.currentState.showSnackBar(snackBar);
//     }else{
//             if(mapData==""){
//          setState(() {
//            _isloading = false;
//          });
//        }else{
//             if(mapData!=null){
//               for(int i=0;i<mapData.length;i++){
//                    var data = mapData[(i+1).toString()];
//                    listVideo.add(data);
//               }
//               setState(() {
//                 _isloading = false;
//               });
//             }else{
//               setState(() {
//                 _isloading = false;
//               });
//             }
//        } 
//     }
//       });
//    }


//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _isloading = true;
//     });
//     checkConnection2();
//     checkConnection();
//       //   if(mapData==""){
//       //    setState(() {
//       //      _isloading = false;
//       //    });
//       //  }else{
//       //    print("This comes here");
//       //       if(mapData!=null){
//       //         for(int i=0;i<mapData.length;i++){
//       //              var data = mapData[(i+1).toString()];
//       //              listVideo.add(data);
//       //         }
//       //         setState(() {
//       //           _isloading = false;
//       //         });
//       //       }else{
//       //         setState(() {
//       //           _isloading = false;
//       //         });
//       //       }
//       //  } 
//   }

//   tapProperty(){
    
//   }

//   List<Widget> _getTaskTile(List list){
//       List<Widget> widget=[];
//            if(list.isEmpty){
//         widget.add(Center(child: Text("No data"),));
//       }
//       else{   
//      for(int i=0;i<list.length;i++){
//        var card = Card(
//         child: Material(
//           child: InkWell(
//            onTap: (){
//              setState(() {
//                _active = i;
//              });
//               _showVideo(list[i]);             
//            },  
//            child:Container(
//                 color: Colors.white70,
//                 child: ListTile(
//                  leading: Icon(Icons.ondemand_video, size: 25, color: Colors.red),
//                   title: Text(list[i]["title"].toString(),
//                   style: TextStyle(
//                     color:_active ==i?activeColor:normalColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w800,
//                   )
//                   ),
//               ),
//               ), 
//           ),
//         ),
    
//     );
//          widget.add(card);
//      }
//       }
//       return widget;
//     }

//     Center _showCircularProgress(){
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//  Widget _builtContainer(){
//     if(_isloading==true){
//      return _showCircularProgress();
//     }else{
//      return _showOriginal();
//     }
//   }

  
//   Widget _showOriginal(){
//     return _isloading?_showCircularProgress():
//     SafeArea(child: 
//     Column(
//       children:[
//         something,
//         Expanded(
//           flex:6,
//           child:
//            ListView(
//       children:_getTaskTile(listVideo),
//     )
//         )
//       ]
//     )
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//     WillPopScope(
//       onWillPop: (){
//        Navigator.pop(context);
//       },

//   child:
//     Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text("Lecture"),
//       ),
//       body: _builtContainer(),
//     )
//     );
//   }

// }