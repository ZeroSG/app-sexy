


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../linkapp.dart';
import '../../../my_constant.dart';
import 'CartOrder2.dart';





class Pay extends StatefulWidget {
  String? id_U ;


   Pay({super.key,this.id_U});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> { 



late WebViewController _webViewController;






@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDeepLink(context);
  }

     late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
   
     screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    print('${widget.id_U}');
    return Scaffold(backgroundColor:Colors.white,
     
      body: Stack(
        children: [
          Container(
            color: Color(0xFF02A89C),
          ),
          Container(
            // color: Colors.amber,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            height: screenH * 1,
            width: double.infinity,
            child:  WebView(
          initialUrl: '${widget.id_U}',
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
              setState(() {
                
                print('object1 == $url');
                // currentUrl = url;
              });
            },
            onWebViewCreated: (controller) {
              setState(() {
                  _webViewController = controller;
              });
  
    // copyDataFromWebPage();
   
  },
            onPageFinished: (url) async{
               
               
                  var i = url.split('://').first;
                  print(url);
                  print(i);
                    if(i == 'https'){
                          setState(() {
                              if(url == '${MyConstant().domain}/callback'){
                               MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => CartOrder2(index:'2'),);
        Navigator.push(context, route);
                        // MaterialPageRoute route = MaterialPageRoute(
                        //               builder: (context) => ConfirmChillpay_ststus_success(bill_id:bill_id));
                        //           Navigator.push(context, route);
                  
                  }
                  
                  // if(url == '${MyConstant().domain}/ConfirmChillpay_ststus?success=error'){
                  //     //  MaterialPageRoute route = MaterialPageRoute(
                  //     //                 builder: (context) => ConfirmChillpay_ststus_error(bill_id:bill_id));
                  //     //             Navigator.push(context, route);
                  // }        
                            
                    });
                                }else{
                            
                               
                                   String Url = url;
                                    Navigator.pop(context);
                                       await launch(Url);
                                  // Navigator.pop(context);
                                  //   MaterialPageRoute route = MaterialPageRoute(
                                  //     builder: (context) => ConfirmChillpay_ststus_success(bill_id: widget.bill_id,));
                                  // Navigator.push(context, route);
                                }
                 
                  print('object2 == $url');
                // currentUrl = url;
            
            },
        ),
          ),
        ],
      ),
    );
  //    Scaffold(
  //   appBar: AppBar(
  //         title: Text('pay'),
  //       ),
  //     body: WebView(
  //         initialUrl: '${widget.id_U}',
  //         javascriptMode: JavascriptMode.unrestricted,
  //         onPageStarted: (url) {
  //             setState(() {
                
  //               print('object1 == $url');
  //               // currentUrl = url;
  //             });
  //           },
  //           onWebViewCreated: (controller) {
  //             setState(() {
  //                 _webViewController = controller;
  //             });
  
  //   // copyDataFromWebPage();
   
  // },
  //           onPageFinished: (url) async{
               
               
  //                 var i = url.split('://').first;
  //                   if(i == 'https'){
  //                         setState(() {
  //                             if(url == '${MyConstant().domain}/ConfirmChillpay_ststus?success=success'){
              
  //                       MaterialPageRoute route = MaterialPageRoute(
  //                                     builder: (context) => ConfirmChillpay_ststus_success(bill_id:bill_id));
  //                                 Navigator.push(context, route);
                  
  //                 }
                  
  //                 if(url == '${MyConstant().domain}/ConfirmChillpay_ststus?success=error'){
  //                      MaterialPageRoute route = MaterialPageRoute(
  //                                     builder: (context) => ConfirmChillpay_ststus_error(bill_id:bill_id));
  //                                 Navigator.push(context, route);
  //                 }        
                            
  //                   });
  //                               }else{
  //                                 Usersharedpreferences _p = Usersharedpreferences();
  //                                  await _p.setbill_id('$bill_id');
  //                                  String Url = url;
  //                                  await launch(Url);
                                   
  //                               }
                 
  //                 print('object2 == $url');
  //               // currentUrl = url;
            
  //           },
  //       ),
      
  //   );
}

//   _launchURL(String url) async {
// if (await canLaunch(url)) {
//     setState(() {
                            
   
//    });
//   await launch(url);
//   /// Wait until the browser closes
 
// } else {
  
// }}


_launchURL(String url) async {
if (await canLaunch(url)) {
    
  await launch(url);
  /// Wait until the browser closes
 
} else {
  
}}
}