import 'package:flutter/material.dart';

import '../../Style/style.dart';
import '../login/login.dart';



class register4 extends StatefulWidget {
  const register4({super.key});

  @override
  State<register4> createState() => _register4State();
}

class _register4State extends State<register4> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child:  Scaffold(
         backgroundColor: Color(0xffC63A30),
         body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffC63A30), Color(0xffDC63A30)],
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
                              child: Text('สำเร็จ !',style: textblack20700,),
                            ),
                          Text('เข้าสู่ระบบสำเร็จเรียบร้อย',style: textwhite18,),
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
                                'ตกลง',
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