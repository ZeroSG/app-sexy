import 'package:flutter/material.dart';

class MyConstant {
  //Demo
  String domain = 'https://universe-exogroupfood.com/api';
   String domain2 = 'https://universe-exogroupfood.com/public/';

  //    String domain = 'https://fern.orangeworkshop.info/sexy/api';
  //  String domain2 = 'https://fern.orangeworkshop.info/sexy/public/';
  // String pathImage = 'http://dee.orangeworkshop.info/wilsonart_demo/images';

  MyConstant();


  
}
 Future<dynamic> newindex1(BuildContext context,var URL) {
    return showDialog(
        barrierColor: Color.fromARGB(255, 148, 174, 149).withOpacity(0.3),
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image.network('$URL'),
                  ),       
                ));
          });
        });
  }

