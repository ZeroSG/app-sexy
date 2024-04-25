import 'package:flutter/material.dart';

import '../../Style/style.dart';
import 'forgot5.dart';


class forgot4 extends StatefulWidget {
  const forgot4({super.key});

  @override
  State<forgot4> createState() => _forgot4State();
}

class _forgot4State extends State<forgot4> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Colors.white,
        body: Container(
               height: MediaQuery.of(context).size.height*1,
               width: MediaQuery.of(context).size.width*1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Container(
               height: 210,
               width:  MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage('assets/images/Back-button-login-Regis2.png',),
                        fit: BoxFit.fill,
                       ),
                   ),
               child: Column(children: [
                 
                 Padding(
                   padding: const EdgeInsets.only(top: 50,right: 35,left: 35),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       InkWell(
                         onTap: () {
                           Navigator.pop(context);
                         },
                         child: Container(
                             alignment: Alignment.topLeft,
                             height: 20,
                             width: MediaQuery.of(context).size.width,
                           child: Image.asset(
                              'assets/images/icons8-chevron-left-100 6.png',
                            ),
                         ),
                       ),
                         Container(height: 20,),
                       Text('ส่ง OTP',textScaleFactor: 1.0,style: textwhite20,),
                         Container(height: 10,),
                         Text('เลือกช่องทางการส่ง OTP ผ่านทางอีเมลหรือเบอร์โทรศัพท์ของคุณ',style: textwhite18),
                     ],
                   ),
                 ),
              
                
               ]),    
             ),
              Padding(
                padding: const EdgeInsets.only(right: 30,left: 30,top: 30),
                child: Expanded(child: Container(
                   child: Column(
                     children: [
                      Container(
                        color: Color(0xffEFEFEF),
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                      'assets/images/Rectangle 57.png',
                                    ),
                              ),
                            ),
                          ),
                             Container(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                    Container(
                                      child: Text('อีเมล',textScaleFactor: 1.0,style: textblack133,),
                                    ),
                                     Container(
                                      child: Text('Test@gmail.com',textScaleFactor: 1.0,style: text979696,), 
                                     ),
                                 ],
                               ),
                             ),
                          ],
                        ),
                      ),
                      Container(height: 30,), 
                       Container(
                        color: Color(0xffEFEFEF),
                        height: 80,
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Container(
                             margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 242, 0),
              shape: BoxShape.circle,
            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                      'assets/images/Rectangle 58.png',
                                    ),
                              ),
                            ),
                          ),
                        
                             Container(
                               child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                    Container(
                                      child: Text('เบอร์โทรศัพท์',textScaleFactor: 1.0,style: textblack133,),
                                    ),
                                     Container(
                                      child: Text('080-1234567',textScaleFactor: 1.0,style: text979696,), 
                                     ),
                                 ],
                               ),
                             ),
                          ],
                        ),
                      ),
                        Padding(
                     padding: const EdgeInsets.only(right: 0,left: 0,top: 50),
                     child: TextButton(
                              onPressed: () {
                          
                                  MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => forgot5());
                              Navigator.push(context, route);
                                
                                
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                              
                                child: Text(
                                  'ถัดไป',textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                              style: textwhite20
                                ),
                              ),
                                style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 0, 0)),
                          ),
                            ),
                   ),   
                     ],
                   ),
                 )),
              ),
               Container(
                           alignment: Alignment.bottomLeft,
                           height: 150,
                           width:  MediaQuery.of(context).size.width*0.5,
                         child: Image.asset(
                            'assets/images/Ellipse 39_2.png',
                          ),
                       ),
          ]),
        ),
    );
  }
}