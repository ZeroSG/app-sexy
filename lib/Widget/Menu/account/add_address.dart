import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../my_constant.dart';


class APP_address extends StatefulWidget {
   APP_address({super.key});

  @override
  State<APP_address> createState() => _APP_addressState();
}

class _APP_addressState extends State<APP_address> {
  bool loading = true;
  late  List<dynamic>? citys = [];
  Future<void> city() async {
    try {
      setState(() {
        loading = true;
      
      });
 SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
      var uri = Uri.parse('${MyConstant().domain}/city');
       var ressum = await http.get(uri,
      headers: {
       "Authorization":access_token
      }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         print(lnformation);
         citys  =lnformation['data']['data'];
      
        // print(show_deliverys);
                 loading = false;
 
       
         
        });
          // data_promotion_stores();
    }else {
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


  late  List<dynamic>? get_amupurss = [];
  Future<void> get_amupurs(var city) async {
    try {
        setState(() {
       
      });
 SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
      var uri = Uri.parse('${MyConstant().domain}/get_amupurs');
       var ressum = await http.post(uri,headers: {
       "Authorization":access_token
      },
       body: {
         'id_province':city.toString()
       },
      
            );
          // print(ressum.statusCode);    
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
        //  print(lnformation);
         get_amupurss  =lnformation['data']['data'];
         get_amupurss!.insert(0, {
         "id": 'กรุณาเลือกเขต',
        "code": "",
        "name_th": "กรุณาเลือกเขต",
        "name_en": "กรุณาเลือกเขต",
        "province_id": null,
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },);

        // print(show_deliverys);
                //  loading = false;
 
       
         
        });
          // data_promotion_stores();
    }else {
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


  late  List<dynamic>? get_tambonss = [];
  Future<void> get_tambons(var ampurs) async {
    try {
   
 SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
      var uri = Uri.parse('${MyConstant().domain}/get_tambons');
       var ressum = await http.post(uri,headers: {
       "Authorization":access_token
      },
       body: {
         'id_ampurs':ampurs.toString()
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         
         get_tambonss  =lnformation['data']['data'];
         get_tambonss!.insert(0, {
        "id": 'กรุณาเลือกแขวง',
        "zip_code": "",
        "name_th": "กรุณาเลือกแขวง",
        "name_en": "กรุณาเลือกแขวง",
        "amupur_id": null,
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },);

      // print(get_tambonss);
        // print(show_deliverys);
                //  loading = false;
 
       
         
        });
          // data_promotion_stores();
    }else {
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }



 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    city();
  }
       late TextEditingController _name = TextEditingController();
  late TextEditingController _phone = TextEditingController();
  // late TextEditingController _email = TextEditingController();
  late TextEditingController _address = TextEditingController();
  late TextEditingController _postcode = TextEditingController();
    late TextEditingController _province = TextEditingController();
  late TextEditingController _district = TextEditingController();
  late TextEditingController _subdistrict = TextEditingController();
     late TextEditingController _province2 = TextEditingController();
  late TextEditingController _district2 = TextEditingController();
  late TextEditingController _subdistrict2 = TextEditingController();
  late TextEditingController _streetAddress = TextEditingController();
    late TextEditingController _status = TextEditingController();
  late TextEditingController _address_details = TextEditingController();
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
                child: Center(child: CircularProgressIndicator())):SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(children: [
               Row(
                        children: [
                          Container(
                            child: Text(
                              'บัญชีของฉัน',
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
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),
          Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                'ช่องทางการติดต่อ',
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
                        TextField0(context,'ชื่อ-นามสกุล',() {
                        setState(() {});},_name),

  TextField0(context,'เบอร์โทรศัพท์',() {
                        setState(() {});},_phone),
  Container(
                        margin: EdgeInsets.only(bottom: 10,top: 10),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                'ที่อยู่',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField0(context,'ที่อยู่',() {
                        setState(() {});},_address),
                        Container(
                                                          // decoration: BoxDecoration(
                                                          //   border: Border.all(color: Color(0xffBD2325), width: 1),
                                                          //   borderRadius: BorderRadius.circular(10),
                                                          //   color: Color(0xffFFFFFF),
                                                          // ),
                                                          height: 40,
                                                          margin: EdgeInsets.only(top: 16,bottom: 10),
                                                          // width: screenW * 0.85,
                                                          child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //   width: 1,
                      //   color: Color(0xffBD2325)
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(18, 7, 15, 12),
                    border: OutlineInputBorder(
                      //  borderSide: BorderSide(
                      //   width: 1,
                      //   color: Color(0xffBD2325)
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'กรุณาเลือกจังหวัด',
                    // style: textContentGrey,
                  ),
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down, // You can use a different icon if you prefer
                    color: Color.fromARGB(255, 0, 0, 0), // Set the color to red
                  ),
                  iconSize: 20,
              
                  items: citys!
                      .map((item) => DropdownMenuItem<String>(
                            value: item!['id'].toString(),
                            child: Text(
                              item!['name_th'].toString(),
                              // style: textContentGrey,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    print('value===>$value');
                    if (value == null) {
                      return 'กรุณาเลือก';
                    }
                  },
                  onChanged: (value)async {
                    setState(() {
                      _province.text = value.toString();
                          get_tambonss = [{
        "id": 'กรุณาเลือกแขวง',
        "zip_code": "",
        "name_th": "กรุณาเลือกแขวง",
        "name_en": "กรุณาเลือกแขวง",
        "amupur_id": null,
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },];
          get_amupurss = [{
         "id": 'กรุณาเลือกเขต',
        "code": "",
        "name_th": "กรุณาเลือกเขต",
        "name_en": "กรุณาเลือกเขต",
        "province_id": null,
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      }];
          _subdistrict.text = 'กรุณาเลือกแขวง';
            _district.text = 'กรุณาเลือกเขต';
          _postcode.text = '';
          _district2.text = '';
          _subdistrict2.text = '';
          for(var province2 in citys!){
                         if(province2['id'].toString() == value.toString()){
                          
                            _province2.text = province2['name_th'].toString();
                         }
                      }
                      get_amupurs(_province.text);
                    });
                  },
                  onSaved: (value) {
                    // selectedValue = value.toString();
                  },
                ),
                                                        
                                                    
                                ),

                 Container(
                                                          // decoration: BoxDecoration(
                                                          //   border: Border.all(color: Color(0xffBD2325), width: 1),
                                                          //   borderRadius: BorderRadius.circular(10),
                                                          //   color: Color(0xffFFFFFF),
                                                          // ),
                                                          height: 40,
                                                          margin: EdgeInsets.only(top: 16,bottom: 10),
                                                          // width: screenW * 0.85,
                                                          child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //   width: 1,
                      //   color: Color(0xffBD2325)
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(18, 7, 15, 12),
                    border: OutlineInputBorder(
                      //  borderSide: BorderSide(
                      //   width: 1,
                      //   color: Color(0xffBD2325)
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'กรุณาเลือกเขต',
                    // style: textContentGrey,
                  ),
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down, // You can use a different icon if you prefer
                    color: Color.fromARGB(255, 0, 0, 0), // Set the color to red
                  ),
                  iconSize: 20,
                  value: _district.text,
                  items: get_amupurss!
                      .map((item) => DropdownMenuItem<String>(
                            value: item!['id'].toString(),
                            child: Text(
                              item!['name_th'].toString(),
                              // style: textContentGrey,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    print('value===>$value');
                    if (value == null) {
                      return 'กรุณาเลือก';
                    }
                  },
                  onChanged: (value)async {
                    setState(() {
                      _district.text = value.toString();
                       get_tambonss = [{
        "id": 'กรุณาเลือกแขวง',
        "zip_code": "",
        "name_th": "กรุณาเลือกแขวง",
        "name_en": "กรุณาเลือกแขวง",
        "amupur_id": null,
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },];
         _subdistrict.text = 'กรุณาเลือกแขวง';
          _postcode.text = '';
           _subdistrict2.text = '';
          for(var district2 in get_amupurss!){
                         if(district2['id'].toString() == value.toString()){
                          
                            _district2.text = district2['name_th'].toString();
                         }
                      }
                      get_tambons(_district.text);
                    });
                  },
                  onSaved: (value) {
                    // selectedValue = value.toString();
                  },
                ),
                                                        
                                                    
                                ),     


                   Container(
                                                          // decoration: BoxDecoration(
                                                          //   border: Border.all(color: Color(0xffBD2325), width: 1),
                                                          //   borderRadius: BorderRadius.circular(10),
                                                          //   color: Color(0xffFFFFFF),
                                                          // ),
                                                          height: 40,
                                                          margin: EdgeInsets.only(top: 16,bottom: 10),
                                                          // width: screenW * 0.85,
                                                          child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //   width: 1,
                      //   color: Color(0xffBD2325)
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(18, 7, 15, 12),
                    border: OutlineInputBorder(
                      //  borderSide: BorderSide(
                      //   width: 1,
                      //   color: Color(0xffBD2325)
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'กรุณาเลือกแขวง',
                    // style: textContentGrey,s
                  ),
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down, // You can use a different icon if you prefer
                    color: Color.fromARGB(255, 0, 0, 0), // Set the color to red
                  ),
                  iconSize: 20,
                  value: _subdistrict.text,
                  items: get_tambonss!
                      .map((item) => DropdownMenuItem<String>(
                            value: item!['id'].toString(),
                            child: Text(
                              item!['name_th'].toString(),
                              // style: textContentGrey,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    print('value===>$value');
                    if (value == null) {
                      return 'กรุณาเลือก';
                    }
                  },
                  onChanged: (value)async {
                    setState(() {
                      _subdistrict.text = value.toString();
                      for(var zipcode in get_tambonss!){
                         if(zipcode['id'].toString() == value.toString()){
                           
                            _postcode.text = zipcode['zip_code'].toString();
                             _subdistrict2.text = zipcode['name_th'].toString();
                         }
                      }
                      // _postcode.text = 
                      // get_zipcode(_subdistrict.text);
                    });
                  },
                  onSaved: (value) {
                    // selectedValue = value.toString();
                  },
                ),
                                                        
                                                    
                                ),                          
                // TextField0(context,'จังหวัด',() {
                //         setState(() {});},),

                // TextField0(context,'เขต',() {
                //         setState(() {});},_district),
                //           TextField0(context,'แขวง',() {
                //         setState(() {});},_subdistrict),
                          TextField0(context,'ถนน',() {
                        setState(() {});},_streetAddress),
                        TextField0(context,'รหัสไปรษณีย์',() {
                        setState(() {});},_postcode),
                        // TextField0(context,'รายละเอียดที่อยู่',() {
                        // setState(() {});},_address_details),                        
                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: <Widget>[
                                        FlutterSwitch(
                                          width: 55.0,
                                          height: 30.0,
                                          valueFontSize: 12.0,
                                          toggleSize: 18.0,
                                          value: _switchVal,
                                          onToggle: (val) {
                                            setState(() {
                                              _switchVal = val;
                                            });
                                          },
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              if (_switchVal == true) ...[
                                                Text(
                                                  'ตั้งค่าเริ่มต้น',
                                                  textScaleFactor: 1.0,
                                                  // style: fontsFS16W,
                                                ),
                                              ] else ...[
                                                Text("ไม่ตั้งค่าเริ่มต้น",
                                                    textScaleFactor: 1.0,
                                                    // style: fontsFS16W
                                                    )
                                              ]
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                  GestureDetector(onTap: () {
              
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
            ],)
          ),
        ),
      ),
    );
  }

 Future createWo() async {
    try {
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();

       String access_token = preferences.getString('access_token').toString();
      var url = Uri.parse('${MyConstant().domain}/add_address');
      EasyLoading.show(status: 'กำลังเพิ่มข้อมูล');

      
      var response = await http.MultipartRequest('POST', url);
      response.headers['Authorization'] = access_token;
      response.fields['id_user'] =  user_id;
      response.fields['name'] =  _name.text;
        response.fields['phone'] =  _phone.text;
        response.fields['address'] =  _address.text;
         response.fields['province'] =  _province2.text;
          response.fields['district'] =  _district2.text;
           response.fields['subdistrict'] =  _subdistrict2.text;
            response.fields['streetAddress'] =  _streetAddress.text;
            response.fields['postcode'] =  _postcode.text;
           response.fields['status'] = _switchVal == true ?'active' : 'inactive';
      
        
      
     
       
    
     
      

      var res = await response.send();
      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('บันทึกข้อมูลสำเร็จ').then((value)async {
            // routToService();
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


bool _switchVal = false;
   Container TextField0(
      BuildContext context, var name,  Function()? onTap,TextEditingController controller) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            //  color: Color(0xff979696),
                          ),
                          margin: EdgeInsets.only(top: 0), //ขนาดแยกบน
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
                                // borderRadius:
                                //     BorderRadius.circular(20), //ขนาดมุม
                                borderSide:
                                    BorderSide(color: Colors.white), //สี
                              ),
                              focusedBorder: OutlineInputBorder(
                                //กรอบสี่เหลี่ยม
                                // borderRadius:
                                //     BorderRadius.circular(20), //ขนาดมุม
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          )),
                ),
               
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 5),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),
        ],
      ),
    );
  }

}
