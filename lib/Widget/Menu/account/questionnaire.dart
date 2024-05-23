import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import '../../register/register4.dart';
import '../menu.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
     late TextEditingController _text = TextEditingController();

   
  
   bool loading = false;
  
  

 
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Container(
            margin: EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/icons8-chevron-left-100 8.png',
              height: 18,
            ),
          ), // เปลี่ยนไอคอนตามที่ต้องการ
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: loading ? 
                        Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator())): SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'แบบสอบถาม',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Image.asset(
                          'assets/images/Line 5.png',
                          height: 18,
                        ),
                      ),
                     
                    ],
                  ),
                ),
              ),
             
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              //  color: Color(0xff979696),
                            ),
                            margin: EdgeInsets.only(top: 10), //ขนาดแยกบน
                            // width: screenW * 0.75,
                            child: TextField(
                               controller: _text,
                              style: TextStyle(
                                  color: Colors.black), //เปลี่ยนสี่คำใน inPut
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Color(0xff979696),
                                ), //เปลี่ยนสี่คำใน hin
                                labelText: 'ข้อความ',
                                // prefixIcon: Icon(
                                //   Icons.perm_identity,
                                //   color: const Color.fromARGB(255, 141, 141, 141),
                                // ),
                                enabledBorder: OutlineInputBorder(
                                  //กรอบสี่เหลี่ยม
                                  borderRadius:
                                      BorderRadius.circular(20), //ขนาดมุม
                                  borderSide:
                                      BorderSide(color: const Color.fromARGB(255, 0, 0, 0)), //สี
                                ),
                                focusedBorder: OutlineInputBorder(
                                  //กรอบสี่เหลี่ยม
                                  borderRadius:
                                      BorderRadius.circular(20), //ขนาดมุม
                                  borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            )),
              ),
               Container(
                 margin: EdgeInsets.only(top: 0,bottom: 10,right: 10,left: 10),
                 child: GestureDetector(onTap: () {
                             if(_text.text == ''){

                             }else{
                              createWo();
                             }
                          
               
                           }, child: Container(
                  decoration: BoxDecoration(
                   color: Color(0xff000000),
                  borderRadius: BorderRadius.circular(15),
                 ),
                             margin: EdgeInsets.only(right: 5,left: 5,top: 30),
                             //  height: 60,
                             //  width: 100,
                             child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     
                        Text('ยืนยัน', textScaleFactor: 1.0,
                                style: TextStyle(
                                  
                          
                          fontSize: 12,
                          color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                      ],
                    ),
                  ),
                             ),
                           )),
               ),
            ]),
          ),
        ),
      ),
    );
  }

 



  Future createWo() async {
    try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
       String user_id = preferences.getString('id').toString();

      var url = Uri.parse('${MyConstant().domain}/form_question');
      EasyLoading.show(status: 'กำลังส่งข้อมูล');

      
      var response = await http.MultipartRequest('POST', url);
      response.headers['Authorization'] = access_token;
      response.fields['id_user'] =  user_id;
      response.fields['text'] =  _text.text;
      var res = await response.send();
      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('ส่งข้อมูลสำเร็จ').then((value)async {
           Navigator.pop(context);
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
