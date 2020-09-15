import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/ScoreClass.dart';
import 'package:crackit/TestClass.dart';
import 'package:crackit/home.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:flutter/material.dart';
import 'TestSeries.dart';
import 'TrialModeEndMessage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crackit/TestClass.dart';

class TestPage extends StatefulWidget{
 TestClass testClass;
  TestPage(this.testClass);
  @override
  State<StatefulWidget> createState() {
    return TestPageState(testClass);
  }
}

class Counter{
    int value;
    bool done;
    int answer=0;
    Counter(this.value,this.done);
  }

class TestPageState extends State<TestPage>{
 TestClass testClass;
  TestPageState(this.testClass);

  StateModel appState;
  String _errorMessage=''; 
  bool isLoading = false;
  int _index = 0;
  // int _initialPage=0;
  bool resultView = false;
  double finalScore=0;
  double totalScore=0;
  int attempted=0;
  int unattempted=0;
  int correct=0;
  int incorrect=0;

  Color notDone=Colors.red;
  Color done= Colors.green;
    
  List<TestSeries> testSeriesList=[];
  List<Counter> counterList=[];

  Timer _timerSec;
  Timer _timerMin;
  int _startSec = 60;
  int _startMin= 0;

  PageController _pageController = PageController(initialPage: 0);

  void startTimer(){
    const oneSec = const Duration(seconds: 1);
    _timerSec = new Timer.periodic(oneSec, (timer) { 
        setState(() {
          if(_startMin<1 && _startSec<2){
               evaluateScore();
          
          }else if(_startSec<2){
            _startSec = 60;
            _startMin = _startMin -1;
          }else{
            _startSec = _startSec -1;
          }
        });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timerSec.cancel();
    _timerMin.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      _startMin = testClass.duration - 1;
    });
    if(testClass==null){
        setState(() {
            isLoading = false;
          });
    }else{
        Map<String,dynamic> map = testClass.exercise;

        int len = map.length;
        for(int i=1;i<=len;i++){
          Map<String,dynamic> value = map[i.toString()];
           testSeriesList.add(new TestSeries(int.parse(value['number']),value['question'],value['option1'],value['option2'],value['option3'],value['option4'],value['answer'],));
        }
          for(int i=0;i<testSeriesList.length;i++){
         counterList.add(new Counter(i+1,false));
       }
       setState(() {
         isLoading = false;
       });
       startTimer();
    }
 
     
     }

     makeCounterView(){
        List<Widget> list=[];
        for(int i=0;i<counterList.length;i++){
          list.add(
              GestureDetector(
                onTap: (){
              _pageController.jumpToPage(i);
               print(i);
              }, child: Padding(
                     padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                     child:  Container(
                      height:25,
                      width:25,
                      child:CircleAvatar(
                        backgroundColor: _index==i?Colors.indigo:counterList[i].done?done:notDone,
                        child:Text(counterList[i].value.toString(),style:TextStyle(fontSize: 15))
                        ),
                    ),
              ),    )
          );
        }
        return list;
     }
  

resutlViewPage(){
    return Center(
      child:ListView(
      children: [
       Padding(padding: EdgeInsets.all(15)),
       Center(child: Text("You have scored",style: TextStyle(fontSize:27,color: Colors.red,fontWeight: FontWeight.bold)),),
        Padding(padding: EdgeInsets.all(10)),
       Container(
            height:150,
            width:150,
            child:CircleAvatar(
              backgroundColor:Colors.indigo,
              child:Text('$finalScore / ${totalScore.round()}',style:TextStyle(fontSize: 25))
              ),
          ),
      //  Center(child:  Text('$finalScore / $totalScore',style: TextStyle(fontSize:35),),),
       Padding(padding: EdgeInsets.all(15)),
        Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("ATTEMPTED",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(attempted.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ), 
          // Padding(padding: EdgeInsets.all(1)),
           Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("UN-ATTEMPTED",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(unattempted.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ),
          //  Padding(padding: EdgeInsets.all(1)),
          Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("CORRECT",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(correct.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ),
          //  Padding(padding: EdgeInsets.all(1)),
          // Divider(height:4,color: Colors.black,),
          Container(color:Colors.black,height:2),
       Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("INCORRECT",style:TextStyle(fontSize: 25))),color: Colors.amber,height:50),flex:8,),
            // Container(color:Colors.black,width:2,),
            Divider(color: Colors.black,thickness: 2,height: 2,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(incorrect.toString(),style:TextStyle(fontSize: 25),textAlign: TextAlign.center,)),color: Colors.green,height:50),flex:2,),
          ],
          ),
           Container(color:Colors.black,height:2),
      //  ListTile(leading:Text("Attempted : "),title: Text(attempted.toString()),),
      //  ListTile(leading:Text("Un-Attempted : "),title: Text(unattempted.toString()),),
      //  ListTile(leading:Text("Correct : "),title: Text(correct.toString()),),
      //  ListTile(leading:Text("Incorrect : "),title: Text((attempted -correct).toString()),),

      ],
    ),
    );
}
showToast(){
    Fluttertoast.showToast(
                    msg: "No Test Available",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 20,
                  );
}

