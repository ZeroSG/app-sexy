import 'package:flutter/material.dart';

import '../../Style/style.dart';
import 'forgot2.dart';


class forgot1 extends StatefulWidget {
  const forgot1({super.key});

  @override
  State<forgot1> createState() => _forgot1State();
}

class _forgot1State extends State<forgot1> {
    late TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Colors.white,
        body: Container(
               height: MediaQuery.of(context).size.height*1,
          width: MediaQuery.of(context).size.width*1,
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
                       Text('ลืมรหัสผ่าน',style: textwhite20,textScaleFactor: 1.0,),
                         Container(height: 10,),
                         Text('ระบุที่อยู่อีเมลที่ลงทะเบียนของคุณ',textScaleFactor: 1.0,style: textwhite18),
                     ],
                   ),
                 ),
                
                
               ]),    
             ),
              SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                child: Expanded(child: Padding(
                  padding: const EdgeInsets.only(right: 25,left: 25,bottom: 70),
                  child: Container(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                         
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                             color: const Color.fromARGB(255, 252, 252, 252),
                            //  height: MediaQuery.of(context).size.height*0.25,
                             child:  TextFieldlogin('อีเมล',_emailController,10),
                           ),
                         ),
                         
                            Padding(
                       padding: const EdgeInsets.only(right: 10,left: 10,top: 40),
                       child: TextButton(
                                onPressed: () {
                                   
                                    MaterialPageRoute route = MaterialPageRoute(
                                    builder: (context) => forgot2(email:_emailController.text));
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
                       ]),
                     ),
                )),
              ),
              
          ]),
        ),
    );
  }

    Padding TextFieldlogin(String hintText, TextEditingController controller,double top1,) {
    return Padding(
                    padding:  EdgeInsets.only(right: 0,left: 0,top :top1),
                    child: Container(
                        decoration: BoxDecoration(
                          // border: Border.all(color: Color(0xffEFEFEF), width: 1),
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffEFEFEF),
                        ),
                        height: 50,
                        margin: EdgeInsets.only(top: 16),
                        // width: screenW * 0.85,
                        child: TextField(
                           controller: controller,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.only(top: 10,left: 20),
                            border: InputBorder.none,
                            // prefixIcon: Icon(
                            //   Icons.person_outline_rounded,
                            //   color: Color(0xffd4d4d4),
                            // ),
                            hintText: '$hintText',
                            hintStyle: TextStyle(color: Color(0xffAFAFAF)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Color(0xffEFEFEF)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Color(0xffEFEFEF)),
                            ),
                          ),
                        ),
                      ),
                  );
                  }
}