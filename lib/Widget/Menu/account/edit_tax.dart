import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../my_constant.dart';


class EDIT_tax extends StatefulWidget {
  Map<String,dynamic>? date;
   EDIT_tax({super.key,this.date});

  @override
  State<EDIT_tax> createState() => _EDIT_taxState();
}

class _EDIT_taxState extends State<EDIT_tax> {
  bool loading = true;
  late  List<dynamic>? citys = [];

    String? extractProviderNumber(String data) {
    String groupPrefix = "จังหวัด";
    String? groupNumber;

    // ตรวจสอบว่าข้อมูลมีคำว่า "หมู่ที่ " หน้าท้ายหรือไม่
    if (data.startsWith(groupPrefix)) {
      String provincePart = data.substring(groupPrefix.length);
      // แปลงข้อความเป็นตัวเลข
      groupNumber = provincePart;
    } else {
      groupNumber = data.toString();
    }

    return groupNumber.toString();
  }

  String? extractDisNumber(String data) {
    String groupPrefix = "อำเภอ";
    String groupPrefix2 = "เขต";
    String? groupNumber;

    // ตรวจสอบว่าข้อมูลมีคำว่า "หมู่ที่ " หน้าท้ายหรือไม่
    if (data.startsWith(groupPrefix)) {
      String disPart = data.substring(groupPrefix.length);
      // แปลงข้อความเป็นตัวเลข
      groupNumber = disPart;
    } else if (data.startsWith(groupPrefix2)) {
      String disPart = data.substring(groupPrefix2.length);
      // แปลงข้อความเป็นตัวเลข
      groupNumber = disPart;
    } else {
      groupNumber = data.toString();
    }

    return groupNumber.toString();
  }

  String? extractSubDisNumber(String data) {
    String groupPrefix = "ตำบล";
    String groupPrefix2 = "แขวง";
    String? groupNumber;

    // ตรวจสอบว่าข้อมูลมีคำว่า "หมู่ที่ " หน้าท้ายหรือไม่
    if (data.startsWith(groupPrefix)) {
      String disPart = data.substring(groupPrefix.length);
      // แปลงข้อความเป็นตัวเลข
      groupNumber = disPart;
    } else if (data.startsWith(groupPrefix2)) {
      String disPart = data.substring(groupPrefix2.length);
      // แปลงข้อความเป็นตัวเลข
      groupNumber = disPart;
    } else {
      groupNumber = data.toString();
    }

    return groupNumber.toString();
  }


