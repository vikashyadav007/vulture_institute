import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/ResultView.dart';
import 'package:crackit/ScoreClass.dart';
import 'package:crackit/TestClass.dart';
import 'package:crackit/TestPage.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/material.dart';
import 'TestSeries.dart';
import 'TrialModeEndMessage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestPageLanding extends StatefulWidget{
  String name;
  var mapData;
  TestPageLanding(this.name,this.mapData);
  @override
  State<StatefulWidget> createState() {
    return TestPageLandingState(name,mapData);
  }
}




class TestPageLandingState extends State<TestPageLanding>{
  String name;
  var mapData;
  TestPageLandingState(this.name,this.mapData);

  StateModel appState;
  String _errorMessage=''; 
  bool isLoading = false;

  int testSeriesCount;
  Map<String,dynamic> testSeriesMap;
  List<TestClass> testClassList = [];

   @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });

    if(mapData==""){
        setState(() {
            isLoading = false;
          });
    }else{
        if(mapData!=null){
            print(mapData);
            Map<String,dynamic> map = mapData;
            map.forEach((key, value) {
              Map<String,dynamic> innerMap = value;
              testClassList.add(new TestClass(innerMap['exercise'],innerMap['solution'],innerMap['name'],int.parse(innerMap['duration'].toString()),int.parse(innerMap['marksPerQues'].toString()),innerMap['testId']));
            });
            setState(() {
              isLoading = false;
            });
           
        }else{
          setState(() {
            isLoading = false;
          });
        }
    }
 
  }

 
  Widget noTestShow(){
    return Center(
      child: Text("No Test Available Right now.",style:TextStyle(fontSize: 16)),
    );
  }

   Center _showCircularProgress(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  checkRecord(TestClass testClass) async{
    Firestore.instance
      .collection("test_history")
      .where("userId",isEqualTo: appState.user.uid)
      .where("testId",isEqualTo: testClass.testId)
      .snapshots()
      .listen((data) {
        if(data.documents.length==0){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>TestPage(testClass)));
        }else{   
            ScoreClass scoreClass;
           data.documents.forEach((element) {
             Map<String,dynamic> map1 = element.data;
             Map<String,dynamic> map2 = map1['score'];
             scoreClass = new ScoreClass(map2['score'], map2['total'], map2['attempted'], map2['unattempted'], map2['correct'], map2['incorrect']);
           });
           Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultView(scoreClass)));
              // Fluttertoast.showToast(
              //                 msg: "You Already Attempted This Test",
              //                 toastLength: Toast.LENGTH_SHORT,
              //                 gravity: ToastGravity.BOTTOM,
              //                 fontSize: 20,
              //               );
        }
      });
  }

  List<Widget> _getTaskTile(List<TestClass> list){
      List<Widget> widget=[];
           if(list.isEmpty){
        // widget.add(Center(child: Text("No data"),));
        widget.add(noTestShow());
      }
      else{   
     for(int i=0;i<list.length;i++){
       var card = Card(
        child: Material(
          child: InkWell(
           onTap: (){
             checkRecord(testClassList[i]);
           },  
           child:Container(
                color: Colors.white70,
                child: ListTile(
                 leading: Icon(Icons.note, size: 35, color: Colors.blue),
                  title: Text(list[i].name.toString(),
                  style: TextStyle(
                    color:Colors.black54,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  )
                  ),
                  // trailing: dppList[i]['solution']==""?Icon(Icons.cancel):Icon(Icons.done),
              ),
              ),
          ),
        ),
    
    );
         widget.add(card);
     }
      }
      return widget;
    }

 

   Widget _showOriginal(){
    return 
    // isLoading?_showCircularProgress():
    Center(
      child:Column(
        children: _getTaskTile(testClassList)
      ),
    );
  }

 Widget _builtContainer(){
    if(isLoading==true){
     return _showCircularProgress();
    }else{
     return _showOriginal();
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
        title: Text("TestPage"),
      ),
      // body: noTestShow(),
      body:_builtContainer(),
    )
    );
  }

}
