import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:crackit/colorValue.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class DoubtsLanding extends StatefulWidget{
  String std,sub;
  DoubtsLanding(this.std,this.sub);
  @override
  State<StatefulWidget> createState() {
    return DoubtsLandingState(std,sub);
  }
}

class DoubtsLandingState extends State<DoubtsLanding>{
  String std,sub;
  DoubtsLandingState(this.std,this.sub);
 StateModel appState;
 String _errorMessage=''; 
 double _scale = 1.0;
 double _previousScale = 1.0;
 TextEditingController textEditingController = TextEditingController();
 File _image;
 File _image2;
 bool _isloading;

 Future getImageCamera() async{

   final image = await ImagePicker.pickImage(source: ImageSource.camera);
   setState(() {
     _image = image;
   });
 }

 Future getImageGalary() async{
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
   setState(() {
     _image = image;
   });
 }
  
     @override
  void initState() {
    super.initState();
   

    setState(() {
      _isloading = false;
    });
  }


 Widget submitButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(15, 35.0, 15, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: primaryColor,
            child: new Text('Submit',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)),
            onPressed:(){
                if(textEditingController.text.isEmpty){
                  setState(() {
                    _errorMessage = "Please Explain your doubt";
                  });
                }else{
                  setState(() {
                    _isloading = true;
                  });
                  _uploadDoubt();
                }
            },
          ),
        ));
  }

  _uploadDoubt() async{
     var now = DateTime.now();
     var uid = appState.user.uid;
     var imageString = '/doubtsImage/image';
     imageString += uid.substring(0,4) + uid.substring(uid.length-4,uid.length) + now.toIso8601String();
    if(_image!=null){
       final StorageReference sf = FirebaseStorage().ref().child(imageString);
        final StorageUploadTask uploadTask = sf.putFile(_image);
        await uploadTask.onComplete;
    }
    _addPathToDatabase(imageString);
  }
  _addPathToDatabase(var imageString) async{
    var imageUrl =null;
    if(_image!=null){
       final ref = FirebaseStorage().ref().child(imageString);
       imageUrl = await ref.getDownloadURL();
    }
    var uid = appState.user.uid;
    var now = DateTime.now();
    String doubtId = uid.substring(0,4) + uid.substring(uid.length-4,uid.length) + now.toIso8601String();
    Map<String,dynamic> map = {
      'date': DateTime.now(),
      'doubt':textEditingController.text,
      'imageUrl': imageUrl,
      'isResolved': false,
      'standard':std,
      'subject':sub,
      'userId':uid,
      'doubtId':doubtId
    };
   CollectionReference cr = Firestore.instance.collection('new_doubts');
   cr.add(map).then((value){
                  setState(() {
                    _isloading = false;
                  });
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(true)));      
   });


  }

Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {

      String temp = _errorMessage;
      return Padding(padding: EdgeInsets.all(15),
      child:Center(child:
        new Text(
          temp,
          style: TextStyle(
              fontSize: 15.0,
              color: Colors.red,
              height: 1.0,
              fontWeight: FontWeight.w300),
        ),
      )
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
 Widget writingArea(){
   return  Padding(
            padding: EdgeInsets.fromLTRB(2, 15, 2, 0),
            child:Card(
                color:Colors.red,
                elevation: 0,
                  child: 
                    Material(
                      child: InkWell(
                        onTap: ()=> null,
                          child:Container(
                              color: primaryColor,
                              child:
                              Column(
                                children:[
                                Padding(
                                  padding:EdgeInsets.all(8),
                                 child:TextField(
                                    controller: textEditingController,
                                    maxLines: 5,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: "Explain your Doubt here..."
                                      ),    
                                  )
                                ),   
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
 }



     Widget imageSelectButton(){
      return Padding(
            padding: EdgeInsets.fromLTRB(2, 15, 2, 0),
            child:Card(
                color:Colors.red,
                elevation: 0,
                  child: 
                    Material(
                      child: InkWell(
                        onTap: ()=> null,
                          child:Container(
                              color: primaryColor,
                              child:
                              Column(
                                children:[
                                  Padding(padding:EdgeInsets.all(10)),
                                   new Text(
                              'Select image (if any) :',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                             Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    SizedBox(
                                    height: 40.0,
                                    child: new RaisedButton(
                                      elevation: 5.0,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0)),
                                      color: primaryColor,
                                      child: new Text('Open Camera',
                                          style: new TextStyle(fontSize: 15.0, color: Colors.black)),
                                      onPressed:(){
                                        getImageCamera();
                                      },
                                    ),
                                  ),
                                    SizedBox(
                                    height: 40.0,
                                    child: new RaisedButton(
                                      elevation: 5.0,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0)),
                                      color: primaryColor,
                                      child: new Text('Select From Galary',
                                          style: new TextStyle(fontSize: 15.0, color: Colors.black)),
                                      onPressed:(){
                                        getImageGalary();
                                      },
                                    ),
                                  )
                                    
                                  ]
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    );
  }
  Widget halfImage(){
    return GestureDetector(
      child:Image.file(_image,height: 150,),
      onTap: (){
        setState(() {
          _image2 = _image;
        });
      },

    );
  }

  Widget imageContainer(){
    return Container(
      child:_image==null?Text("") : halfImage(),
    );

  }
 _showCircularProcess(){
  if(_isloading== true){
    return Center(child: CircularProgressIndicator(),);
  }
  return Container(height: 0.0,width: 0.0,);
}

  Widget _createContent(){
    return Stack(
      children:<Widget>[
        ListView(
      children:[
          writingArea(),
          imageSelectButton(),
          imageContainer(),
          submitButton(),
          _showErrorMessage(),
      ]
    ),
     _showCircularProcess(),
      ]
    );
  }

  Widget fullImage(){
    return Padding(
      padding: EdgeInsets.all(15),
    child:Center(
      child: GestureDetector(
        onScaleStart: (ScaleStartDetails details){
          _previousScale = _scale;
          setState(() {
            
          });
        },
        onScaleUpdate: (ScaleUpdateDetails details){
          _scale = _previousScale * details.scale;
          setState(() {
          });
        },
        onScaleEnd: (ScaleEndDetails details){
          _previousScale = 1.0;
          setState(() {
          });
        },
        child: RotatedBox(
          quarterTurns: 0,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child:Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.diagonal3(Vector3(_scale,_scale,_scale)),
              child:Image.file(_image2),
              )
          ),

        ),
      ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return 
    WillPopScope(
      onWillPop: (){
        if(_image2 != null){
           setState(() {
          _image2 = null;
        });
        }else{
          Navigator.pop(context);
        } 
      },

  child:
    Scaffold(
      appBar: AppBar(
        title: Text("Ask a Doubt"),
      ),
      body: _image2==null? _createContent():fullImage(),
    )
    );
  }

}