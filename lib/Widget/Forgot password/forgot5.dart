import 'package:flutter/material.dart';

import '../../Style/style.dart';
import 'forgot6.dart';




class forgot5 extends StatefulWidget {
  const forgot5({super.key});

  @override
  State<forgot5> createState() => _forgot5State();
}



class _forgot5State extends State<forgot5> {
  late TextEditingController _OTP1 = TextEditingController();
  late TextEditingController _OTP2 = TextEditingController();
  late TextEditingController _OTP3 = TextEditingController();
  late TextEditingController _OTP4 = TextEditingController();
  
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
                       Text('OTP',textScaleFactor: 1.0,style: textwhite20,),
                         Container(height: 10,),
                         Text('หมายเลข otp จากอีเมลหรือเบอร์โทรศัพท์ของคุณ',textScaleFactor: 1.0,style: textwhite18),
                     ],
                   ),
                 ),
               
                 
               ]),    
             ),
             Container(
               height: 50,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     OTP(context,_OTP1),
                      OTP(context,_OTP2),
                       OTP(context,_OTP3),
                        OTP(context,_OTP4),
                   ],
                 ),
                  Padding(
                     padding: const EdgeInsets.only(right: 30,left: 30,top: 50),
                     child: TextButton(
                              onPressed: () {
                          
                                  MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => forgot6());
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
    );
  }



  Container OTP(BuildContext context,var OTP) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
           decoration: BoxDecoration(
            border: Border.all(color: Color(0xff979696), width: 2),
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffEFEFEF),
          ),
                                    height: 50,
                                    width: 50,
                                    child: TextFormField(
                                          controller: OTP,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      //  readOnly :readOnly1,
                                      decoration:  InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        counterText: '',
                                        hintStyle: TextStyle(
                                            color: Colors.black, fontSize: 20.0),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 10.0),
                                        filled: true,
                                        fillColor: Color.fromARGB(0, 246, 246, 246)
                                      ),
                                       style: TextStyle(
                                              fontSize: 18,fontWeight: FontWeight.w600),
                                      onChanged: (value) {
                                        
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  ),
      ),
    );
  }
}