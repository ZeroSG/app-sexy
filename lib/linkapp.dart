 import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

import 'Widget/Menu/product/CartOrder2.dart';
import 'my_constant.dart';





Future<void> checkDeepLink(BuildContext context) async {
     StreamSubscription? _sub;
  try {
    //print("checkDeepLink123");
    // await UniLink.getInitialLink();
   
    _sub = linkStream.listen((String? link) { 
      if (link != null){

        // //print('link ===> $link');
        //  MaterialPageRoute route = MaterialPageRoute(
        //                               builder: (context) => SecondPay(link:link));
        //                           Navigator.push(context, route);
       var url =Uri.parse(link);
        // normalDialog(context,'$link','$link');
      //     Navigator.of(context).pop();
  
      // Navigator.pop(context,'SS');
        //print('link ===> ${url.toString()}');
        if(url == '${MyConstant().domain}/callback'){
            MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => CartOrder2(index:'2'),);
        Navigator.push(context, route);
        }
            
      //  if(url.queryParameters['scan_qr'] != null){
      //    //print('link ===> ${url.queryParameters['scan_qr'].toString()}');
      //       // MaterialPageRoute route = MaterialPageRoute(
      //       //                           builder: (context) => SecondPay(link:url.queryParameters['scan_qr'].toString()));
      //       //                       Navigator.push(context, route);
      //  }
      }
    },onError:(err){

    });
  //   _sub = UniLink.getUriLinksStream().listen((Uri? uri)async {
  // // HttpOverrides.global = MyHttpOverrides();
  //     //  await Firebase.initializeApp().then((value) async {
  //     //          await FirebaseMessaging.instance.getInitialMessage().then((value) async {
  //     //                FirebaseMessaging.onBackgroundMessage(_firebaseMBH);
  //     // //print('uri===>1');
  //     // await _p.setUrl(uri.toString());
  //     // runApp(MyApp());
  //     // });
  //     //       });
  //   }, onError: (err) {
  //     // Handle exception by warning the user their action did not succeed

  //     //print("onError");
  //   });
  } on PlatformException {
    //print("PlatformException");
  }
}