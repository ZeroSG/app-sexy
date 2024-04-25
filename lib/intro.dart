import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Home_Start.dart';
import 'my_constant.dart';

class IntroHome extends StatefulWidget {
  const IntroHome({super.key});

  @override
  State<IntroHome> createState() => _IntroHomeState();
}

class _IntroHomeState extends State<IntroHome> {
  @override
  void initState() {
      show_logo();
   
    super.initState();
  }
   late String? logo = '';
    bool loading = true;
    Future<void> show_logo() async {
    try {
      setState(() {
        loading = true;
      });
      var uri = Uri.parse('${MyConstant().domain}/show_logo');
       var ressum = await http.get(uri,
      
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         logo  =lnformation['data']['data'][0]['path'].toString();
          loading = false;
         Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home_Start()), (route) => false);
    });
        
                
 
       
         
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Colors.white,

          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          
          elevation: 0,
         
        ),
      backgroundColor: Colors.white,
      body:   Container(
    
        child:  Center(
          child: loading ?  CircularProgressIndicator()
          : Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.network(
                    'https://fern.orangeworkshop.info/sexy/public/upload/logo/$logo',
                    // width:double.infinity,
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                   
                  ),
          ),
        ),
            
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //      Container(
      //          alignment: Alignment.topRight,
      //          height: MediaQuery.of(context).size.height*0.2,
      //          width: MediaQuery.of(context).size.width,
      //        child: Image.asset(
      //           'assets/images/Ellipse 40.png',
      //           // width:double.infinity,
      //           // width: MediaQuery.of(context).size.width,
      //           // height: MediaQuery.of(context).size.height,
      //           // fit: BoxFit.fill,s
      //         ),
      //      ),
      //        Container(
      //          alignment: Alignment.bottomLeft,
      //          height: MediaQuery.of(context).size.height*0.3,
      //          width: MediaQuery.of(context).size.width,
      //          child: Image.asset(
      //           'assets/images/Ellipse 39.png',
      //           // width:double.infinity,
      //           // width: MediaQuery.of(context).size.width,
      //           // height: 50,
      //           // fit: BoxFit.fill,s
      //                    ),
      //        ),
      //     // Center(
      //     //   child: Image.asset(
      //     //     'assets/images/Home-Start.png',
      //     //     // width:double.infinity,
      //     //     // width: MediaQuery.of(context).size.width,
      //     //     // height: MediaQuery.of(context).size.height,
      //     //     fit: BoxFit.fill,
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