evaluateScore(){
      double score = 0;
     for(int i=0;i<counterList.length;i++){
       switch(counterList[i].answer){
         case 1:
            attempted++;
            if(testSeriesList[i].option1.compareTo(testSeriesList[i].answer)==0){
              score +=testClass.marksPerQues;
              correct++;
            }
            break;
         case 2:
            attempted++;
            if(testSeriesList[i].option2.compareTo(testSeriesList[i].answer)==0){
              score +=testClass.marksPerQues;
              correct++;
            }
            break;
         case 3:
            attempted++;
            if(testSeriesList[i].option3.compareTo(testSeriesList[i].answer)==0){
              score +=testClass.marksPerQues;
              correct++;
            }
            break;
         case 4:
            attempted++;
            if(testSeriesList[i].option4.compareTo(testSeriesList[i].answer)==0){
              score +=testClass.marksPerQues;
              correct++;
            }
            break;
        case 0:
          unattempted++;
          break;
       }
     }

      setState(() {
        finalScore = score;
        totalScore = double.parse(testSeriesList.length.toString()) * testClass.marksPerQues;
        incorrect = attempted- correct;
        resultView = true;
        _timerSec.cancel();
      });

       ScoreClass scoreClass= new ScoreClass(score, totalScore.round(), attempted, unattempted, correct, incorrect);

     Firestore.instance
      .collection("test_history")
      .add({
        "userId":appState.user.uid,
        "testId":testClass.testId,
        "date":DateTime.now(),
        "test":testClass.name,
        "score":scoreClass.getMap(),
      });
}

showSubmitButton(){
  if(_index == testSeriesList.length-1){
    return RaisedButton(
      onPressed: () {
          evaluateScore();
    },
    child: Text("Submit"),
    );
  }else{
    return Text("");
  }
}


  questionView(TestSeries testSeries,int index){
    return 
    ListView(
      scrollDirection: Axis.vertical,
      children: [
           Center(
                     child:  Container(
                      height:50,
                      width:50,
                      child:CircleAvatar(
                        backgroundColor: Colors.blue,
                        child:Text(testSeries.quesNumber.toString(),style:TextStyle(fontSize: 25))
                        ),
                    ),),    
            ListTile(
      title: Text(testSeries.question.toString(),style:TextStyle(fontSize: 20,fontFamily: 'kruti')),
      subtitle:  Padding(padding:EdgeInsets.all(15),child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
             setState(() {
                counterList[index].done=true;
              counterList[index].answer=1;
              
             });
            },
            child: Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("A",style:TextStyle(fontSize: 25))),color: Colors.blue,height:50),flex:2,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(testSeries.option1.toString(),style:TextStyle(fontSize: 25,fontFamily: 'kruti'))),color: counterList[index].answer==1?done:notDone,height:50),flex:8,),
          ],
          )
          ,),
         
           Padding(padding:EdgeInsets.all(5),),
           GestureDetector(
            onTap: (){
              setState(() {
                  counterList[index].done=true;
                counterList[index].answer=2;
              });
            },
            child: Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("B",style:TextStyle(fontSize: 25))),color: Colors.blue,height:50),flex:2,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(testSeries.option2.toString(),style:TextStyle(fontSize: 25,fontFamily: 'kruti'))),color: counterList[index].answer==2?done:notDone,height:50),flex:8,),
          ],
          )
          ,),
           Padding(padding:EdgeInsets.all(5),),
           GestureDetector(
            onTap: (){
               setState(() {
                  counterList[index].done=true;
                counterList[index].answer=3;
              });
            },
            child: Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("C",style:TextStyle(fontSize: 25))),color: Colors.blue,height:50),flex:2,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(testSeries.option3.toString(),style:TextStyle(fontSize: 25,fontFamily: 'kruti'))),color: counterList[index].answer==3?done:notDone,height:50),flex:8,),
          ],
          )
          ,),
          Padding(padding:EdgeInsets.all(5),),
            GestureDetector(
            onTap: (){
                setState(() {
                  counterList[index].done=true;
                counterList[index].answer=4;
              });
            },
            child: Row(
            children: [
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text("D",style:TextStyle(fontSize: 25))),color: Colors.blue,height:50),flex:2,),
            Expanded(child: Container(child:Padding(padding:EdgeInsets.all(10),child:Text(testSeries.option4.toString(),style:TextStyle(fontSize: 25,fontFamily: 'kruti'))),color: counterList[index].answer==4?done:notDone,height:50),flex:8,),
          ],
          )
          ,),
        ],
      ),)
      ),
        showSubmitButton(),
      ],

      
    );
  }
  

  newView(){
    return  Center(
        child: SizedBox(
          height: 800, // card height
          child: PageView.builder(
            itemCount: testSeriesList.length,
            controller: _pageController,
            onPageChanged: (int index) {
               setState(() => _index = index);
               print(_index);
            },
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: questionView(testSeriesList[i],i),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
 
 timerView(){
    return Center(child: Text("$_startMin : $_startSec",style: TextStyle(fontSize:30),),);
 }

  Widget _createContent(){
   if(appState.studentInfo.isSubscribed== false){
        if(appState.studentInfo.trialPeriod == false){
      return TrialModeEndMessage();
    }
    }
         return Column(
      children:[
          Expanded(
            child: timerView(),
            // questionView(testSeriesList[0]),
            flex: 1,
            ),
          Expanded(
            child: newView(),
            // questionView(testSeriesList[0]),
            flex: 8,
            ),
          Expanded(
            child: FlatButton(onPressed: (){
                showModalBottomSheet(context: context, builder: (BuildContext bc){
                  return Container(
                    // height: 100,
                    child: Padding(padding: EdgeInsets.all(10), child:new Wrap(
                      children:makeCounterView(),
                    ),)
                  );
                });
            }, child: Center(child:Icon(Icons.keyboard_arrow_up))),
            
            flex: 1,
            ),
         
      ]
    );
    
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

 Widget _builtContainer(){
    if(isLoading==true){
     return _showCircularProgress();
    }else{
     return _createContent();
    // return Text("data");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return 
    WillPopScope(
      onWillPop: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(true)));
      },

  child:
    Scaffold(
      appBar: AppBar(
        title: Text("TestPage"),
      ),
      // body: noTestShow(),
      body:resultView==true?resutlViewPage(): _builtContainer(),
    )
    );
  }

}
