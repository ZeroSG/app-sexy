import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Home_Start.dart';
import '../../Style/style.dart';
import '../../my_constant.dart';
import '../Forgot password/forgot1.dart';
import '../Menu/menu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'Receive_the_product.dart';
import 'google_sigin_api.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

bool isChecked = false;
  @override
  void initState() {
   
    super.initState();
    _checkIfIsLogged();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Colors.white,
      body:   
      
      Container(
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
                            MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => Home_Start());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
                       Text('เข้าสู่ระบบ',textScaleFactor: 1.0,style: textwhite20,),
                         Container(height: 10,),
                         Text('ยินดีต้อนรับ เข้าสู่ร้านของเรา ',textScaleFactor: 1.0,style: textwhite18),
                     ],
                   ),
                 ),
               
                
               ]),    
             ),
             Expanded(
                child: SingleChildScrollView(
                     physics: BouncingScrollPhysics(),
                  child: Column(children: [
                      TextFieldlogin(1,'อีเมล',_emailController,30.0),
                      TextFieldlogin(2,'รหัสผ่าน',_passwordController,0.0),
                       Padding(
                         padding: const EdgeInsets.only(right: 30,left: 20,top: 0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
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
                                 Text('ยืนยันตัวตนของคุณ',textScaleFactor: 1.0,style: textblack131),
                               ],
                             ),
                             GestureDetector(
                               onTap: () {
                                    MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => forgot1());
                              Navigator.push(context, route);
                               },
                                child: Text('รีเซ็ตรหัสผ่าน ?',textScaleFactor: 1.0,style: textblack132),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                     padding: const EdgeInsets.only(right: 30,left: 30,top: 20),
                     child: TextButton(
                              onPressed: () {
                                // _opengrabt();
                                if(_emailController.text != ''&&_passwordController.text != ''){
             login(_emailController.text,_passwordController.text);
          }                
                        //        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        //  builder: (context)=>    Menu(),), (route) => false);
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                              
                                child: Text(
                                  'เข้าสู่ระบบ',textScaleFactor: 1.0,
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
                   Container(height: 10,),
                     Text('หรือ',textScaleFactor: 1.0,style: textblack133),
                     Container(height: 10,),
                       Text('เข้าสู่ระบบผ่าน :',textScaleFactor: 1.0,style: textblack131),
                       Container(height: 10,),
                       Padding(
                         padding: const EdgeInsets.only(right: 30,left: 30,top: 0),
                         child: InkWell(
                           onTap: () {
                             sigIn();
                           },
                           child: Card(
                             elevation: 5,
                             color: Color(0xffFFFFFF),
                             shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                  child: Container(
                                    height: 50,
                                      decoration: BoxDecoration(
                               border: Border.all(color: Color(0xffFFFFFF), width: 1),
                               borderRadius: BorderRadius.circular(30),
                               color: Color(0xffFFFFFF),
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                 Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 40,
                                   child: Image.asset(
                                                               'assets/images/Group 2.png',
                                                             ),
                                 ),
                              Text('เข้าสู่ระบบด้วย Google',textScaleFactor: 1.0,style: textblack131),
                              Container(
                                margin: EdgeInsets.only(right: 30),
                                 width: 20,
                                child: Image.asset(
                                  'assets/images/Rectangle 179.png',
                                ),
                              ),
                             ],
                           ),
                                  ),
                           ),
                         ),
                       ),
                       Container(height: 5,),
                        Padding(
                         padding: const EdgeInsets.only(right: 30,left: 30,top: 0),
                          child: InkWell(
                            onTap: () {
                              _login();
                            },
                            child: Card(
                             elevation: 5,
                             shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                  child: Container(
                                    height: 50,
                                      decoration: BoxDecoration(
                               border: Border.all(color: Color(0xffFFFFFF), width: 1),
                               borderRadius: BorderRadius.circular(30),
                               color: Color(0xffFFFFFF),
                                                 ),
                                                 child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                 Container(
                                    margin: EdgeInsets.only(left: 20),
                                     width: 40,
                                   child: Image.asset(
                                                               'assets/images/Group 1.png',
                                                             ),
                                 ),
                              Text('เข้าสู่ระบบด้วย Facebook',textScaleFactor: 1.0,style: textblack131,),
                              Container(
                                 margin: EdgeInsets.only(right: 30),
                                width: 20,
                                child: Image.asset(
                                  'assets/images/Rectangle 179.png',
                                ),
                              ),
                             ],
                                                   ),
                                  ),
                                                 ),
                          ),
                        ),
                          Container(height: 5,),
                    Platform.isIOS ?    Padding(
                         padding: const EdgeInsets.only(right: 30,left: 30,top: 0),
                          child: SignInWithAppleButton(
                            borderRadius :BorderRadius.all(Radius.circular(30.0)),
  onPressed: () async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential);

    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  },
),
                        )
                    : Container(),
                     Container(height: 5,),
                  ]),
                ),
               ),
        
            
             
             
          ],
        ),
      ),
    );
  }

  Padding TextFieldlogin(int obscure , String hintText, TextEditingController controller,double top1) {
    return Padding(
                    padding:  EdgeInsets.only(right: 30,left: 30,top :top1),
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
                          obscureText: obscure == 2? true:false,
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
      if(isChecked == true){
        preferences.setString('usernamelogin', _emailController.text);
    preferences.setString('password', _passwordController.text);
      }else{
 preferences.setString('usernamelogin', '');
    preferences.setString('password', '');
      }
   
  
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=>    Receive_the_product(),), (route) => true);
  //  MaterialPageRoute route =
  //       MaterialPageRoute(builder: (context) => Menu(Data_User:Data_User,index: 0,));
  //   Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}
AccessToken? _accessToken;
  bool _checking = true;
Map<String, dynamic>? _userData;



  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }




    void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  Future<void> _login() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });
  }


Future sigIn()async{
 final user = await GoogleSignInApi.login();

 if(user == null){
   print('user === > 3 $user');
 }else{
   print('user === > 1 $user');
 }
}
   
}
