import 'package:flutter/material.dart';

import '../../Style/style.dart';
import 'register1_1.dart';
import 'register2.dart';


class register1 extends StatefulWidget {
    Map<String,dynamic>? User;
   register1({super.key,this.User});

  @override
  State<register1> createState() => _register1State();
}

class _register1State extends State<register1> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Colors.white,
        body: Container(
               height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
               child: Column(
                 children: [
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
                       Text('เข้าถึงข้อมูลของคุณ',style: textwhite20,),
                         Container(height: 10,),
                         Text('อนุญาติให้เข้าถึงข้อมูลของคุณ',style: textwhite18),
                     ],
                   ),
                 ),
                
                
               ]),    
             ),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(right: 30,left: 30,top: 30),
                child: Container(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                       Text('เงื่อนไขทั่วไป',style: textblack132,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           color: const Color.fromARGB(255, 252, 252, 252),
                           height: MediaQuery.of(context).size.height*0.25,
                           child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                             child: Column(
                               children: [
                                 Text('1. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'),
                                  Text('2. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'),
                                   Text('3. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'),
                                    Text('4. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'),
                                     Text('5. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'),
                               ],
                             ),
                           ),
                         ),
                       ),
                       Row(
                               children: [
                                 Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Color.fromARGB(255, 255, 1, 1),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        print(isChecked);
                                      });
                                    },
                                  ),
                                 Text('ฉันยอมรับเงื่อนไขและข้อกำหนด',style: textblack131),
                               ],
                             ),
                          Padding(
                     padding: const EdgeInsets.only(right: 0,left: 0,top: 20),
                     child: TextButton(
                              onPressed: () {
                                if(isChecked){
                                  MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => register1_1(User:widget.User));
                              Navigator.push(context, route);
                                }
                                
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                              
                                child: Text(
                                  'ถัดไป',
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
                     ]),
                   ),
              )),
              // Container(
              //              alignment: Alignment.bottomLeft,
              //              height: 130,
              //              width:  MediaQuery.of(context).size.width*0.5,
              //            child: Image.asset(
              //               'assets/images/Ellipse 39_2.png',
              //             ),
              //          ),
          ]),
        ),
    );
  }
}