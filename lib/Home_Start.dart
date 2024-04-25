import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Style/style.dart';
import 'Widget/login/login.dart';
import 'Widget/register/register.dart';

class Home_Start extends StatefulWidget {
  const Home_Start({super.key});

  @override
  State<Home_Start> createState() => _Home_StartState();
}

class _Home_StartState extends State<Home_Start> {
  @override
  void initState() {
   
    super.initState();
     Logo();
  }


  Future<void> Logo() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();

         
      setState(() {
          logo = preferences.getString('logo').toString();
        loading = false;
      });
              
     
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }
String name = '',logo = '';
 bool loading = true;
  late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
         screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
 
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Colors.white,

          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          
          elevation: 0,
         
        ),
      backgroundColor: Colors.white,
      body:   
      
     loading ? 
                        Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator())): Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Expanded(
               child: Center(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                           alignment: Alignment.center,
                           height: 200,
                           width: MediaQuery.of(context).size.width,
                         child: Image.network(logo)
                       ),
                         
                      
                     ],
                   ),
               ),
               
             ),
            
             Container(
               height: 330,
               width:  MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage('assets/images/Back-button-login-Regis.png',),
                        fit: BoxFit.fill,
                       ),
                   ),
               child: Column(children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 70,right: 35,left: 35),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('ยินดีต้อนรับ',textScaleFactor: 1.0,style: textwhite20,),
                         Container(height: 10,),
                         Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',textScaleFactor: 1.0,style: textwhite18),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(30.0),
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
                                'เข้าสู่ระบบ',textScaleFactor: 1.0,
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
                 Padding(
                   padding: const EdgeInsets.only(right: 30,left: 30),
                   child: TextButton(
                            onPressed: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => Register());
                              Navigator.push(context, route);
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                            
                              child: Text(
                                'สมัครสมาชิก',textScaleFactor: 1.0,
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
             
          ],
        ),
      ),
    );
  }
}
