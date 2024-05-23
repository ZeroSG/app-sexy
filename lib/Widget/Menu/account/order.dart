import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import '../product/CartOrder2.dart';
import '../product/order2.dart';
import '../product/pay.dart';
import 'status.dart';
import 'package:http/http.dart' as http;



class Order extends StatefulWidget {
 Map<String,dynamic>? status;
  
   Order({super.key,this.status});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  
    bool loading = true;
late  List<dynamic> show_historys = [];
  Future<void> show_history() async {
  try {
    setState(() {
      loading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
    String user_id = preferences.getString('id').toString();
    var uri = Uri.parse('${MyConstant().domain}/show_history');
    var ressum = await http.post(uri,
        headers: {
       "Authorization":access_token
      },
        body: {
          "id_user": user_id.toString(),
        });
    if (ressum.statusCode == 200) {
      var lnformation = jsonDecode(ressum.body);
      setState(() {
        show_historys = lnformation['data'];
         imgList = [
    {
       'id': 1,
      'nameTH':'ที่ต้องชำระ',
       'nameEN':'Awaiting payment',
       'NO':0,
    },
    {
       'id': 2,
      'nameTH':'ที่ต้องจัดส่ง',
       'nameEN':'Awaiting delivery',
       'NO':0,
    },
    {
       'id': 3,
      'nameTH':'ที่ต้องได้รับ',
       'nameEN':'Awaiting received',
       'NO':0,
    },
    {
       'id': 4,
      'nameTH':'สำเร็จ',
       'nameEN':'Success',
       'NO':0,
    },{
       'id': 5,
      'nameTH':'ยกเลิก',
       'nameEN':'Cancel',
       'NO':0,
    },{
       'id': 6,
      'nameTH':'คำขอยกเลิก',
       'nameEN':'Cancel request',
       'NO':0,
    },{
       'id': 7,
      'nameTH':'พรีออเดอร์',
       'nameEN':'Pre-order',
       'NO':0,
    }
 
  
];
        for(int i = 0;i<imgList.length;i++){
        
        for(int f = 0;f<show_historys.length;f++){
             if(imgList[i]['nameTH'].toString() == show_historys[f]['status'].toString()){
                imgList[i]['NO'] += 1;  
             } 
        }
        }
        print(imgList);
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
show_history();
  }
  late  List<dynamic> imgList = [
    {
       'id': 1,
      'nameTH':'ที่ต้องชำระ',
       'nameEN':'Awaiting payment',
       'NO':0,
    },
    {
       'id': 2,
      'nameTH':'ที่ต้องจัดส่ง',
       'nameEN':'Awaiting delivery',
       'NO':0,
    },
    {
       'id': 3,
      'nameTH':'ที่ต้องได้รับ',
       'nameEN':'Awaiting received',
       'NO':0,
    },
    {
       'id': 4,
      'nameTH':'สำเร็จ',
       'nameEN':'Success',
       'NO':0,
    },{
       'id': 5,
      'nameTH':'ยกเลิก',
       'nameEN':'Cancel',
       'NO':0,
    },{
       'id': 6,
      'nameTH':'คำขอยกเลิก',
       'nameEN':'Cancel request',
       'NO':0,
    },{
       'id': 7,
      'nameTH':'พรีออเดอร์',
       'nameEN':'Pre-order',
       'NO':0,
    }
 
  
];
//  late int? Os = widget.I;
 late Map<String,dynamic> status = widget.status!;
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
      body:  loading ? 
                        Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator())): Container(
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
                                'คำสั่งซื้อของฉัน',
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
         
             Container(
               height: 49,
                child: ListView.builder(
                                           physics: BouncingScrollPhysics(),
                                           scrollDirection: Axis.horizontal,
                                                                  shrinkWrap: true,
                                                                  itemCount: imgList.length,
                                         itemBuilder: (context, index)  {
                                          return  InkWell(
                                 
                                    onTap: () {
                                      setState(() {
                                        status = imgList[index];
                                      });
                                    },
                                            child: Container(
                                                                        child: Column(
                                                                          children: [
                                                                            Stack(
                                                                              alignment: Alignment.topRight,
                                                                              children: [
                                                                                Padding(
                                                                                    padding: const EdgeInsets.only(top: 15,right: 15,left: 15,bottom: 10),
                                                                                    child: Text(
                                                                                      '${imgList[index]['nameTH']}',
                                                                                      textScaleFactor: 1.0,
                                                                                      style: TextStyle(
                                              color: status['id'] == imgList[index]['id'] ?Color(0xffBA1F23):Color(0xff1E1E1E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                   imgList[index]['NO'] == 0 ? Container()
                                          : Container(
                                          width: 12,
                                          height: 12,
                                          
                                          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
                                        ),
                                                                              ],
                                                                            ),
                                                                            
                                                                           status['id'] == imgList[index]['id'] ?  Expanded(
                                                                              child: Container(
                                                                                // height: 5,
                                                                                width: 60,
                                                                                color: Color(0xffBD2325),
                                                                               
                                                                              ),
                                                                            ):Container()
                                                                          ],
                                                                        ),
                                                                      ),
                                          );
                                         }),
              ),
            
            Expanded(
              child: Container(
                child: ListView.builder(
                                          //  physics: BouncingScrollPhysics(),
                                          //  scrollDirection: Axis.horizontal,
                                                                  shrinkWrap: true,
                                                                  itemCount: show_historys.length,
                                         itemBuilder: (context, index)  {
                                          
                                           if(status['nameTH'].toString() == show_historys[index]['status'].toString()){
                                          return InkWell(
                                            onTap: () {
                                                  MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Order_list(data: show_historys[index],),);
               Navigator.push(context, route);
                                            },
                                            child: Container(
                                              
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: ListView.builder(
                                             physics: BouncingScrollPhysics(),
                                            //  scrollDirection: Axis.horizontal,
                                                                    shrinkWrap: true,
                                                                    itemCount: show_historys[index]['product_amounts'].length,
                                                                                   itemBuilder: (context, index1)  {
                                                            return GestureDetector(
                                                              
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                  // color: Colors.amber,
                                                                 child: Column(
                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                   children: [
                                                                     Row(
                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                         children: [
                                                                                                          Container(
                                                                                                             margin: EdgeInsets.only(left: 10),
                                                                                                             child:show_historys[index]['product_amounts'][index1]['path_img'] != null?Image.network(
                                                                                    '${MyConstant().domain2}/${show_historys[index]['product_amounts'][index1]['path_img']}',
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
                                                                                                           child: Text('${show_historys[index]['product_amounts'][index1]['type']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                                                                         ),
                                                                                                                  Container(
                                                                                                           child: Text('ตัวเลือก : ${show_historys[index]['product_amounts'][index1]['name_product']},${show_historys[index]['product_amounts'][index1]['name_size']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffAFAFAF), fontSize: 12,fontWeight: FontWeight.w500),),
                                                                                                         ),
                                                                                                                  Container(
                                                                                                           child: Text('${show_historys[index]['product_amounts'][index1]['rate_product']} ฿ x${show_historys[index]['product_amounts'][index1]['amount']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 14,fontWeight: FontWeight.w600),),
                                                                                                         ),
                                                                                                               ],)
                                                                                                             ),
                                                                                                         ),
                                                                                                         ],
                                                                                                       ),

                                                                                                     
                                                                   ],
                                                                 ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async{
                                                          if(show_historys[index]['status'].toString() == 'ที่ต้องชำระ'){
                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                              preferences.setString('id_order', show_historys[index]['id'].toString());
          // generatePament(lnformation,'127.01.01');
           MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => CartOrder2(index:'1'),);
        Navigator.push(context, route);
                                                          //  generatePament(show_historys[index]['id'].toString());
                                                          }else{
                                                             MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Order_list(data: show_historys[index],),);
               Navigator.push(context, route);
                                                          }
                                                          
                                                        },
                                                        child: Container(
                                                          // color: Colors.black,
                                                                                 child: Row(
                                                                                   children: [
                                                                                    Container(
                                                                                                  margin: EdgeInsets.only(left: 10),
                                                                                     child: Text( 'ที่ต้องชำระ' == show_historys[index]['status'].toString()  ? 'ที่ต้องชำระ : ' :'รายละเอียด : ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffD00000), fontSize: 14,fontWeight: FontWeight.w400),),
                                                                                   ),
                                                                                   Container(
                                                                                                   margin: EdgeInsets.only(left: 10),
                                                                                                   child: Image.asset('assets/images/Rectangle 96.png',
                                                                                                   height: 18,),
                                                                                     ),
                                                                                   ],
                                                                                 ),
                                                                               ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ListView.builder(
                                             physics: BouncingScrollPhysics(),
                                            //  scrollDirection: Axis.horizontal,
                                                                    shrinkWrap: true,
                                                                    itemCount: show_historys[index]['product_amounts'].length,
                                                                                   itemBuilder: (context, index1)  {
                                                                                   return   show_historys[index]['status'].toString() != 'ที่ต้องได้รับ' && show_historys[index]['status'].toString() != 'สำเร็จ'? Container()
                                                                         : Container(
                                                                           margin: EdgeInsets.only(bottom: 10),
                                                                           alignment: Alignment.topRight,
                                                                           child: Row(
                                                                                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                 children: [
                                                                                                                                   Container(
                                                                                     child: Text('${show_historys[index]['product_amounts'][index1]['delivery']['name_delivery']} (ตัวเลือก : ${show_historys[index]['product_amounts'][index1]['name_product']},${show_historys[index]['product_amounts'][index1]['name_size']})',textScaleFactor: 1.0,style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14,fontWeight: FontWeight.w600),),
                                                                                   ),
                                                                                                                                   Container(
                                                                                                                                     
                                                                                                                                     decoration: BoxDecoration(
                                                                                                                                                   color: 'ที่ต้องชำระ' == show_historys[index]['product_amounts'][index1]['detail_status'].toString()? Color(0xffBA1F23):'ที่ต้องจัดส่ง' == show_historys[index]['product_amounts'][index1]['detail_status'].toString()?Color(0xff979696):'ที่ต้องได้รับ' == show_historys[index]['product_amounts'][index1]['detail_status'].toString()?Color.fromARGB(255, 0, 137, 21):'ที่ต้องจัดส่ง' == show_historys[index]['product_amounts'][index1]['detail_status'].toString()?Color(0xff979696):show_historys[index]['status'].toString() == 'สำเร็จ'&&'สำเร็จ' == show_historys[index]['product_amounts'][index1]['detail_status'].toString()?Color.fromARGB(255, 255, 2, 2):Colors.white,
                                                                                                                                                   borderRadius: BorderRadius.circular(50),
                                                                                                                                                 ),
                                                                                                                                                    child: GestureDetector(
                                                                                                                             onTap: () async{
                                                                                                                              
                                                                                                                                 if('${show_historys[index]['product_amounts'][index1]['detail_status']}'== 'ที่ต้องได้รับ'){
                                                                                                                                    print('res.statusCode===>${show_historys[index]['id'].toString()}');
                                                                                                                                         print('res.statusCode===>${show_historys[index]['product_amounts'][index1]['id_product_amount'].toString()}');
                                                                                                                                  
                                                                                                                                 confirm_order(show_historys[index]['id'].toString(),show_historys[index]['product_amounts'][index1]['id_product_amount'].toString());
                                                                                                                               } 
                                                                                                                                if(show_historys[index]['status'].toString() == 'สำเร็จ'&&show_historys[index]['product_amounts'][index1]['detail_status'].toString() == 'สำเร็จ'){
                                                                                                                                  buy_again(show_historys[index]['order_no'].toString(),'${show_historys[index]['product_amounts'][index1]['id_product_amount']}');
                                                                                                                               }  
                                                                                                                                 },
                                                                                                                                                      child: Padding(
                                                                                                                                                                                                                               padding: const EdgeInsets.only(top: 8,bottom: 8,right: 20,left: 20),
                                                                                                                                                                                                                               child:
                                                                                                                                                                                                                                     'ที่ต้องได้รับ' == show_historys[index]['product_amounts'][index1]['detail_status'].toString()?Container(
                                                                                                                                                                                                                                         child: Text('รับสินค้า',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12,fontWeight: FontWeight.w600),),
                                                                                                                                                                                                                                       ):show_historys[index]['status'].toString() == 'สำเร็จ'&&'สำเร็จ' == show_historys[index]['product_amounts'][index1]['detail_status'].toString()?Container(
                                                                                                                                                                                                                                         child: Text('ซื้ออีกครั้ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12,fontWeight: FontWeight.w600),),
                                                                                                                                                                                                                                       ):Container(
                                                                                                                                                                                                                                         child: Text('${show_historys[index]['product_amounts'][index1]['detail_status']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12,fontWeight: FontWeight.w600),),
                                                                                                                                                                                                                                       ),
                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                 
                                                                                                                                                                                                                               
                                                                                                                                                                                                                                 
                                                                                                                                                                                                                               
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                 ],
                                                                                                                               ),
                                                                                                                             
                                                                         );
                                                                                   }),
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
                                                                                   child: Text('${show_historys[index]['total_amount'].toString()} ตัว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                                                 ),
                                                                               
                                                                           ),
                                                                           Container(
                                                                               child: Row(
                                                                                 children: [
                                                                                
                                                                                   
                                                                                  Container(
                                                                                   child: Text('รวมการสั่งซื้อ : ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                                                 ),
                                                                                 Container(
                                                                                   child: Text('${show_historys[index]['shippingamount'].toString()} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 14,fontWeight: FontWeight.w600),),
                                                                                 ),
                                                                                 ],
                                                                               ),
                                                                             ),
                                                                           
                                                                         ],),
                                                                       ),
                                                                     ),
                                                 
                                                 Container(
                                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                                      child: Image.asset(
                                                        'assets/images/Line 11.png',
                                                        // height: 2,
                                                      ),
                                                    ),
                                                  'ยกเลิกแล้ว' == show_historys[index]['status'].toString()  ? Container() : 
                                         
                                               GestureDetector(
                                                    onTap: () async{
                                                          if(show_historys[index]['status'].toString() == 'ที่ต้องชำระ'){
                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                              preferences.setString('id_order', show_historys[index]['id'].toString());
          // generatePament(lnformation,'127.01.01');
           MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => CartOrder2(index:'1'),);
        Navigator.push(context, route);
                                                          //  generatePament(show_historys[index]['id'].toString());
                                                          }
                                                            if(show_historys[index]['status'].toString() == 'ที่ต้องจัดส่ง'){
                                                            cancle_order(show_historys[index]['order_no'].toString());
                                                          }

                                                            if(show_historys[index]['status'].toString() == 'ที่ต้องได้รับ'){
//                                                                    List<int> falseNOProductIds = [];
//   for (var product in show_historys[index]['product_amounts']) {
   
//           falseNOProductIds.add(product['id_product_amount']);
       
//   }

// String result = falseNOProductIds.join(',');
                                                            // confirm_order(show_historys[index]['id'].toString(),show_historys[index]['id_product_amount'].toString());
                                                          }
                                                          
                                                        },
                                                      child: Container(
                                                        margin: EdgeInsets.only(top: 0),
                                                        decoration: BoxDecoration(
                                                                      color: 'ที่ต้องชำระ' == show_historys[index]['status'].toString()? Color(0xffBA1F23):'ที่ต้องจัดส่ง' == show_historys[index]['status'].toString()?Color(0xff979696):Colors.white,
                                                                      borderRadius: BorderRadius.circular(50),
                                                                    ),
                                                                       child: Padding(
                                                                         padding: const EdgeInsets.only(top: 8,bottom: 8,right: 20,left: 20),
                                                                         child:
                                                                               'ที่ต้องชำระ' == show_historys[index]['status'].toString()?  Container(
                                                                                   child: Text('ชำระเงิน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12,fontWeight: FontWeight.w600),),
                                                                                //  ):'สำเร็จ' == show_historys[index]['status'].toString()?  Container(
                                                                                //    child: Text('ซื้ออีกครั้ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12,fontWeight: FontWeight.w600),),
                                                                                 ):'ที่ต้องจัดส่ง' == show_historys[index]['status'].toString()?Container(
                                                                                   child: Text('ยกเลิก',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12,fontWeight: FontWeight.w600),),
                                                                                 ):Container(
                                                                                   child: Text('',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12,fontWeight: FontWeight.w600),),
                                                                                 ),
                                                                             
                                                                           
                                                                         
                                                                           
                                                                         
                                                                       ),
                                                                     ),
                                                    ),
                                                      'ที่ต้องได้รับ' == show_historys[index]['status'].toString()||'สำเร็จ' == show_historys[index]['status'].toString() ?  Container()
                                                      : Container(
                                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                                      child: Image.asset(
                                                        'assets/images/Line 11.png',
                                                        // height: 2,
                                                      ),
                                                    ),
                                                    
                                              ],)
                                            ),
                                          );
                                         }else{
                                           return Container();
                                         }
                                         }),
              ),
            ),
              
                 
            ],)
          ),
        ),
      
    );
  }



 
// เลือกการชำระเงิน
    Future<void> generatePament(var id) async {
    try {
      
    SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
       String user_id = preferences.getString('id').toString();
      Map? valueMap;
      var uri = Uri.parse('${MyConstant().domain}/chillpay');
      var ressum;

            ressum = await http.post(uri,
            headers: {
       "Authorization":access_token
      },
      body: {
         'id': '$id',
        //  'channelCode': '${channelCode!['Code']}',
         'ipAddress': '127.01.01',
         'id_user': user_id
      }
            );
      
    
      
       print('ressum==>${ressum.statusCode}');
      if(ressum.statusCode == 200){
      
       var data =  json.decode(ressum.body);
        // print('data ===  0 ${data}');
        Map<dynamic, dynamic>? valueMap1 = jsonDecode('${data['data']}');
        // print('data === 1 ${valueMap1!['PaymentUrl']}');

          print('valueMap1 ==> ${valueMap1}');
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Pay(id_U: '${valueMap1!['PaymentUrl']}'),);
        Navigator.push(context, route);

        //  MaterialPageRoute route = MaterialPageRoute(
        //     builder: (context) => CartOrder2(Url: '${valueMap1!['PaymentUrl']}',id:'$id'),);
        // Navigator.push(context, route);
    //         Navigator.pushReplacement(context, MaterialPageRoute(
    // builder: (context)=> CartOrder2(Url: '${valueMap1!['PaymentUrl']}',id:'$id'),));
      print('successfully');
      }
    } catch (e) {
      print('e ===> ${e.toString()} ');
    }
  }



  Future cancle_order(var order_no) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
             var url = Uri.parse('${MyConstant().domain}/cancle_order');
      EasyLoading.show(status: 'กำลังยกเลิก');
      
     
      var response = await http.MultipartRequest('POST', url);
      response.headers['Authorization'] = access_token;
      response.fields['order_no'] =  order_no.toString();
     
            
 
      var res = await response.send();
      var response0 = await http.Response.fromStream(res);

      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
          var  lnformation2  = jsonDecode(response0.body)['message'];
        EasyLoading.showSuccess('$lnformation2').then((value)async {
         show_history();
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

   Future confirm_order(var id ,var id_product_amount) async {
    try {
     SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
             var url = Uri.parse('${MyConstant().domain}/confirm_order');
      EasyLoading.show(status: 'กำลังยืนยันรับสินค้า');
      
     
      var response = await http.MultipartRequest('POST', url);
      response.headers['Authorization'] = access_token; 
      response.fields['id'] =  id.toString();
      response.fields['status'] =  'สำเร็จ';
      response.fields['id_product_amount'] =  '$id_product_amount';
     
            
 
      var res = await response.send();
      var response0 = await http.Response.fromStream(res);

      print('res.statusCode===>${res.statusCode}');
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
          var  lnformation2  = jsonDecode(response0.body)['message'];
        EasyLoading.showSuccess('$lnformation2').then((value)async {
         show_history();
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



 


   Future<void> buy_again(var order_no,var id_product_amount)  async {
    try {
      setState(() {
        loading = true;
      });
     print('ressum.statusCode ==>${order_no}');   
       EasyLoading.show(status: 'กำลังสั่งซื้ออีกครั้ง');
        SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
       String user_id = preferences.getString('id').toString();
        print(id_product_amount);
       print(user_id);
      var uri = Uri.parse('${MyConstant().domain}/buy_again');
       var ressum = await http.post(uri,
       headers: {
       "Authorization":access_token
      },
       body: {
         'order_no': '$order_no',
         'id_product_amount': '$id_product_amount',
          //  'id': '$id',
       }
            );
           print('ressum.statusCode ==>${ressum.statusCode}');   
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);
          EasyLoading.showSuccess(lnformation['message'].toString()).then((value)async {
            setState(() {
         print(lnformation);
             
                 loading = false;
 
       
         
        });
        });   
       
          // data_promotion_stores();
    }else {

      var  lnformation  = jsonDecode(ressum.body);
        printWrapped(lnformation['message'].toString());
        EasyLoading.showError(lnformation['message'].toString());
        setState(() {
               loading = false;
 
        });
    }
    } catch (e) {
       printWrapped(e.toString());
      EasyLoading.showError(e.toString());
    }
  }
}