  Future<void> city() async {
    try {
      setState(() {
        loading = true;
      
      });

      var uri = Uri.parse('${MyConstant().domain}/city');
       var ressum = await http.get(uri,
      
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         print(lnformation);
         citys  =lnformation['data']['data'];
         citys!.insert(0, {
         "id": 'กรุณาเลือกจังหวัด',
        "code": "",
        "name_th": "กรุณาเลือกจังหวัด",
        "name_en": "กรุณาเลือกจังหวัด",
        "province_id": null,
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },);
         if(widget.date!['province_tax'].toString() == 'null'){
            
                _province.text = citys![0]['id'];
                get_amupurs(_province.text);
              //  get_amupurs(_province.text);
         }else{
           for(var i = 0; i<citys!.length;i++){
             if(extractProviderNumber(widget.date!['province_tax'].toString()) == extractProviderNumber(citys![i]['name_th'].toString())){
               _province.text = citys![i]['id'].toString();
               get_amupurs(_province.text);
             }
           }   
         }
        // print(show_deliverys);
                 
 
       
         
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
       
     print('5555555 $city');

      });

      var uri = Uri.parse('${MyConstant().domain}/get_amupurs');
       var ressum = await http.post(uri,
       body: {
         'id_province':city.toString()
       }
      
            );
          //  print('5555555 ${ressum.statusCode}'); 
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
       if(widget.date!['district_tax'].toString() == 'null'){
            
                _district.text = get_amupurss![0]['id'];
                get_tambons(_district.text);
         }else{
           for(var i = 0; i<get_amupurss!.length;i++){
              
             if(extractDisNumber(widget.date!['district_tax'].toString()) == extractDisNumber(get_amupurss![i]['name_th'].toString())){
               _district.text = get_amupurss![i]['id'].toString();
               
                get_tambons(_district.text);
    
             }
           }   
         }
        
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
     print('5555555 $ampurs');

      var uri = Uri.parse('${MyConstant().domain}/get_tambons');
       var ressum = await http.post(uri,
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

       if(widget.date!['subdistrict_tax'].toString() == 'null'){
            
                _subdistrict.text = get_tambonss![0]['id'].toString();
                _postcode.text = get_tambonss![0]['zip_code'].toString();
                loading = false;
              
         }else{
           for(var i = 0; i<get_tambonss!.length;i++){
             if(extractSubDisNumber(widget.date!['subdistrict_tax'].toString()) == extractSubDisNumber(get_tambonss![i]['name_th'].toString())){
               _subdistrict.text = get_tambonss![i]['id'].toString();
               _postcode.text = get_tambonss![i]['zip_code'].toString();
               loading = false;
             }
           }   
         }
           
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






  



  Future<void> get_amupurs2(var city) async {
    try {
        setState(() {
       
      });

      var uri = Uri.parse('${MyConstant().domain}/get_amupurs');
       var ressum = await http.post(uri,
       body: {
         'id_province':city.toString()
       }
      
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



  Future<void> get_tambons2(var ampurs) async {
    try {
   

      var uri = Uri.parse('${MyConstant().domain}/get_tambons');
       var ressum = await http.post(uri,
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
    _name.text = widget.date!['name_tax'].toString() == 'null' ?'' :widget.date!['name_tax'].toString();
     _phone.text = widget.date!['number_tax'].toString() == 'null' ?'' :widget.date!['number_tax'].toString();
      _address.text = widget.date!['address_tax'].toString() == 'null' ?'' :widget.date!['address_tax'].toString();
       _streetAddress.text = widget.date!['streetAddress_tax'].toString() == 'null' ?'' :widget.date!['streetAddress_tax'].toString();
       _postcode.text = widget.date!['postcode_tax'].toString() == 'null' ?'' :widget.date!['postcode_tax'].toString();
        _province2.text = widget.date!['province_tax'].toString() == 'null' ?'' :widget.date!['province_tax'].toString();
        _district2.text = widget.date!['district_tax'].toString() == 'null' ?'' :widget.date!['district_tax'].toString();
        _subdistrict2.text = widget.date!['subdistrict_tax'].toString() == 'null' ?'' :widget.date!['subdistrict_tax'].toString();
      if(widget.date!['tax_status'].toString() == 'inactive'){
        _switchVal = false;
      }else{
        _switchVal = true;
      }
         if(widget.date!['type_tax'].toString() == 'บุคคลธรรมดา'){
        _switchVal0 = false;
      }else{
        _switchVal0 = true;
      }
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
                              'ใบกำกับภาษีของฉัน',
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
                                          value: _switchVal0,
                                          onToggle: (val) {
                                            setState(() {
                                              _switchVal0 = val;
                                            });
                                          },
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              if (_switchVal0 == true) ...[
                                                Text(
                                                  'นิติบุคคล',
                                                  textScaleFactor: 1.0,
                                                  // style: fontsFS16W,
                                                ),
                                              ] else ...[
                                                Text("บุคคลธรรมดา",
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
                        TextField0(context,'ชื่อ-นามสกุล ของผู้เสียภาษีอากรของผู้ซื้อ',() {
                        setState(() {});},_name),

  TextField0(context,'เลขประจำตัวผู้เสียภาษีอากรของผู้ซื้อ',() {
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
                  value: _province.text,
                  items: citys!
                      .map((item) => DropdownMenuItem<String>(
                            value: item!['id'].toString(),
                            child: Text(
                              extractProviderNumber(item!['name_th'].toString())!,
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
                          
                            _province2.text = extractProviderNumber(province2['name_th'].toString())!;
                         }
                      }
                      get_amupurs2(_province.text);
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
                              extractDisNumber(item!['name_th'].toString())!,
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
                          
                            _district2.text = extractDisNumber(district2['name_th'].toString())!;
                         }
                      }
                      get_tambons2(_district.text);
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
                              extractSubDisNumber(item!['name_th'].toString())!,
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
                             _subdistrict2.text = extractSubDisNumber(zipcode['name_th'].toString())!;
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
              
            createWo() ;

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
                   
                      Text('ยืนยันแก้ไข', textScaleFactor: 1.0,
                              style: TextStyle(
                                
                        
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                    ],
                  ),
                ),
              ),
            )),
                  GestureDetector(onTap: () {
              
             createWoDet();

            }, child: Container(
                decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 0, 0),
   borderRadius: BorderRadius.circular(15),
  ),
              margin: EdgeInsets.only(right: 5,left: 5,top: 10),
              //  height: 60,
              //  width: 100,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   
                      Text('ลบ', textScaleFactor: 1.0,
                              style: TextStyle(
                                
                        
                        fontSize: 14,
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


   Future createWoDet() async {
    try {
       SharedPreferences preferences = await SharedPreferences.getInstance();
     
      var url = Uri.parse('${MyConstant().domain}/delete_tax');
      EasyLoading.show(status: 'กำลังเพิ่มข้อมูล');

      
      var response = await http.MultipartRequest('POST', url);
      response.fields['id'] =  widget.date!['id'].toString();
      
      
        
      
     
       
    
     
      

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

 Future createWo() async {
    try {
       SharedPreferences preferences = await SharedPreferences.getInstance();
     
      var url = Uri.parse('${MyConstant().domain}/edit_tax');
      EasyLoading.show(status: 'กำลังเพิ่มข้อมูล');

      
      var response = await http.MultipartRequest('POST', url);
      response.fields['id'] =  widget.date!['id'].toString();
      response.fields['name_tax'] =  _name.text;
        response.fields['number_tax'] =  _phone.text;
        response.fields['address_tax'] =  _address.text;
         response.fields['province_tax'] =  _province2.text;
          response.fields['district_tax'] =  _district2.text;
           response.fields['subdistrict_tax'] =  _subdistrict2.text;
            response.fields['streetAddress_tax'] =  _streetAddress.text;
            response.fields['postcode_tax'] =  _postcode.text;
           response.fields['tax_status'] = _switchVal == true ?'active' : 'inactive';
      response.fields['type_tax'] = _switchVal0 == true ?'นิติบุคคล' : 'บุคคลธรรมดา';
        
      
     
       
    
     
      

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
bool _switchVal0 = false;
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
