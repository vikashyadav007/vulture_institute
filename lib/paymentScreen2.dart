// import 'package:flutter/material.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// // import 'package:webview_flutter/webview_flutter.dart';



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
//   WebViewController _webController;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _webController = null;
//     super.dispose();
//   }

//   String _loadHTML() {
//     return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='${widget.data['url']}'><input type='hidden' name='orderID' value='ORDER_${DateTime.now().millisecondsSinceEpoch}'/>" +
//         "<input  type='hidden' name='custID' value='${widget.data['custID']}' />" +
//         "<input  type='hidden' name='amount' value='${widget.data['amount']}' />" +
//         "<input type='hidden' name='custEmail' value='${widget.data['custEmail']}' />" +
//         "<input type='hidden' name='custPhone' value='${widget.data['custPhone']}' />" +
//         "</form> </body> </html>";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body:Container(
//           width:MediaQuery.of(context).size.width,
//           height:MediaQuery.of(context).size.height,
//           child:WebView(
//             debuggingEnabled: false,
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (controller){
//              _webController = controller;
//               _webController
//                       .loadUrl(new Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString());
//             },
//           )
//         ),
//       ),

//     );
//   }
  
// }