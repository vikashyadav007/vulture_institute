import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PDFScreen extends StatefulWidget{
  String name;
  String exercise;
  String solution;
  PDFScreen(this.name,this.exercise,this.solution);
  @override
  State<StatefulWidget> createState() {
    return PDFScreenState(this.name,this.exercise,this.solution);
  }
}

class PDFScreenState extends State<PDFScreen>{
  String name;
  String exercise;
  String solution;
  PDFDocument document;
  bool exerciseView = true;
  PDFScreenState(this.name,this.exercise,this.solution);
  bool _isloading = false;
  bool _isEmpty = false;
  List chapterList = [];

  
loadDocument(String url) async {
  if(url!=null)
   await PDFDocument.fromURL(
          url).then((value){
           setState(() {
             document = value;
             _isloading = false;
           });
          });
  }

   
     @override
  void initState() {
    super.initState();
    if(exercise.isEmpty){
      _isEmpty = true;
    }
    else{
    setState(() {
      _isloading = true;
     });
      loadDocument(exercise);
    } 
  }

    Center _showCircularProgress(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Center _showEmptyMessage(){
    return Center(child: Text("No pdf found"),
      
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
    Center(
      child: 
       Column(
         children:[
           Expanded(
             flex: 9,
             child:  PDFViewer(document:document),
             ),
             Expanded(flex: 1,
               child: 
               FlatButton(
                 color: Colors.blue,
                 onPressed: (){
                    if(exerciseView)
                    {
                      if(solution.isNotEmpty){
                        setState(() {
                          _isloading = true;
                        });
                         loadDocument(solution);
                          setState(() {
                              exerciseView = false;
                          });
                      }else{
                        Fluttertoast.showToast(
                          msg: "No solution for this exercise right now",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 20,
                        );
                      }
                    }
                     else{
                       loadDocument(exercise);
                        setState(() {
                       exerciseView = true;
                     });
                     }
                 },
                 child: Container(
                   alignment: Alignment.center,
                   color: Colors.blue,
                   width:double.infinity,
                   child:Text(exerciseView?"Solution":"Exercise",style:TextStyle(fontSize:25))
                 ),
                 ),
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
        if(exerciseView){
            Navigator.pop(context);
        }else{
             setState(() {
                      _isloading = true;
                      exerciseView = true;
                    });
                    loadDocument(exercise);
        }
      
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