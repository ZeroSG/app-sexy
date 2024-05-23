import 'package:flutter/material.dart';

import '../../Style/style.dart';
import '../login/login.dart';



class forgot6 extends StatefulWidget {
  const forgot6({super.key});

  @override
  State<forgot6> createState() => _forgot6State();
}

class _forgot6State extends State<forgot6> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child:  Scaffold(
         backgroundColor: Color(0xffBD2325),
         body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffBD2325), Color(0xffD34739)],
            ),
          ),  
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                             margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
         
              shape: BoxShape.circle,
            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 220,
                                width: 280,
                                child: Image.asset(
                                      'assets/images/Screenshot 2024-05-17 095903.png',
                                      fit: BoxFit.fill,
                                    ),
                              ),
                            ),
                          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('สำเร็จ !',textScaleFactor: 1.0,style: textblack20700,),
                            ),
                          Text('เข้าสู่ระบบสำเร็จเรียบร้อย',textScaleFactor: 1.0,style: textwhite18,),
                Padding(
                   padding: const EdgeInsets.all(40.0),
                   child: TextButton(
                            onPressed: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => Login());
                              Navigator.push(context, route);
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                            
                              child: Text(
                                'ตกลง',textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                            style: textblack20
                              ),
                            ),
                              style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xffE9EFFF)),
                        ),
                          ),
                 ),
              ],
            )),
          ),
      ),
    );
  }
}