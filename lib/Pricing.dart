
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crackit/SplashView.dart';
import 'package:crackit/stateModel.dart';
import 'package:crackit/stateWidget.dart';
import 'package:crackit/studentInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Pricing extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PricingState();
  }
}

class PricingState extends State<Pricing>{
  StateModel appState;
  bool _isLoading = false;
  StudentInfo student;

  Map<String,dynamic> iitjeeSubjectwise;
  Map<String,dynamic> iitjeeComplete;
  Map<String,dynamic> neetSubjectwise;
  Map<String,dynamic> neetComplete;
  Map<String,dynamic> otherSubjectwise;
  Map<String,dynamic> otherComplete;
  int count =0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
     getData();
  }
  output(){
    print(iitjeeSubjectwise);
    print(iitjeeComplete);
    print(neetSubjectwise);
    print(neetComplete);
    print(otherSubjectwise);
    print(otherComplete);
  }

  getData() async{
      await getIITJEE();
      await getNEET();
      await getOther();   
    // setState(() {
    //   _isLoading = false;
    // });
    return;
  }


  getIITJEE() async{
    Firestore.instance.collection('pricing')
  .document('IIT-JEE')
  .snapshots()
    .listen((result) { 
        iitjeeSubjectwise = result.data['subjectwise'];
        iitjeeComplete = result.data['complete'];
        // setState(() {
        //   iitjeeSubjectwise = subject;
        // iitjeeComplete = complete;
        // });
        // print(iitjeeComplete);
        count++;
        if(count == 3){
            setState(() {
      _isLoading = false;
    });
        }
        return;
    });
  }

  getNEET() async{
     Firestore.instance.collection('pricing')
  .document('NEET')
  .snapshots()
    .listen((result) { 
        neetSubjectwise = result.data['subjectwise'];
        neetComplete = result.data['complete'];
    });
    count++;
        if(count == 3){
            setState(() {
      _isLoading = false;
    });
        }
    return;
  }

  getOther() async{
     Firestore.instance.collection('pricing')
  .document('OTHER')
  .snapshots()
    .listen((result) { 
        otherSubjectwise = result.data['subjectwise'];
        otherComplete = result.data['complete'];
    });
        count++;
        if(count == 3){
            setState(() {
      _isLoading = false;
    });
        }
    return;
  }

  completeIITJEEView(){
    if(iitjeeComplete!=null){
     return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text("Class"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Fees per year"),
          numeric: false,
          ),
      ], 
      rows: <DataRow>[
        DataRow(cells: <DataCell>[
          DataCell(Text("11 PCM")),
          DataCell(Text(iitjeeComplete['11pcm/year'].toString()),),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("12 PCM")),
          DataCell(Text(iitjeeComplete['12pcm/year'].toString()),),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("13 PCM")),
          DataCell(Text(iitjeeComplete['13pcm/year'].toString()),),
        ]),
      ]);
    }
  }
  completeNeetView(){
    if(neetComplete!=null){
     return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text("Class"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Fees per year"),
          numeric: false,
          ),
      ], 
      rows: <DataRow>[
        DataRow(cells: <DataCell>[
          DataCell(Text("11 ")),
          DataCell(Text(neetComplete['11pcbz/year'].toString()),),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("12 ")),
          DataCell(Text(neetComplete['12pcbz/year'].toString()),),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("13 ")),
          DataCell(Text(neetComplete['13pcbz/year'].toString()),),
        ]),

      ]);
  }
  }
  
  Widget dataTableIitJee(String month){
    if(iitjeeSubjectwise !=null){
    return DataTable(
      columnSpacing: 1,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Class"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Physics"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Chemistry"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Mathematics"),
          numeric: false,
          ),
      ], 
      rows: <DataRow>[
        DataRow(cells: <DataCell>[
          DataCell(Text("11")),
          DataCell(Text(iitjeeSubjectwise[month]['physics'].toString())),
          DataCell(Text(iitjeeSubjectwise[month]['chemistry'].toString())),
          DataCell(Text(iitjeeSubjectwise[month]['mathematics'].toString())),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("12")),
          DataCell(Text(iitjeeSubjectwise[month]['physics'].toString())),
          DataCell(Text(iitjeeSubjectwise[month]['chemistry'].toString())),
          DataCell(Text(iitjeeSubjectwise[month]['mathematics'].toString())),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("13")),
          DataCell(Text(iitjeeSubjectwise[month]['physics'].toString())),
          DataCell(Text(iitjeeSubjectwise[month]['chemistry'].toString())),
          DataCell(Text(iitjeeSubjectwise[month]['mathematics'].toString())),
        ]),
       
      ]);
    }
  }
  Widget dataTableNeet(String month){
    if(neetSubjectwise!=null){

    return DataTable(
      columnSpacing: 1,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Class"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Physics"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Chemistry"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Zoology"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Botney"),
          numeric: false,
          ),
      ], 
      rows: <DataRow>[
        DataRow(cells: <DataCell>[
          DataCell(Text("11")),
          DataCell(Text(neetSubjectwise[month]['physics'].toString())),
          DataCell(Text(neetSubjectwise[month]['chemistry'].toString())),
          DataCell(Text(neetSubjectwise[month]['zoology'].toString())),
          DataCell(Text(neetSubjectwise[month]['botney'].toString())),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("12")),
          DataCell(Text(neetSubjectwise[month]['physics'].toString())),
          DataCell(Text(neetSubjectwise[month]['chemistry'].toString())),
          DataCell(Text(neetSubjectwise[month]['zoology'].toString())),
          DataCell(Text(neetSubjectwise[month]['botney'].toString())),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(Text("13")),
          DataCell(Text(neetSubjectwise[month]['physics'].toString())),
          DataCell(Text(neetSubjectwise[month]['chemistry'].toString())),
          DataCell(Text(neetSubjectwise[month]['zoology'].toString())),
          DataCell(Text(neetSubjectwise[month]['botney'].toString())),
        ]),  
      ]);
    }
  }
  Widget dataTableOtherComplete(){
    if(otherComplete!=null){
    return DataTable(
      columnSpacing: 1,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Exam"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Fees"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Discount"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Final Fee"),
          numeric: false,
          ),
      ], 
      rows: otherRowViewComplete(),
      );
    }
  }


  otherRowViewComplete(){
    List<DataRow> widget =[];
     if(otherComplete!=null){
      otherComplete.forEach((key, value) {
        widget.add(
          DataRow(cells: <DataCell>[
            DataCell(Text(key)),
            DataCell(Text(value['price'].toString(),style: TextStyle(decoration:TextDecoration.lineThrough),)),
            DataCell(Text(value['discount'].toString())),
            DataCell(Text((int.parse(value['price'])-int.parse(value['discount'])).toString())),
          ]),
        );
      });
    }
     return widget;
  }

  iitJeeView(){
    return ExpansionTile(
      title: Text('IIT-JEE'),
      children: [
                DefaultTabController(
           length: 2, 
           initialIndex: 0,
           child: Column(
             children: [
               TabBar(tabs: [
                 Tab(text: 'Subject Wise',),
               Tab(text:'Complete')
               ]),
               Container(
                 height: 300,
                 child: TabBarView(
                   children: [
                      DefaultTabController(
                          length: 5, 
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(tabs: [
                                Tab(text: 'Month',),
                              Tab(text:'3 Month'),
                              Tab(text:'6 Month'),
                              Tab(text:'Year'),
                              Tab(text:'2Year'),
                              ]),
                              Container(
                                height: 250,
                                child: TabBarView(
                                  children: [
                                   dataTableIitJee('month'),
                                   dataTableIitJee('3month'),
                                   dataTableIitJee('6month'),
                                   dataTableIitJee('year'),
                                   dataTableIitJee('2year'),
                                  ]
                                  ),
                              ),
                            ],
                          ),
                          ),
                     Container(
                       height: 300,
                       child: completeIITJEEView(),
                     )
                   ]
                   ),
               ),
             ],
           ),
           )
      ],
    );
  }
  neetView(){
    return ExpansionTile(
      title: Text('NEET'),
      children: [
                DefaultTabController(
           length: 2, 
           initialIndex: 0,
           child: Column(
             children: [
               TabBar(tabs: [
                 Tab(text: 'Subject Wise',),
               Tab(text:'Complete')
               ]),
               Container(
                 height: 300,
                 child: TabBarView(
                   children: [
                    //  Center(
                    //    child: 
                    //    Text("Subject Wise"),
                    //    ),
                      DefaultTabController(
                          length: 4, 
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(tabs: [
                                Tab(text: 'Month',),
                              Tab(text:'3 Month'),
                              Tab(text:'6 Month'),
                              Tab(text:'Year'),
                              ]),
                              Container(
                                height: 250,
                                child: TabBarView(
                                  children: [
                                   dataTableNeet('month'),
                                   dataTableNeet('3month'),
                                   dataTableNeet('6month'),
                                   dataTableNeet('year'),
                                  ]
                                  ),
                              ),
                            ],
                          ),
                          ),
                     Container(
                       height:250,
                       child:completeNeetView(),
                     )
                   ]
                   ),
               ),
             ],
           ),
           )
      ],
    );
  }
  
  dataTableOtherSubjectWise(){
    if(otherSubjectwise!=null){
     return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text("Subject"),
          numeric: false,
          ),
        DataColumn(
          label: Text("Fees"),
          numeric: false,
          ),
      ], 
      rows:otherRowViewSubjectWise(),
      );
    }
  }

  otherRowViewSubjectWise(){
     List<DataRow> widget =[];
     print(otherSubjectwise);
if(otherSubjectwise!=null){

    otherSubjectwise.forEach((key, value) {
      widget.add(
         DataRow(cells: <DataCell>[
          DataCell(Text(key)),
          DataCell(Text(value.toString())),
        
        ]),
      );
     });
}
     return widget;
  }

  otherView(){
    return ExpansionTile(
      title: Text('Other Competitive Exams'),
      children: [
                DefaultTabController(
           length: 2, 
           initialIndex: 0,
           child: Column(
             children: [
               TabBar(tabs: [
                 Tab(text: 'Subject Wise',),
               Tab(text:'Complete')
               ]),
               Container(
                 height: 300,
                 child: TabBarView(
                   children: [
                  
                     Container(
                                height: 300,
                                child: dataTableOtherSubjectWise(),
                              ),
                     Container(
                                height: 300,
                                child: dataTableOtherComplete(),
                              ),
                   ]
                   ),
               ),
             ],
           ),
           )
      ],
    );
  }

 Widget _buildContent(){
      if(_isLoading==true && 
      iitjeeComplete ==null && iitjeeSubjectwise ==null && 
      neetComplete ==null && neetSubjectwise ==null &&
      otherComplete ==null && otherSubjectwise == null){
        return _buildLoadingContainer();
      }else{
         return  ListView(
      children: [
        iitJeeView(),
        neetView(), 
        otherView(), 
      ],
    );
    }
 }

 @override
  void dispose() {
    super.dispose();
  }


    Widget _buildstory({Widget body}){
      return  Scaffold(
    appBar: AppBar(
      title: Text("Pricing"),
    ),
    body:
    WillPopScope(
      onWillPop: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(true)));
      },
      child:
      Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        
      child: _buildContent(),
     
    )
    )
    );
     
    }


     Widget  _buildLoadingContainer(){
      return Center(
                  child: CircularProgressIndicator(),
               );
    }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return _buildstory();
  }

}