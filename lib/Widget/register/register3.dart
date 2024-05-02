import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Style/style.dart';
import '../../my_constant.dart';
import 'register4.dart';
import 'package:http/http.dart' as http;



class register3 extends StatefulWidget {
    Map<String,dynamic>? User;
      String? Code;
      bool? isChecked;
   register3({super.key,this.User,this.Code,this.isChecked});

  @override
  State<register3> createState() => _register3State();
}



class _register3State extends State<register3> {
  late TextEditingController _OTP1 = TextEditingController();
  late TextEditingController _OTP2 = TextEditingController();
  late TextEditingController _OTP3 = TextEditingController();
  late TextEditingController _OTP4 = TextEditingController();
    late TextEditingController _OTP5 = TextEditingController();
  late TextEditingController _OTP6 = TextEditingController();
   late Map<String,dynamic>? User= widget.User;
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
                       Text('OTP',style: textwhite20,),
                         Container(height: 10,),
                         Text('หมายเลข otp จากอีเมลหรือเบอร์โทรศัพท์ของคุณ',style: textwhite18),
                     ],
                   ),
                 ),
               
                 
               ]),    
             ),
             Container(
               height: 50,
             ),
             Padding(
               padding: const EdgeInsets.only(right: 20,left: 20),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Expanded(child: OTP(context,_OTP1)),
                        Expanded(child: OTP(context,_OTP2)),
                         Expanded(child: OTP(context,_OTP3)),
                          Expanded(child: OTP(context,_OTP4)),
                          Expanded(child: OTP(context,_OTP5)),
                          Expanded(child: OTP(context,_OTP6)),
                         
                     ],
                   ),
             ),
                  Padding(
                     padding: const EdgeInsets.only(right: 30,left: 30,top: 50),
                     child: TextButton(
                              onPressed: () {
                                if(widget.isChecked == false){
                                   if('${_OTP1.text}${_OTP2.text}${_OTP3.text}${_OTP4.text}${_OTP5.text}${_OTP6.text}' == widget.Code){
                                 createWo();
                                }
                                }else{
                                  // createWo();
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




    Future createWo() async {
    try {

      print(User);
      var url = Uri.parse('${MyConstant().domain}/register');
      EasyLoading.show(status: 'กำลังบันทึกข้อมูล');


      var response = await http.MultipartRequest('POST', url);
      response.fields['name'] =  User!['username'];
      response.fields['email'] =  User!['email'];
       response.fields['phone'] =  User!['phone'];

        response.fields['password'] =  User!['password'];
           response.fields['app'] =  User!['app'];
        
      
     
      
    
     
      

      var res = await response.send();
      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('บันทึกข้อมูลสำเร็จ').then((value)async {
            MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => register4());
                              Navigator.push(context, route);
        });
      } else {
        var response = await http.Response.fromStream(res);
        var jsonResponse =
            await jsonDecode(response.body) as Map<String, dynamic>;
        printWrapped(jsonResponse['message'].toString());
        EasyLoading.showError(jsonResponse['message'].toString());
      }
    } catch (error) {
      printWrapped(error.toString());
      EasyLoading.showError(error.toString());
    }

   
  }

   void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

}