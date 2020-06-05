import 'package:crackit/colorValue.dart';
import 'package:flutter/material.dart';

class UnResolvedDoubt extends StatefulWidget{
  List<Map> data;
  UnResolvedDoubt(this.data);
  @override
  State<StatefulWidget> createState() {
    return UnResolvedDoubtState(data);
  }
}

class UnResolvedDoubtState extends State<UnResolvedDoubt>{
 List<Map> data;
  UnResolvedDoubtState(this.data);
  bool _isloading = false;

  List<Widget> _getTaskTile(List list){
      List<Widget> widget=[];
           if(list.isEmpty){
        widget.add(Center(child: Text("No data"),));
      }
      else{   
     for(int i=0;i<list.length;i++){
       var _padding = Padding(
         padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
         child: GestureDetector(
           onTap: (){
              },
           child: 
           Padding(
            padding: EdgeInsets.all(15),
            child:Card(
                color:Colors.red,
                elevation: 15,
                  child: 
                    Material(
                      child: InkWell(
                        onTap: ()=> null,
                          child:Container(
                              color: primaryColor,
                              child:
                              Column(
                                children:[
                                  Padding(padding: EdgeInsets.all(10),
                                  child:
                                  Text(data[i]['doubt'].toString(),style: TextStyle(fontSize:20),),),
                                  Container(
                                      child:data[i]['imageUrl']!=null?Image.network(data[i]['imageUrl'],height: 150,):Text(""),
                                    )
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    ),


          )
         );
         widget.add(_padding);
     }
      }
      return widget;
    }

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

  Widget _showOriginal(){
    return _isloading?_showCircularProgress():
    Center(
      child: ListView(
        children: _getTaskTile(data)
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
        title: Text("UnResolved Doubts"),
      ),
      body: _builtContainer(),
    )
    );
  }

}