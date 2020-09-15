import 'package:crackit/PDFScreen.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/material.dart';

class StudyMaterialList extends StatefulWidget{
  String name;
  var mapData;
  StudyMaterialList(this.name,this.mapData);
  @override
  State<StatefulWidget> createState() {
    return StudyMaterialListState(name,mapData);
  }
}

class StudyMaterialListState extends State<StudyMaterialList>{
  StateModel appState;
  bool _isloading = false;
   Widget something=Text("");
 List listVideo=[];
 String name;
  var mapData;
  StudyMaterialListState(this.name,this.mapData);

     @override
  void initState() {
    super.initState();
    setState(() {
      _isloading = true;
    });
   
    if(mapData==""){
      setState(() {
        _isloading = false;
      });
    }else{
           if(mapData!=null){
              listVideo = mapData.values.toList();
              setState(() {
                _isloading = false;
              });
              print("\n\n");
              print(listVideo);
            }else{
              setState(() {
                _isloading = false;
              });
            }
    }
      
  }

  List<Widget> _getTaskTile(List list){
      List<Widget> widget=[];
           if(list.isEmpty){
        widget.add(Center(child: Text("No data"),));
      }
      else{   
     for(int i=0;i<list.length;i++){
        var icon =appState.studentInfo.isSubscribed==true?Icons.ondemand_video:list[i]["demo"]==true?Icons.book:Icons.lock;
       var card = Card(
        child: Material(
          child: InkWell(
           onTap: (){
           String name = "Dpp "+ (i+1).toString();
           print(appState.studentInfo.isSubscribed);
           print(list[i]['demo']);
              if(appState.studentInfo.isSubscribed){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFScreen(name,list[i]["exercise"],list[i]["solution"])));
             }else{
                 if(list[i]['demo']==true){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFScreen(name,list[i]["exercise"],list[i]["solution"])));
             }
             }
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFScreen(name,list[i]["exercise"],list[i]["solution"])));
           },  
           child:Container(
                color: Colors.white70,
                child: ListTile(
                //  leading: Image.asset('assets/education.png',fit: BoxFit.cover,),
                 leading: Icon(icon, size: 25, color: Colors.brown),
                  title: Text("Dpp "+ (i+1).toString(),
                  style: TextStyle(
                    color:Colors.black54,
                     fontSize: 16,
                    fontWeight: FontWeight.w800,
                  )
                  ),
                
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
    // return Text("data");
    }
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

    appState = StateWidget.of(context).state;
    return 
    WillPopScope(
      onWillPop: (){
       Navigator.pop(context);
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