import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Home_Start.dart';
import '../../../my_constant.dart';
import '../../register/register4.dart';
import '../menu.dart';

class Account_Settings extends StatefulWidget {
  const Account_Settings({super.key});

  @override
  State<Account_Settings> createState() => _Account_SettingsState();
}

class _Account_SettingsState extends State<Account_Settings> {
     late TextEditingController _name = TextEditingController();
  late TextEditingController _phone = TextEditingController();
  late TextEditingController _email = TextEditingController();
  late TextEditingController _gender = TextEditingController();
  late TextEditingController _birthday = TextEditingController();
   
   String name = '';
   String img = '';
   bool loading = true;
   late  Map<String,dynamic> _genders ={
     'id': 0,
     'nameTH': '',
     'nameEN': '',
   };
late  Map<String,dynamic> users;
  Future<void> show_user() async {
  try {
    setState(() {
      loading = true;
    });
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('id').toString();
    var uri = Uri.parse('${MyConstant().domain}/show_user');
    var ressum = await http.post(uri,
        // headers: {
        //   // "Content-Type": "application/json",
        // },
        body: {
          "id_user": user_id.toString(),
        });
    if (ressum.statusCode == 200) {
      var lnformation = jsonDecode(ressum.body);
      setState(() {

        users = lnformation['data']['data'][0];
          img = users['path'].toString();
        _name.text = users['name'].toString();
        _phone.text = users['phone'].toString();
        _email.text = users['email'].toString();
        _gender.text = users['gender'].toString();
        _birthday.text = users['birthday'].toString();
       if(_gender.text == 'male'){
        _genders ={
     'id': 1,
     'nameTH': 'ชาย',
     'nameEN': 'male',
   };
       }else if(_gender.text == 'female'){
        _genders ={
     'id': 2,
     'nameTH': 'หญิง',
     'nameEN': 'female',
   };
       }
        if(_birthday.text == 'null'){

        }else{
           now = DateTime.parse(_birthday.text);
        }
       
      // for (var data in lnformation['data']) {
      //   mergedData.addAll(data[0]);
      // }
          //  List<dynamic> combinedData = lnformation['data'].expand((element) => element).toList();

    
      // product_users == product_userss;

        loading = false;
      });
    } else {
      setState(() {
       
               loading = false;
      });
      // loading = false;
      // var lnformation = jsonDecode(ressum.body);
      // print('product_users=== $lnformation');
    }
  } catch (e) {
    print('e ===>2 ${e.toString()} ');
  }
}

 
@override
  void initState() {
    // TODO: implement initState
    super.initState();
show_user();
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
                              'บัญชี',
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
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                'โปรไฟล์',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenW * 1,
                height: 127,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                 
                             
                  Image.asset(
                      'assets/images/Back-Profile.png',
                      height: 127,
                      width: screenW * 1,
                      fit: BoxFit.fill,
                    ),
                  
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       fileimg == null ?    Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(10),
                            image: new DecorationImage(
                              image: new AssetImage(
                                  'assets/images/Ellipse 13.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: img == ''|| img == 'null'?  Padding(
                            padding: const EdgeInsets.all(15.0),
                            child:Image.asset(
                              'assets/images/Rectangle 17_2.png',
                              height: 26,
                            )
                          ):ClipRRect(borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                          '${MyConstant().domain2}/$img',
                                           height: 70,
                                           width: 70,
                                            fit: BoxFit.fill,
                                        ),
                                  ),
                        )
                        :Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                       
                          child: Container(
                                child: ClipRRect(
                                   borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                      fileimg!,
                                    width: 70,
                                    height: 70,
                                     fit: BoxFit.fill,
                                    ),
                                ),
                              ),
                        ),
                        GestureDetector(
                          onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (ctx) => _buildBottomSheet(
                                      ctx));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Text(
                                'แตะเพื่อเปลี่ยน',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    TextField0(
                      context,
                      'ชื่อ',
                      '${_name.text}',
                      n1,
                      () {
                        setState(() {
                          if (n1 == 1) {
                            n1 = 2;
                          } else {
                            n1 = 1;
                          }
                        });
                      },_name,
                    ),
                    TextField0(
                      context,
                      'เบอร์โทรศัพท์',
                      '${_phone.text}',
                      n2,
                      () {
                        setState(() {
                          if (n2 == 1) {
                            n2 = 2;
                          } else {
                            n2 = 1;
                          }
                        });
                      },_phone
                    ),
                    TextField0(
                      context,
                      'อีเมล',
                     '${_email.text}',
                      n3,
                      () {
                        setState(() {
                          if (n3 == 1) {
                            n3 = 2;
                          } else {
                            n3 = 1;
                          }
                        });
                      },_email
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'เพศ',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color: Color(0xff979696),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            '${_genders['nameTH']}',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Color(0xff979696),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (n4 == 1) {
                                                  n4 = 2;
                                                } else {
                                                  n4 = 1;
                                                }
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Image.asset(
                                                'assets/images/Rectangle 97.png',
                                                height: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              n4 == 1
                                  ? Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'ชาย',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff979696),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                    _genders ={
     'id': 1,
     'nameTH': 'ชาย',
     'nameEN': 'male',
   };
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: _genders['id'] == 1
                                                        ? Container(
                                                            height: 27,
                                                            // margin: EdgeInsets.only(top: 10, bottom: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              //  borderRadius: BorderRadius.circular(10),
                                                              image:
                                                                  new DecorationImage(
                                                                image: new AssetImage(
                                                                    'assets/images/Ellipse 35.png'),
                                                                // fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/Rectangle 153.png',
                                                                height: 20,
                                                              ),
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            'assets/images/Ellipse 36.png',
                                                            height: 25,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'หญิง',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff979696),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                    _genders ={
     'id': 2,
     'nameTH': 'หญิง',
     'nameEN': 'female',
   };
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: _genders['id'] == 2
                                                        ? Container(
                                                            height: 27,
                                                            // margin: EdgeInsets.only(top: 10, bottom: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              //  borderRadius: BorderRadius.circular(10),
                                                              image:
                                                                  new DecorationImage(
                                                                image: new AssetImage(
                                                                    'assets/images/Ellipse 35.png'),
                                                                // fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/Rectangle 153.png',
                                                                height: 20,
                                                              ),
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            'assets/images/Ellipse 36.png',
                                                            height: 25,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )
                                  : Container(),
                            ]),
                          )
                        ],
                      ),
                    ),
                    Container(
            margin: EdgeInsets.only(top: 0, bottom: 10),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),
                    Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'วันเกิด',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color: Color(0xff979696),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                         _birthday.text == 'null' ? Text('')
                                         : Text(
                                            DateFormat('dd/MM/yyyy').format(now),
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Color(0xff979696),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              DateTime now1 = now;
                                             showCupertinoModalPopup(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 300,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: CupertinoDatePicker(
                                                            
                                                            // minimumYear :DateTime.now().year,
                                                            maximumYear: DateTime.now().year,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              use24hFormat: true,
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .date,
                                                              initialDateTime: now1,
                                                              onDateTimeChanged:
                                                                  (DateTime newTime) {
                                                                setState(() {
                                                                  now1 = newTime;
                                                                  _birthday.text = '${newTime.year.toString().padLeft(4, '0')}-${newTime.month.toString().padLeft(2, '0')}-${newTime.day.toString().padLeft(2, '0')}';
                                                                });
                                                              },
                                                              
                                                            ),
                                                        ),
                                                        TextButton(onPressed: () {
               Navigator.pop(context);
               setState(() {
                 now = now1;
               });
              // api_postcalendar();

            }, child: Container(
                decoration: BoxDecoration(
    color: Colors.green, // สีพื้นหลังของ Container
   borderRadius: BorderRadius.circular(15),
  ),
              margin: EdgeInsets.only(right: 5,left: 5),
              //  height: 60,
              //  width: 100,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('ยืนยัน', textScaleFactor: 1.0,
                          style: TextStyle(
                            
                    
                    fontSize: 22,
                    color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                ),
              ),
            )),
                                                      ],
                                                    ),
                                                    
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Image.asset(
                                                'assets/images/Rectangle 160.png',
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
               Container(
                 margin: EdgeInsets.only(top: 0,bottom: 0,right: 10,left: 10),
                 child: GestureDetector(onTap: () {
                             
                          createWo();
               
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

               Container(
                 margin: EdgeInsets.only(top: 0,bottom: 10,right: 10,left: 10),
                 child: GestureDetector(onTap: () {
                             
                         delete_account();
               
                           }, child: Container(
                  decoration: BoxDecoration(
                   color: Color.fromARGB(255, 255, 0, 0),
                  borderRadius: BorderRadius.circular(15),
                 ),
                             margin: EdgeInsets.only(right: 5,left: 5,top: 20),
                             //  height: 60,
                             //  width: 100,
                             child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     
                        Text('ลบข้อมูล', textScaleFactor: 1.0,
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

  late int n1 = 1;
  int n2 = 1;
  int n3 = 1;
  int n4 = 1;
  int n4_2 = 0;
  DateTime now = DateTime.now();
  Container TextField0(
      BuildContext context, var name, var name2, int n, Function()? onTap,TextEditingController controller) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: n == 1
                      ? Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$name',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xff979696),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '$name2',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xff979696),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //  color: Color(0xff979696),
                          ),
                          margin: EdgeInsets.only(top: 10), //ขนาดแยกบน
                          // width: screenW * 0.75,
                          child: TextField(
                             controller: controller,
                            style: TextStyle(
                                color: Colors.black), //เปลี่ยนสี่คำใน inPut
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Color(0xff979696),
                              ), //เปลี่ยนสี่คำใน hin
                              labelText: '$name',
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
                InkWell(
                  onTap: onTap,
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Image.asset(
                      'assets/images/Rectangle 163.png',
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 10),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),
        ],
      ),
    );
  }

 var namefile;
  File? fileimg;

  Future<Null> chooseImage2(
      ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        // maxWidth: 800,
        // maxHeight: 800,
      );

      setState(() {
        print("สำเร็จ");

        fileimg = File(result!.path);
        namefile = result.path.toString().split('/').last;

        //  fileimg = File(result!.path);
        //  namefile = result.path.toString().split('/').last;

        // fileimg!['$num'] = File(result!.path);
        //  filename[num]['name'] = result.path.toString().split('/').last;
      });
    } catch (e) {}
  }

   Container _buildBottomSheet(
      BuildContext context) {
    // children: snapshot.data.docs.map((document){
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 4.0),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        children: [
          Container(
            height: 45.5,
            width: screenW * 1,
            child: GestureDetector(
                onTap: () {
                  chooseImage2(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.white,
                  width: screenW * 1,
                  height: 45.5,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.add_a_photo,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'ถ่ายรูป',
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            height: 1,
            width: screenW * 1,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
            ),
          ),
          Container(
            height: 45.5,
            width: screenW * 1,
            child: GestureDetector(
                onTap: () {
                  chooseImage2(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.white,
                  width: screenW * 1,
                  height: 45.5,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.add_photo_alternate,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'อัปโหลดรูป',
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future createWo() async {
    try {
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();

      var url = Uri.parse('${MyConstant().domain}/edit_account');
      EasyLoading.show(status: 'กำลังแก้ไขข้อมูล');
      print('user_id===>${user_id}') ;
      print('_name.text===>${_name.text}') ;
      print('_email.text===>${_email.text}') ;
      print('_phone.text===>${_phone.text}') ;
      print('_genders===>${_genders['nameEN']}') ;
       print('birthday===>${_birthday.text}') ;
       print('fileimg===>${fileimg}') ;
      
      var response = await http.MultipartRequest('POST', url);
      response.fields['id'] =  user_id;
      response.fields['name'] =  _name.text;
       response.fields['email'] =  _email.text;
        response.fields['phone'] =  _phone.text;
        response.fields['birthday'] =  _birthday.text;
           response.fields['gender'] =  _genders['nameEN'];
      
        
      
     
        if (fileimg != null) {

        String fileNameImageSelfie =
            fileimg!.path.split('/').last;
        response.files.add(await http.MultipartFile.fromPath(
            'path',
            fileimg!.path,
            filename: fileNameImageSelfie));
              print('path');
      }else{
    
      }
    
     
      

      var res = await response.send();
      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('บันทึกข้อมูลสำเร็จ').then((value)async {
            routToService();
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




  Future delete_account() async {
    try {
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();

      var url = Uri.parse('${MyConstant().domain}/delete_account');
      EasyLoading.show(status: 'กำลังลบข้อมูล');

      
      var response = await http.MultipartRequest('POST', url);
      response.fields['id'] =  user_id;

      var res = await response.send();
      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('ลบข้อมูลสำเร็จ').then((value)async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
                             preferences.clear();
                           MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Home_Start(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
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



   Future routToService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('name', _name.text);
    preferences.setString('email', _email.text);
    preferences.setString('phone', _phone.text);
    preferences.setString('birthday', _birthday.text);
    preferences.setString('gender', _genders['nameTH']);

    
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=>    Menu(index:3),), (route) => false);
  //  MaterialPageRoute route =
  //       MaterialPageRoute(builder: (context) => Menu(Data_User:Data_User,index: 0,));
  //   Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

}
