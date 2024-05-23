import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Style/style.dart';
import '../../../my_constant.dart';
import 'otpaccount2.dart';

class otpaccount extends StatefulWidget {
  Map<String,dynamic>? User;
   otpaccount({super.key,this.User});

  @override
  State<otpaccount> createState() => _otpaccountState();
}

class _otpaccountState extends State<otpaccount> {

 
 late Map<String,dynamic>? User= widget.User;
bool isChecked = false;
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
                       Text('ส่ง OTP',style: textwhite20,),
                         Container(height: 10,),
                         Text('เลือกช่องทางการส่ง OTP ผ่านทางอีเมลหรือเบอร์โทรศัพท์ของคุณ',style: textwhite18),
                     ],
                   ),
                 ),
              
                
               ]),    
             ),
              Padding(
                padding: const EdgeInsets.only(right: 30,left: 30,top: 30),
                child: Container(
                   child: Column(
                     children: [
                      GestureDetector(
                        onTap: () {
                           setState(() {
                             isChecked = false;
                           });
                        },
                        child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffEFEFEF),
                                                                border: Border.all(color: isChecked == false ? Color(0xffBD2325):Colors.white, width: 1),
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                        
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
                                        child: Text('อีเมล',style: textblack133,),
                                      ),
                                       Container(
                                        child: Text('${User!['email']}',style: text979696,), 
                                       ),
                                   ],
                                 ),
                               ),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 30,), 
                       GestureDetector(
                         onTap: () {
                           setState(() {
                             isChecked = true;
                           });
                         },
                         child: Container(
                         decoration: BoxDecoration(
                           
                                  color: Color(0xffEFEFEF),
                                                                border: Border.all(color: isChecked == true ? Color(0xffBD2325):Colors.white, width: 1),
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
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
                                        child: Text('เบอร์โทรศัพท์',style: textblack133,),
                                      ),
                                       Container(
                                        child: Text('${User!['phone']}',style: text979696,), 
                                       ),
                                   ],
                                 ),
                               ),
                            ],
                          ),
                                             ),
                       ),
                        Padding(
                     padding: const EdgeInsets.only(right: 0,left: 0,top: 50),
                     child: TextButton(
                              onPressed: () {
                                if(isChecked == false){
                                sendEmail();
                                }else{
                                sendMobile();
        
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
                     ],
                   ),
                 )
              ),
               Container(
                        //    alignment: Alignment.bottomLeft,
                        //    height: 150,
                        //    width:  MediaQuery.of(context).size.width*0.5,
                        //  child: Image.asset(
                        //     'assets/images/Ellipse 39_2.png',
                        //   ),
                       ),
          ]),
        ),
    );
  }


    late String? Code = '';
    bool loading = true;
    Future<void> sendEmail() async {
    try {
      setState(() {
        loading = true;
      });
  
      var uri = Uri.parse('${MyConstant().domain}/sendEmail');
       var ressum = await http.post(uri,
       
        body: {
         'email': '${User!['email']}'
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         Code  =lnformation['data']['confirmationCode'].toString();
          loading = false;
             MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => otpaccount2(User:User,Code:Code,isChecked: isChecked,));
                              Navigator.push(context, route);
        
                
 
       
         
        });
          // data_promotion_stores();
    }else {
     setState(() {
         loading = false;
      });
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


    Future<void> sendMobile() async {
    try {
      setState(() {
        loading = true;
      });
   
      var uri = Uri.parse('${MyConstant().domain}/sendMobile');
       var ressum = await http.post(uri,
      
        body: {
         'phone': '${User!['phone']}'
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         Code  =lnformation['data'].toString();
         print(Code);
         Map<dynamic, dynamic>? response = json.decode(lnformation['data']['response']);
          print(response);
          loading = false;
             MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => otpaccount2(User:User,isChecked: isChecked,response:response));
                              Navigator.push(context, route);
        
                
 
       
         
        });
          // data_promotion_stores();
    }else {
     setState(() {
         loading = false;
      });
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }

}