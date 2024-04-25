import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../my_constant.dart';
import 'add_address.dart';
import 'add_tax.dart';
import 'edit_address.dart';
import 'edit_tax.dart';


class tax extends StatefulWidget {
  const tax({super.key});

  @override
  State<tax> createState() => _taxState();
}

class _taxState extends State<tax> {
  bool loading = true;
  late  List<dynamic> show_taxs = [];
  Future<void> show_tax() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_tax_address');
       var ressum = await http.post(uri,
       body: {
         'id_user': user_id
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         print(lnformation);
         show_taxs  =lnformation['data']['data'];
      
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show_tax();
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
                                'ใบกำกับภาษี',
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
                ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: show_taxs.length,
                  
                              //   separatorBuilder:  (context, index) {
                  
                              //   return const SizedBox(width: 2,);
                  
                              // },
                  
                              itemBuilder: (context, index) {
                    return InkWell(
                       onTap: () async{
                                 
                               },
                      child: Padding(
                                                         padding: const EdgeInsets.only(top: 10),
                                                         child: Container(
                                                           width: screenW*1,
                                                           color:  show_taxs[index]['status'] == 'active' ? Color(0xffEFEFEF):Color(0xffFFFFFF),
                                                           child: Padding(
                                                             padding: const EdgeInsets.all(20.0),
                                                             child: Expanded(
                                                                   child: Row(
                                                                     children: [
                                                                       Expanded(
                                                                         child: Column(
                                                                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                         children: [
                                                                                                            Container(
                                                                                                                   child: Text(
                                                                                                                     '${show_taxs[index]['type_tax']}',
                                                                                                                     textScaleFactor: 1.0,
                                                                                                                     style: TextStyle(
                                                                                                                         color: Color(0xff1E1E1E),
                                                                                                                         fontSize: 14,
                                                                                                                         fontWeight: FontWeight.w500),
                                                                                                                   ),
                                                                                                                 ),
                                                                                                            Container(
                                                                                                                   child: Text(
                                                                                                                     '${show_taxs[index]['name_tax']} |  ${show_taxs[index]['number_tax']}',
                                                                                                                     textScaleFactor: 1.0,
                                                                                                                     style: TextStyle(
                                                                                                                         color: Color(0xff1E1E1E),
                                                                                                                         fontSize: 14,
                                                                                                                         fontWeight: FontWeight.w500),
                                                                                                                   ),
                                                                                                                 ),
                                                                                                                  Container(
                                                                                                                   child: Text(
                                                                                                                     '${show_taxs[index]['address_tax']}  ${show_taxs[index]['streetAddress_tax']}  ${show_taxs[index]['subdistrict_tax']}  ${show_taxs[index]['district_tax']}  ${show_taxs[index]['province_tax']} ${show_taxs[index]['postcode_tax']}',
                                                                                                                     textScaleFactor: 1.0,
                                                                                                                     style: TextStyle(
                                                                                                                         color: Color(0xff979696),
                                                                                                                         fontSize: 14,
                                                                                                                         fontWeight: FontWeight.w500),
                                                                                                                   ),
                                                                                                                 ),
                                                                                                                 
                                                                                                                 show_taxs[index]['tax_status'] == 'active' ? Container(
                                                                                                                    margin: EdgeInsets.only(top: 5),
                                                                                                                    color: Color(0xffFAAB35),
                                                                                                                   child: Padding(
                                                                                                                     padding: const EdgeInsets.all(8.0),
                                                                                                                     child: Text(
                                                                                                                       'ค่าเริ่มต้น',
                                                                                                                       textScaleFactor: 1.0,
                                                                                                                       style: TextStyle(
                                                                                                                           color: Color(0xffFFFFFF),
                                                                                                                           fontSize: 13,
                                                                                                                           fontWeight: FontWeight.w500),
                                                                                                                     ),
                                                                                                                   ),
                                                                                                                 ):Container(),
                                                                       
                                                                                                         ],
                                                                         ),
                                                                       ),
                                                                        InkWell(
                                                                                              onTap: ()async {
                                                                                               var navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>EDIT_tax(date:show_taxs[index]) ),);
                                 if (navigationResult == null ) {
                                    show_tax();
                                 }
                                                                                              },
                                                                                              child: Container(
                                                                                               width: 60,
                                                                                                margin: EdgeInsets.only(right: 5),
                                                                                                decoration: BoxDecoration(
                                                                                                                                                color: Color.fromARGB(255, 255, 255, 255) ,
                                                                                                                                                border: Border.all(
                                                                                                color: Color(0xffBD2325) ,
                                                                                                width: 1),
                                                                                                                                                borderRadius:
                                                                                                                                                    BorderRadius.circular(50),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                                                                padding: const EdgeInsets.only(right: 8,left: 8,top: 8,bottom: 8),
                                                                                                                                                child: Center(
                                                                                                                                                  child: Text(
                                                                                                                                                    'แก้ไข',
                                                                                                                                                    textScaleFactor: 1.0,
                                                                                                                                                    style: TextStyle(
                                                                                                                                                      // fontFamily: 'IBM',
                                                                                                                                                      fontSize: 12,
                                                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                                                      color: Color(0xffBD2325) ,
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                     ],
                                                                   ),
                                                                 ),
                                                                 
                                                            
                                                           ),
                                                         ),
                                                       ),
                    );
                  }
                ),
                  TextButton(onPressed: ()async {
              
                var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>APP_tax() ),);
                                 if (navigationResult == null ) {
                                    show_tax();
                                 }

            }, child: Container(
                decoration: BoxDecoration(
    color: Color(0xff000000),
   borderRadius: BorderRadius.circular(15),
  ),
              margin: EdgeInsets.only(right: 5,left: 5),
              //  height: 60,
              //  width: 100,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
            margin: EdgeInsets.only(right: 5),
            child: Image.asset(
              'assets/images/icons8-add-100 1.png',
              height: 18,
            ),
          ), 
                      Text('เพิ่มใบกำกับภาษีใหม่', textScaleFactor: 1.0,
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



   Container Line(var name,Function()? onTap) {
    return Container(
                      margin: EdgeInsets.only(top: 10),
                       child: InkWell(
                         onTap: onTap,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                               
                                     Container(
                                       child: Text('$name',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 12,fontWeight: FontWeight.w400),),
                                     ),
                                       Container(
                                     margin: EdgeInsets.only(left: 10),
                                     child: Image.asset('assets/images/Rectangle 96.png',
                                     height: 16,),
                                   ),
                                   ],
                                 
                               
                              
                             ),
                               Container(
                                   
                                       child: Image.asset('assets/images/Line 5.png',
                                       height: 18,),),

                                          
                           ],
                         ),
                       ),
                     );
  }

}
