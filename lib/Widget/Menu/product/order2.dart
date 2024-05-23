import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../my_constant.dart';
import '../account/order_add.dart';




class Order_list extends StatefulWidget {
   Map<String,dynamic>? data;
   Order_list({super.key,this.data});

  @override
  State<Order_list> createState() => _Order_listState();
}

class _Order_listState extends State<Order_list> {
  
  
  String getDelivery(String idDelivery) {
    // แปลงค่า idDelivery เป็น List ของ String
    List<String> ids = idDelivery.split(',');

    // หาก List มีมากกว่า 1 ค่า เลือกค่าที่สอง
    if (ids.length > 1) {
      return ids[1];
    } else {
      // หากมีเพียงค่าเดียว คืนค่านั้น
      return ids[0];
    }
  }
  late Map<String,dynamic>? data = widget.data;
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            // color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                
                children: [
                 Container(
                   
                   child: Row(
                            children: [
                              Container(
                                child: Text(
                                  'รายละเอียดคำสั่งซื้อ',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                 ),
        Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Line 11.png',
                // height: 2,
              ),
            ),
           '${data!['status']}' == 'ยกเลิก'  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       decoration: BoxDecoration(
                                                              // border: Border.all(color: Color(0xffBD2325), width: 1),
                                                              borderRadius: BorderRadius.circular(10),
                                                             color: Color(0xffEFEFEF),
                                                            ),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                               
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Container(
                                                           child: Text('คำสั่งซื้อถูกยกเลิกแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
                                                         ),
                                     Container(
                                                           child: Text('คุณยกเลิกคำสั่งซื้อนี้สำเร็จแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                                         ),
                                ]),
                              ),
                            ),
                             Container(
                                                   
                                                     child: Image.asset('assets/images/icons8-cancel-100 1.png',
                                                     height: 40,),
                                                   ),
                          ],
                        ),
                      ),
                    ),
                  )
           :   '${data!['status']}' == 'คำขอยกเลิก' ?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       decoration: BoxDecoration(
                                                              // border: Border.all(color: Color(0xffBD2325), width: 1),
                                                              borderRadius: BorderRadius.circular(10),
                                                             color: Color(0xffEFEFEF),
                                                            ),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                               
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Container(
                                                           child: Text('ส่งคำขอยกเลิกแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
                                                         ),
                                     Container(
                                                           child: Text('คุณส่งคำขอยกเลิกคำสั่งซื้อนี้สำเร็จแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                                         ),
                                ]),
                              ),
                            ),
                             Container(
                                                   
                                                     child: Image.asset('assets/images/icons8-cancel-100 1.png',
                                                     height: 40,),
                                                   ),
                          ],
                        ),
                      ),
                    ),
                  )
           :Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       decoration: BoxDecoration(
                                                              // border: Border.all(color: Color(0xffBD2325), width: 1),
                                                              borderRadius: BorderRadius.circular(10),
                                                             color: Color(0xffEFEFEF),
                                                            ),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                               
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Container(
                                                           child: Text('${data!['status']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
                                                         ),
                                     Container(
                                                           child: Text('ชำระเงินยอดผ่าน ${data!['bank']} ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                                         ),
                                ]),
                              ),
                            ),
                             Container(
                                                   
                                                     child: Image.asset('assets/images/icons8-open-box-100 1.png',
                                                     height: 40,),
                                                   ),
                          ],
                        ),
                      ),
                    ),
                  ),
                    Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Line 11.png',
                // height: 2,
              ),
            ),
             data!['status'].toString() == 'ที่ต้องได้รับ'||data!['status'].toString() == 'สำเร็จ'? Container()
                          :   Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: 
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                                     margin: EdgeInsets.only(left: 0),
                                                     child: Image.asset('assets/images/Group 9.png',
                                                     height: 25,),
                                                   ),
                           '${data!['status']}' == 'ยกเลิก'  ?Container(
                                margin: EdgeInsets.only(left: 5),
                                                         child: Text('ยกเลิกสินค้าแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),),
                                                       )
                                                       
                           :     '${data!['status']}' == 'คำขอยกเลิก'  ?Container(
                                margin: EdgeInsets.only(left: 5),
                                                         child: Text('ส่งคำขอยกเลิกแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),),
                                                       ):Container(
                                margin: EdgeInsets.only(left: 5),
                                                         child: getDelivery('${data!['id_delivery']}') == '2' ? Text('ไปรับในวันที่ ${DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse('${data!['date_preorder']} ${data!['time_preorder']}'))}  ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),)
                                                         : Text('จัดส่งภายใน3วัน หลังจากสั่งซื้อ ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),),
                                                       ),
                            ],
                          ),
                         
                     
                    ),
                  ),
               data!['status'].toString() == 'ที่ต้องได้รับ'||data!['status'].toString() == 'สำเร็จ'? Container()
                          :   Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Line 11.png',
                // height: 2,
              ),
            ),
                 data!['status'].toString() == 'ที่ต้องได้รับ'||data!['status'].toString() == 'สำเร็จ'? Container()
                          :    Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: 
                          Row(
                           
                            children: [
                                Container(
                                                     margin: EdgeInsets.only(left: 0),
                                                     child: Image.asset('assets/images/Group 8.png',
                                                     height: 30,),
                                                   ),
                           '${data!['id_delivery']}' == '2'? Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                                               child: Text('ไปรับที่หน้าร้าน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w500),),
                                                             ),
                                   
                                       GestureDetector(
                                         onTap: () {
                                           _opengrabt();
                                         },
                                         child: Container(
                                                       margin: EdgeInsets.only(left: 0),
                                                       child: ClipRRect(
                                                         borderRadius: BorderRadius.circular(50),
                                                         child: Image.asset('assets/images/grab.png',
                                                         height: 30,),
                                                       ),
                                                     ),
                                       ),                                               
                                  ],
                                ),
                              )
                           :  Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                                               child: Text('ที่อยู่จัดส่ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w500),),
                                                             ),
                                     Container(
                                      margin: EdgeInsets.only(left: 5),
                                                               child: Text('${data!['address']} ${data!['streetAddress']} ${data!['subdistrict']} ${data!['district']}  ${data!['province']} ${data!['postcode']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 14,fontWeight: FontWeight.w400),),
                                                             ), 
                                                                                    
                                  ],
                                ),
                              ),

                            '${data!['status']}' == 'ที่ต้องชำระ'||'${data!['status']}' == 'ที่ต้องจัดส่ง'? '${data!['id_delivery']}' == '2' ? Container()
                            : GestureDetector(
                                                                                              onTap: ()async {
                                                                                              var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                                                                   builder: (_) =>order_add(order_no:data!['order_no']) ),);
                                                                           if (navigationResult == null ) {
                                                                                show_historystatus();
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
                                                                                            ):Container(),   
                            ],
                          ),
                         
                     
                    ),
                  ),
               data!['status'].toString() == 'ที่ต้องได้รับ'||data!['status'].toString() == 'สำเร็จ'? Container()
                          :   Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Line 11.png',
                // height: 2,
              ),
            ),
           
               
              
             Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 20,bottom: 20),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: ListView.builder(
                                             physics: BouncingScrollPhysics(),
                                            //  scrollDirection: Axis.horizontal,
                                                                    shrinkWrap: true,
                                                                    itemCount: data!['product_amounts'].length,
                                                                                   itemBuilder: (context, index)  {
                                                            return GestureDetector(
                                                              
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      // color: Colors.amber,
                                                                     child: Row(
                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                         children: [
                                                                                                          Container(
                                                                                                             margin: EdgeInsets.only(left: 10),
                                                                                                             child:data!['product_amounts'][index]['path_img'] != null?Image.network(
                                                                                    '${MyConstant().domain2}/${data!['product_amounts'][index]['path_img']}',
                                                                                    height: 70,
                                                                              ): Container(
                                                                                 height: 70,
                                                                                 width: 70,
                                                                                child: Text('')),
                                                                                                           ),
                                                                                                         Expanded(
                                                                                                           child: Container(
                                                                                                            //  color: Colors.red,
                                                                                                               margin: EdgeInsets.only(left: 10),
                                                                                                               child: Column(
                                                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                 children: [
                                                                                                                  Container(
                                                                                                           child: Text('${data!['product_amounts'][index]['type']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                                                                         ),
                                                                                                                  Container(
                                                                                                           child: Text('ตัวเลือก : ${data!['product_amounts'][index]['name_product']},${data!['product_amounts'][index]['name_size']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffAFAFAF), fontSize: 12,fontWeight: FontWeight.w500),),
                                                                                                         ),
                                                                                                                  Container(
                                                                                                           child: Text('${data!['product_amounts'][index]['rate_product']} ฿ x${data!['product_amounts'][index]['amount']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 14,fontWeight: FontWeight.w600),),
                                                                                                         ),
                                                                                                               ],)
                                                                                                             ),
                                                                                                         ),
                                                                                                         ],
                                                                                                       ),
                                                                    ),
                                                                     data!['status'].toString() != 'ที่ต้องได้รับ'&&data!['status'].toString() != 'สำเร็จ'? Container()
                          :   Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: 
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                                     margin: EdgeInsets.only(left: 0),
                                                     child: Image.asset('assets/images/Group 9.png',
                                                     height: 25,),
                                                   ),
                           '${data!['product_amounts'][index]['detail_status']}' == 'ยกเลิก'  ?Container(
                                margin: EdgeInsets.only(left: 5),
                                                         child: Text('ยกเลิกสินค้าแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),),
                                                       )
                                                       
                           :     '${data!['product_amounts'][index]['detail_status']}' == 'คำขอยกเลิก'  ?Container(
                                margin: EdgeInsets.only(left: 5),
                                                         child: Text('ส่งคำขอยกเลิกแล้ว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),),
                                                       ):Container(
                                margin: EdgeInsets.only(left: 5),
                                                         child: '${data!['product_amounts'][index]['delivery']['id_delivery']}' == '2'?Text('จะมารับใน วันที่ ${DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse('${data!['date_preorder']} ${data!['time_preorder']}'))} น.',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),)
                                                         :'${data!['product_amounts'][index]['delivery']['id_delivery']}' == '1'?Text('${data!['product_amounts'][index]['delivery']['detail_delivery']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),)
                                                         :Text('จัดส่งภายใน${data!['lenght_preorder']}วัน หลังจากสั่งซื้อ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w400),),
                                                       ),
                            ],
                          ),
                         
                     
                    ),
                  ),
               data!['status'].toString() != 'ที่ต้องได้รับ'&&data!['status'].toString() != 'สำเร็จ'? Container()
                          :   Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Line 11.png',
                // height: 2,
              ),
            ),
                 data!['status'].toString() != 'ที่ต้องได้รับ'&&data!['status'].toString() != 'สำเร็จ'? Container()
                          :    Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: 
                          Row(
                           
                            children: [
                                Container(
                                                     margin: EdgeInsets.only(left: 0),
                                                     child: Image.asset('assets/images/Group 8.png',
                                                     height: 30,),
                                                   ),
                           '${data!['product_amounts'][index]['delivery']['id_delivery']}' == '2'? Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                                               child: Text('ไปรับที่หน้าร้าน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w500),),
                                                             ),
                                   
                                       GestureDetector(
                                         onTap: () {
                                           _opengrabt();
                                         },
                                         child: Container(
                                                       margin: EdgeInsets.only(left: 0),
                                                       child: ClipRRect(
                                                         borderRadius: BorderRadius.circular(50),
                                                         child: Image.asset('assets/images/grab.png',
                                                         height: 30,),
                                                       ),
                                                     ),
                                       ),                                               
                                  ],
                                ),
                              )
                           :  Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                                               child: Text('ที่อยู่จัดส่ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 14,fontWeight: FontWeight.w500),),
                                                             ),
                                     Container(
                                      margin: EdgeInsets.only(left: 5),
                                                               child: Text('${data!['address']} ${data!['streetAddress']} ${data!['subdistrict']} ${data!['district']}  ${data!['province']} ${data!['postcode']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 14,fontWeight: FontWeight.w400),),
                                                             ), 
                                                                                    
                                  ],
                                ),
                              ),
  
                            ],
                          ),
                         
                     
                    ),
                  ),
               data!['status'].toString() != 'ที่ต้องได้รับ'? Container()
                          :   Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Line 11.png',
                // height: 2,
              ),
            ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        ),
                                                      ),
                                                   
                                                    ],
                                                  ),
                                                ),
                                                
                      '${data!['status']}' == 'ที่ต้องชำระ'||'${data!['status']}' == 'ที่ต้องจัดส่ง'?  GestureDetector(
                                                                                              onTap: () {
                                                                                                
                                                                                              cancle_order();
                                                                                              },
                                                                                              child: Container(
                                                                                                width: 80,
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
                                                                                                                                                    'ยกเลิก',
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
                                                                                            ):Container(),                          
                                               
                Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Line 11.png',
                // height: 2,
              ),
            ),
      
            Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: 
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                                     margin: EdgeInsets.only(left: 0),
                                                     child: Image.asset('assets/images/Rectangle 156.png',
                                                     height: 25,),
                                                   ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                                         child: Text('ช่องทางการชำระเงิน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                       ),
                            ],
                          ),
                         
                     
                    ),
                  ),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       decoration: BoxDecoration(
                                                              // border: Border.all(color: Color(0xffBD2325), width: 1),
                                                              borderRadius: BorderRadius.circular(10),
                                                             color: Color(0xffEFEFEF),
                                                            ),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                             
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Container(
                                                         child: Text('${data!['bank']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
                                                       ),
                                   Container(
                                                         child: Text('${data!['bank']} ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                                       ),
                              ]),
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                  ),  

                                                 
            '${data!['type_tax']}' == 'null' ? Container()
            : Container(
                  child: Column(
                    children: [
                      Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Image.asset(
                      'assets/images/Line 11.png',
                      // height: 2,
                              ),
                            ),
                      
                            Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: 
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Container(
                                                           margin: EdgeInsets.only(left: 0),
                                                           child: Image.asset('assets/images/Rectangle 156.png',
                                                           height: 25,),
                                                         ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                                               child: Text('ใบกำกับภาษี',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                             ),
                                  ],
                                ),
                               
                           
                          ),
                        ),
                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                     decoration: BoxDecoration(
                                                            // border: Border.all(color: Color(0xffBD2325), width: 1),
                                                            borderRadius: BorderRadius.circular(10),
                                                           color: Color(0xffEFEFEF),
                                                          ),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                             
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                                         child: Text('${data!['type_tax']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                       ),
                                 Container(
                                                         child: Text('${data!['name_tax']} |  ${data!['number_tax']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                       ),
                                   Container(
                                                         child: Text('${data!['address_tax']}  ${data!['streetAddress_tax']}  ${data!['subdistrict_tax']}  ${data!['district_tax']}  ${data!['province_tax']} ${data!['postcode_tax']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                       ),
                              ]),
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                  ),
                ),
                    ],
                  ),
                ),    
             Container(
                // decoration: BoxDecoration(
                //               color: Color(0xffBD616E).withOpacity(0.31),
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                   Container(
                                     
                                    //  margin: EdgeInsets.only(bottom: 15),
                                     child: 
                                         Container(
                                           child: Text('หมายเลขคำสั่งซื้อ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w400),),
                                         ),
                                       
                                   ),
                                   Container(
                                       child: Row(
                                         children: [
                                        
                                           
                                          Container(
                                           child: Text('${data!['order_no']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w400),),
                                         ),
                                        Container(
                                           margin: EdgeInsets.only(left: 10),
                                           child: Image.asset('assets/images/icons8-link-100 1.png',
                                           height: 18,),
                                         ),
                                         ],
                                       ),
                                     ),
                                   
                                 ],),
                               ),
                             ),

                             Container(
                // decoration: BoxDecoration(
                //               color: Color(0xffBD616E).withOpacity(0.31),
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                               child: Padding(
                                 padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                   Container(
                                     
                                    //  margin: EdgeInsets.only(bottom: 15),
                                     child: 
                                         Container(
                                           child: Text('สั่งซื้อวันที่',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 14,fontWeight: FontWeight.w400),),
                                         ),
                                       
                                   ),
                                  Container(
                                           child: Text('${DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.parse('${data!['history_created_at']}'))}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffAFAFAF), fontSize: 14,fontWeight: FontWeight.w400),),
                                         ),
                                      
                                     
                                   
                                 ],),
                               ),
                             ),

                              Container(
                // decoration: BoxDecoration(
                //               color: Color(0xffBD616E).withOpacity(0.31),
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                               child: Padding(
                                 padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                   Container(
                                     
                                    //  margin: EdgeInsets.only(bottom: 15),
                                     child: 
                                         Container(
                                           child: Text('ช่องทางการชำระเงิน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 14,fontWeight: FontWeight.w400),),
                                         ),
                                       
                                   ),
                                    Container(
                                           child: Text('ชำระผ่าน ${data!['bank']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffAFAFAF), fontSize: 14,fontWeight: FontWeight.w400),),
                                         ),
                                        
                                       
                                     
                                   
                                 ],),
                               ),
                             ),
                           
                                              ],)
                                            ),
                                         
                
                   
              ],)
            ),
          ),
      ),
      
    );
  }



  Future cancle_order() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
             var url = Uri.parse('${MyConstant().domain}/cancle_order');
      EasyLoading.show(status: 'กำลังยกเลิก');
      
     
      var response = await http.MultipartRequest('POST', url);
      response.headers['Authorization'] = access_token;
      response.fields['order_no'] =  widget.data!['order_no'].toString();
     
            
 
      var res = await response.send();
      var response0 = await http.Response.fromStream(res);

      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
          var  lnformation2  = jsonDecode(response0.body)['message'];
        EasyLoading.showSuccess('$lnformation2').then((value)async {
         
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


    void _opengrabt() async {
    var url = 'https://grab.onelink.me/2695613898?pid=website&c=TH_homepage_download&is_retargeting=true&af_dp=grab%3A%2F%2Fopen%3FscreenType%3DMAIN&af_force_deeplink=true&af_sub5=website&af_ad=&af_web_dp=https%3A%2F%2Fwww.grab.com%2Fth%2Fdownload%2F'; // แทน YOUR_LINE_ID ด้วย ID ของ LINE ของคุณ
    if (await canLaunch(url)) {
      print(url);
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  
   
   Future<void> show_historystatus() async {
  try {
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
    String user_id = preferences.getString('id').toString();
    
    setState(() {
    
      
    });
    
    var uri = Uri.parse('${MyConstant().domain}/status');
    var ressum = await http.post(uri,
        headers: {
       "Authorization":access_token
      },
        body: {
          "id_order": data!['id'].toString(),
        });
    if (ressum.statusCode == 200) {
      var lnformation = jsonDecode(ressum.body);
      setState(() {
        data = lnformation['data'];
       
           

        
      // for (var data in lnformation['data']) {
      //   mergedData.addAll(data[0]);
      // }
          //  List<dynamic> combinedData = lnformation['data'].expand((element) => element).toList();

    
      // product_users == product_userss;
  
    
  
      });
    } else {
      setState(() {
       
          
      });
      // loading = false;
      // var lnformation = jsonDecode(ressum.body);
      // print('product_users=== $lnformation');
    }
  } catch (e) {
    print('e ===>2 ${e.toString()} ');
  }
}

}
