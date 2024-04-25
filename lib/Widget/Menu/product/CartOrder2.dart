

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import 'package:http/http.dart' as http;

import '../menu.dart';
import '../product/productS.dart';
import 'order2.dart';
import 'pay.dart';




class CartOrder2 extends StatefulWidget {
   var index;
   CartOrder2({super.key,this.index});

  @override
  State<CartOrder2> createState() => _CartOrder2State();
}

class _CartOrder2State extends State<CartOrder2> {

 
  late Map<dynamic, dynamic>? channelCode = null;
  late var id0 = null;

 void Pay1()async {
  // ทำอะไรก็ตามที่ต้องการทำทุก 5 วินาที
// if(widget.Url.toString() == 'null'){

       
//     }else{
//         print('${widget.Url.toString()}');
    
//     //      MaterialPageRoute route = MaterialPageRoute(
//     //   builder: (context) => Pay(id_U: '${widget.Url.toString()}'),
//     // );
//     // await Navigator.push(context, route); // รอให้หน้าใหม่ทำงานเสร็จสมบูรณ์
//     // หลังจากหน้าใหม่ทำงานเสร็จสมบูรณ์
        
//     }
}
   
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    show_history();
     Timer.periodic(Duration(seconds: 5), (Timer t) => show_history0());
    // Pay1();
    
  }

  bool loading = false;
  // late  List<dynamic> show_animal = [];
  // Future<void> show_id_type_animal() async {
  //   try {
  //     setState(() {
  //       loading = true;
  //     });
  //      SharedPreferences preferences = await SharedPreferences.getInstance();
  //     //  String user_id = preferences.getString('id').toString();
  //     var uri = Uri.parse('${MyConstant().domain}/filter');
  //      var ressum = await http.post(uri,
  //      body: {
  //          "id_type_animal":  widget.id_type_animal.toString(),
  //        "price":  "",
  // "id_size": "",
  // "id_warehousecode" : "2"
  //      }
  //           );
              
  //     if(ressum.statusCode == 200){
  //         var  lnformation  = jsonDecode(ressum.body);

  //       setState(() {
       
  //        show_animal  =lnformation['data'];
      
  //       // print(show_deliverys);
  //                loading = false;
 
       
         
  //       });
  //         // data_promotion_stores();
  //   }else {
  //    setState(() {
  //        loading = false;
  //     });
  //   }
  //   } catch (e) {
  //     print('e ===>1 ${e.toString()} ');
  //   }
  // }


  


 // เลือกการชำระเงิน
    Future<void> generatePament() async {
    try {
      
   SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
      Map? valueMap;
      var uri = Uri.parse('${MyConstant().domain}/chillpay');
      var ressum;
      // print('valueMap1 ==> ${id0}');
      //  print('valueMap1 ==> ${channelCode!['Code']}');
      //   print('valueMap1 ==> ${user_id}');
            ressum = await http.post(uri,body: {
         'id': '$id0',
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
  late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
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
              // Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body:loading ? 
                          Container(
                  width: screenW * 1,
                  height: screenW * 1,
                  child: Center(child: CircularProgressIndicator())): 
         Container(
            // color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                 Row(
                          children: [
                            Container(
                              child: Text(
                                'คำสั่งซื้อ',
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
            
                 Expanded(
                   child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                                                    margin: EdgeInsets.only(top: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                       
                                                           Text( 'ได้รับคำสั่งซื้อแล้ว ',textScaleFactor: 1.0,
                                                                     style: new TextStyle(
                                                                   fontWeight: FontWeight.w500,
                                                                      color: Color(0xff1E1E1E),
                                                                      fontSize: 18,
                                                                    ),),
                             
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async{
                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
       preferences.setString('id_order', '');
                                                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=>    Menu(),), (route) => false);
                                                              },
                                                              child: Container(
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
                                                                                                                      'หน้าหลัก',
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
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                   MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => Order_list(data : show_historys),);
                 Navigator.push(context, route);
                                                                                                },
                                                                                                child: Container(
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
                                                                                                                                                      'ดูคำสั่งซื้อ',
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
                                                                                            show_historys!['status'] != 'ที่ต้องชำระ'?Container()
                                                                                            :   GestureDetector(
                                                                                                 onTap: () {
                                                                                                   generatePament() ;
          //                                                                                              print('${widget.Url.toString()}');
          //   MaterialPageRoute route = MaterialPageRoute(
          //     builder: (context) => Pay(id_U: '${widget.Url.toString()}'),);
          // Navigator.push(context, route);
                                                                                                 },
                                                                                                 child: Container(
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
                                                                                                                                                       'ชำระสินค้า',
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
           
                                                    Container(
                                                       
                                                         child: Image.asset(
                                                           'assets/images/icons8-ok-100 1.png',
                                                           height: 40,
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
                                                         child: Text('ชำระเงินเงินผ่าน ${channelCode!['name']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                       ),
                                   Container(
                                                         child: Text('ยังไม่ได้ชำระเงินยอดผ่าน ${channelCode!['name1']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                       ),
                              ]),
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                  ),
    
                                               
             
                                                      ],
                                                    )
                                   //                                     ExpansionTile(
                                   //                                        trailing: Image.asset(
                                   //                       'assets/images/Rectangle 92.png',
                                   //                       height: 30,
                                   //                     ),
                                   //                                       initiallyExpanded: loading0 ==1,
                                   //                                            onExpansionChanged: (value) {
                                   //        if (value) {
                                   //          setState(() {
                                   // loading0 = 0;
                                   //          });
                                   //        } else {
                                   //          setState(() {
                                   //  loading0 = 1;
                                   //          });
                                   //        }
                                   //      },
                                   //                                        title: ListTile(
                                   //          title:  Column(
                                   //            crossAxisAlignment: CrossAxisAlignment.start,
                                   //            children: [
                                   //              Text( 'Mobile Banking',textScaleFactor: 1.0,
                                   //                                          style: new TextStyle(
                                                           
                                   //                                           color: Color.fromARGB(255, 0, 0, 0),
                                   //                                           fontSize: 18,
                                   //                                         ),),
                                   //              Text( 'ชำระในแอwพลิเคชั่นธนาคาร',textScaleFactor: 1.0,
                                   //                                          style: new TextStyle(
                                                           
                                   //                                           color: Color.fromARGB(255, 0, 0, 0),
                                   //                                           fontSize: 18,
                                   //                                         ),),
                                   //            ],
                                   //          ),
                                   //        ),
                                   //        children: [
                                   //          ListView.builder(
                                   //       // physics: NeverScrollableScrollPhysics(),
                                   //       // scrollDirection: Axis.horizontal,
                                   //                           shrinkWrap: true,
                                   //                            itemCount: 5, 
                                   //                            itemBuilder: (BuildContext context, int index1) {  
                                   //                              return  Container(
                                                    
                                   //        height: 80,
                                   //        width: 80,
                                   //        child: GestureDetector(
                                   //             onTap: () {
                                   //               setState(() {
                                  
                                   //               });
                                 
                                   //             },
                                   //          child: Row(
                                   //            children: [
                                   //             //  Center(
                                   //             //    child: Container(
                                   //             //      height: 70,
                                   //             //      width: 70,
                                   //             //        decoration: BoxDecoration(
                                   //             //       // border: Border.all(color: Color(0xff83bb56), width: 2),
                                   //             //       borderRadius: BorderRadius.circular(40),
                                   //             //       color: Color.fromARGB(255, 255, 255, 255)),
                                   //             //       // child: Center(
                                   //             //       //   child: 
                                   //             //               // Container(
                                   //             //               //   height: 50,
                                   //             //               //   child:  Image.asset('${_products1[index]['pay'][index1]['img']}',
                                   //             //               //                         // color: Color.fromARGB(255, 58, 100, 23),
                                   //             //               //                         height: 50,),
                                   //             //               // ),
                                            
                                   //             //       // ),
                                   //             //       ),
                                   //             //    ),
                                   //               Row(
                                   //                 children: [
                                   //                   Text('gyui',textScaleFactor: 1.0,
                                   //                                            style: new TextStyle(
                                                                
                                   //                                             fontSize: 16,
                                   //                                           ),),
                                   //                   Text('jojio',textScaleFactor: 1.0,
                                   //                                            style: new TextStyle(
                                   //                                             // fontFamily: fonts,
                                   //                                             // color: Codedata==_products1[index]['pay'][index1]['Code']?Color.fromARGB(255, 0, 254, 25):Color.fromARGB(255, 0, 0, 0),
                                   //                                             fontSize: 16,
                                   //                                           ),),
                                   //                 ],
                                   //               ),
                                   //            ],
                                   //          ),
                                   //        ),
                           
                                   //      );
                                   //                            },
                                   //          ),
                                   //        ],)
                                                      ),
                   ),
                   ),
                 )
                   
              ],)
            ),
          ),
        
      ),
    );
  }


  
  Future<void> show_history0() async {
  try {
   
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('id').toString();
     setState(() {
    id0 = preferences.getString('id_order').toString();
    });
    var uri = Uri.parse('${MyConstant().domain}/status');
    var ressum = await http.post(uri,
        // headers: {
        //   // "Content-Type": "application/json",
        // },
        body: {
          "id_order": id0.toString(),
        });
     
    if (ressum.statusCode == 200) {
      var lnformation = jsonDecode(ressum.body);
      setState(() {
        show_historys = lnformation['data'];
        print(show_historys);
  

        
      // for (var data in lnformation['data']) {
      //   mergedData.addAll(data[0]);
      // }
          //  List<dynamic> combinedData = lnformation['data'].expand((element) => element).toList();

    
     loading = false;
   
      });
    } else {
      // setState(() {
      //    loading = false;
           
      // });
      // loading = false;
      // var lnformation = jsonDecode(ressum.body);
      // print('product_users=== $lnformation');
    }
  } catch (e) {
    print('e ===>23 ${e.toString()} ');
  }
}
 
