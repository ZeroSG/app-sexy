// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Style/style.dart';
import 'Widget/login/login.dart';
import 'Widget/register/register.dart';
import 'my_constant.dart';

class Home_Start extends StatefulWidget {
  const Home_Start({super.key});

  @override
  State<Home_Start> createState() => _Home_StartState();
}

class _Home_StartState extends State<Home_Start> {
  @override
  void initState() {
   
    super.initState();
     show_logo();
  }


   Future<void> show_logo() async {
    try {
      setState(() {
        loading = true;
      });
        SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_logo');
       var ressum = await http.get(uri,
      headers: {
       "Authorization":access_token
      }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         logo  =lnformation['data']['data'][0]['path'].toString();
          loading = false;
       
        
                
 
       
         
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
                child: Center(child: CircularProgressIndicator())): Stack(
                  children: [
                    Container(
          height: MediaQuery.of(context).size.height*0.85,
          width: MediaQuery.of(context).size.width,
          child: Container(
                              //  height:MediaQuery.of(context).size.height,
                              //  width: MediaQuery.of(context).size.width,
                             child: Image.asset('assets/images/หน้าเเรก.Logo_pages-to-jpg-0002.jpg',
                                 fit: BoxFit.fill,
                                                       ),
                             
                           
               ),
     
      ),
                   Container(
              
              //  height: 330,
               width:  MediaQuery.of(context).size.width,
              
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 0,right: 35,left: 35),
                   child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Hello',textScaleFactor: 1.0,style: TextStyle(

  fontSize: 70,
  fontWeight: FontWeight.w400,
  color: const Color.fromARGB(255, 0, 0, 0),
),),
                         Container(height: 0,),
                         Text('Welcome to Universe exo group food ',textScaleFactor: 1.0,style: TextStyle(

  fontSize: 14,
  // fontWeight: FontWeight.bold,
  color: const Color.fromARGB(255, 0, 0, 0),
)),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 30,right: 90,left: 90),
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
                                'Login',textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                            style: TextStyle(
  // fontFamily: 'IBM',
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black,
)
                              ),
                            ),
                              style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xffFCF6AC)),
                        ),
                          ),
                 ),
                 Padding(
                   padding: const  EdgeInsets.only(top: 15,right: 90,left: 90,bottom: 30),
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
                                'Sign up',textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                            style: TextStyle(
  // fontFamily: 'IBM',
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black,
)
                              ),
                            ),
                              style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xffF696A2)),
                        ),
                          ),
                 ),
               ]),    
             ),
                  ],
                ),
    );
  }
}
