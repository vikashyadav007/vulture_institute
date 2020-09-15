import 'package:crackit/colorValue.dart';
import 'package:flutter/material.dart';


class DoubtSolution extends StatefulWidget{
  Map data;
  DoubtSolution(this.data);
  @override
  State<StatefulWidget> createState() {
    return DoubtSolutionState(data);
  }
}

class DoubtSolutionState extends State<DoubtSolution>{
Map data;
  DoubtSolutionState(this.data);

     @override
  void initState() {
    super.initState();
  }

  Widget _showOriginal(){
    return  Padding(
         padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
         child: GestureDetector(
           onTap: (){
              },
           child: ListView(
             children:[
               Center(child:Text("Doubt",style: TextStyle(fontSize:25),),),
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
                                  Text(data['doubt'].toString(),style: TextStyle(fontSize:20),),),
                                  Container(
                                      child:data['imageUrl']!=null?Image.network(data['imageUrl'],height: 150,):Text(""),
                                    )
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    ),
    Center(child:Text("Solution",style: TextStyle(fontSize:25),),),
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
                                  Text(data['solution'].toString(),style: TextStyle(fontSize:20),),),
                                  Container(
                                      child:data['solutionImage']!=null?Image.network(data['solutionImage'],height: 150,):Text(""),
                                    )
                                ]
                            ),
                        ),
                    ),
                ),
            ),
    )
             ]
           )
          
    )
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
        title: Text("Doubt Solution"),
      ),
      body: _showOriginal(),
    )
    );
  }
}