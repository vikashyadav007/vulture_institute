// import 'package:crackit/paymentSchema.dart';
// import 'package:crackit/stateModel.dart';
// import 'package:crackit/stateWidget.dart';
// import 'package:flutter/material.dart';

// import 'home.dart';


// class SelectSubjectSub extends StatefulWidget{
//   List<PaymentSchema> paymentSChema;
//   SelectSubjectSub(this.paymentSChema);
//   @override
//   State<StatefulWidget> createState() {
   
//     return SelectSubjectSubState();
//   }
  
// }


// class SelectSubjectSubState extends State<SelectSubjectSub>{
//   StateModel appState;
//   bool _isLoading;

//    @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _isLoading = true;
//     });
//      getData();
//   }

//   getData(){
//     List<PaymentSchema> paymentSchema = appState.studentInfo.paymentSchema;
//     if(paymentSchema == null){
//         print("Payment Schema is null");
//     }else{
//       paymentSchema.forEach((element) {
//           print(element.paymentDescription.course);
//           print(element.paymentDescription.type);
//           print(element.paymentDescription.standard);
//           print(element.paymentDescription.subject);
//       });
//     }
//   }


//   Widget _buildContent(){
//       if(_isLoading==true){
//         return _buildLoadingContainer();
//       }else{
//          return  ListView(
//       children: [
//       Center(child:Text("Say my name")),
//       ],
//     );
//     }
//  }


//    Widget _buildstory({Widget body}){
//       return  Scaffold(
//     appBar: AppBar(
//       title: Text("Pricing"),
//     ),
//     body:
//     WillPopScope(
//       onWillPop: (){
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(true)));
//       },
//       child:
//       Padding(
//         padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        
//       child: _buildContent(),
     
//     )
//     )
//     );
     
//     }


//      Widget  _buildLoadingContainer(){
//       return Center(
//                   child: CircularProgressIndicator(),
//                );
//          }

//   @override
//   Widget build(BuildContext context) {
//      appState = StateWidget.of(context).state;
//     return _buildstory();
//   }
  
// }