late Map<String,dynamic>? show_historys = null;
  Future<void> show_history() async {
  try {
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('id').toString();
    
    setState(() {
      loading = true;
       id0 = preferences.getString('id_order').toString();
    });
    var uri = Uri.parse('${MyConstant().domain}/status');
    var ressum = await http.post(uri,
        // headers: {
        //   // "Content-Type": "application/json",
        // },
        body: {
          "id_order": id0,
        });
    if (ressum.statusCode == 200) {
      var lnformation = jsonDecode(ressum.body);
      setState(() {
        show_historys = lnformation['data'];
        if(show_historys!['bank'] == 'QR Payment'){
          channelCode = {
               'name' : 'QR Payment',
               'name1' : 'QR Payment',
               'Code' : '${show_historys!['channelCode']}',
          };   
        }else if(show_historys!['bank'] == 'บัตรเครดิต/เดบิต'){
            channelCode = {
               'name' : 'บัตรเครดิต/เดบิต',
               'name1' : 'บัตรเครดิต/เดบิต',
               'Code' : '${show_historys!['channelCode']}',
          };  
        }else{
          channelCode = {
               'name' : 'ชำระในแอwพลิเคชั่นธนาคาร',
               'name1' : '${show_historys!['bank']}',
               'Code' : '${show_historys!['channelCode']}',
          }; 
        }
           

        
      // for (var data in lnformation['data']) {
      //   mergedData.addAll(data[0]);
      // }
          //  List<dynamic> combinedData = lnformation['data'].expand((element) => element).toList();

    
      // product_users == product_userss;
     loading = false;
     if(widget.index == '1'){
         generatePament();
     }
  
      });
    } else {
      setState(() {
         loading = false;
             if(widget.index == '1'){
         generatePament();
     }
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
