import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Home_Start.dart';
import 'Widget/login/Receive_the_product.dart';
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
         Future.delayed(const Duration(seconds: 3), () async{
           SharedPreferences preferences = await SharedPreferences.getInstance();

     usernamelogin = preferences.getString('usernamelogin').toString();
      password = preferences.getString('password').toString();
      if(usernamelogin == ''||password == ''||usernamelogin == 'null'||password == 'null'){
        Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home_Start()), (route) => false);
      }else{
        print(usernamelogin);
         print(password);
          login(usernamelogin,password);
      }
     
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
  String usernamelogin = '';
  String password = '';
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


   Future<void> login(var Username,var password) async {
    try {
      EasyLoading.show(status: 'กำลังตรวจสอบข้อมูล');
      var uri = Uri.parse('${MyConstant().domain}/login');
       var ressum = await http.post(uri,
       body: {
         "email": Username,
         "password": password,  
       }
            );
               print('12345===>${ressum.statusCode}');   
      if(ressum.statusCode == 200) {
       EasyLoading.showSuccess('เข้าสู่ระบบ').then((value)async {
        var result11 = jsonDecode(ressum.body);
         
         
      setState(() {
        late Map<String, dynamic> calendarData;
        calendarData = result11['data'];
        String? token = '${result11['token_type']} ${result11['access_token']}';
        //  DataUser Data_User =
        //       DataUser.fromJson(result11["user"][0]);
              routToService(calendarData,token);
      });
       });
    }else {
      EasyLoading.showError(jsonDecode(ressum.body)['message'].toString());
      print(jsonDecode(ressum.body)) ;  
    }
    } catch (e) {
      print('e ===> ${e.toString()} ');
    }
  }


   Future routToService(var Data_User,var access_token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', Data_User['id'].toString());
    preferences.setString('name', Data_User['name'].toString());
    preferences.setString('email', Data_User['email'].toString());
    preferences.setString('phone', Data_User['phone'].toString());
    preferences.setString('path', Data_User['path'].toString());
    preferences.setString('phone', Data_User['phone'].toString());
    preferences.setString('email', Data_User['email'].toString());
    preferences.setString('birthday', Data_User['birthday'].toString());
    preferences.setString('gender', Data_User['gender'].toString());
    preferences.setString('age', Data_User['age'].toString());
      preferences.setString('access_token', access_token.toString());
      
    preferences.setString('usernamelogin', usernamelogin);
    preferences.setString('password', password);
  
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=>    Receive_the_product(),), (route) => true);
  //  MaterialPageRoute route =
  //       MaterialPageRoute(builder: (context) => Menu(Data_User:Data_User,index: 0,));
  //   Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
