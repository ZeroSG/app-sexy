import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../Style/style.dart';
import '../Forgot password/forgot1.dart';
import '../login/google_sigin_api.dart';
import 'register1.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _userController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

bool isChecked = false;
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
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
                       Text('สมัครสมาชิก',style: textwhite20,),
                         Container(height: 10,),
                         Text('จุดเริ่มต้นของความสุข คืออาหารที่อร่อย',style: textwhite18),
                     ],
                   ),
                 ),
               
                
               ]),    
             ),
             Expanded(
                child: SingleChildScrollView(
                     physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    TextFieldlogin('ชื่อผู้ใช้',_userController,30.0),
                      TextFieldlogin('อีเมล',_emailController,0.0),
                      TextFieldlogin('รหัสผ่าน',_passwordController,0.0),
                      //  Padding(
                      //    padding: const EdgeInsets.only(right: 30,left: 20,top: 0),
                      //    child: Row(
                      //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //      children: [
                      //        Row(
                      //          children: [
                      //            Checkbox(
                      //               checkColor: Colors.white,
                      //               activeColor: Color.fromARGB(255, 255, 1, 1),
                      //               value: isChecked,
                      //               onChanged: (bool? value) {
                      //                 setState(() {
                      //                   isChecked = value!;
                      //                   print(isChecked);
                      //                 });
                      //               },
                      //             ),
                      //            Text('ยืนยันตัวตนของคุณ',style: textblack131),
                      //          ],
                      //        ),
                      //        GestureDetector(
                      //          onTap: () {
                      //             MaterialPageRoute route = MaterialPageRoute(
                      //             builder: (context) => forgot1());
                      //         Navigator.push(context, route);
                      //          },
                      //           child: Text('รีเซ็ตรหัสผ่าน ?',style: textblack132),
                      //        ),
                      //      ],
                      //    ),
                      //  ),
                       Padding(
                     padding: const EdgeInsets.only(right: 30,left: 30,top: 20),
                     child: TextButton(
                              onPressed: () {
                                if(_userController.text != ''&&_emailController.text != ''&&_passwordController.text != ''){
                            setState(() {
                              Map<String,dynamic> User = {
                                'username':_userController.text,
                                 'email':_emailController.text,
                                  'password':_passwordController.text,
                                   'phone':'',
                                   'app':'login',
                              };
                                  MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => register1(User:User));
                              Navigator.push(context, route);
                            });
                              
                          
                                }else{

                                }
                               
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                              
                                child: Text(
                                  'สมัครสมาชิก',
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
                     Text('หรือ',style: textblack133),
                     Container(height: 10,),
                       Text('เข้าสู่ระบบผ่าน :',style: textblack131),
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
                              Text('เข้าสู่ระบบด้วย Google',style: textblack131),
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
                                                             'assets/images/Apple Login.jpg',
                                                           ),
                               ),
                            Text('เข้าสู่ระบบด้วย Apple ',style: textblack131,),
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

  Padding TextFieldlogin(String hintText, TextEditingController controller,double top1,) {
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



  Future sigIn()async{
 final user = await GoogleSignInApi.login();

 if(user == null){
   print('user === > 3 $user');
 }else{
 
  Map<String,dynamic> User = {
                                'username':'${user.displayName}',
                                 'email':'${user.email}',
                                  'password':'${user.id}',
                                   'phone':'',
                                   'app':'google',
                              };
                               MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => register1(User:User));
                              Navigator.push(context, route);
 }
}
}
