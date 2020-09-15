// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';




// class PaymentScreen extends StatefulWidget{
//   Map<String,String> data;
//   PaymentScreen(this.data);
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return PaymentScreenState();
//     throw UnimplementedError();
//   }
// }

// class PaymentScreenState extends State<PaymentScreen>{

//   // static const platform = const MethodChannel('razorpay_flutter');

//   Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }


//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _razorpay.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body:Container(
//           width:MediaQuery.of(context).size.width,
//           height:MediaQuery.of(context).size.height,
//           child:Text(""),
//         ),
//       ),

//     );
//   }
  
// }