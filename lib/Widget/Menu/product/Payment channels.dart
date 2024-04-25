

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import 'package:http/http.dart' as http;

import '../product/productS.dart';
import 'Payment channels2.dart';




class Payment_Channels extends StatefulWidget {
   Payment_Channels({super.key});

  @override
  State<Payment_Channels> createState() => _Payment_ChannelsState();
}

class _Payment_ChannelsState extends State<Payment_Channels> {

  
   
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
   int? loading0 = 0;
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
                              'ซื้ออีกครั้ง',
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
                                                    children: [
                                                       InkWell(
                                             onTap: ()async {
                                                      Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Payment_Channels2() ),);
                                 if (navigationResult != null ) {
                                     
                                 }
                                             },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(  
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                              Text( 'Mobile Banking',textScaleFactor: 1.0,
                                                                     style: new TextStyle(
                                                                   fontWeight: FontWeight.w500,
                                                                      color: Color(0xff1E1E1E),
                                                                      fontSize: 18,
                                                                    ),),
                                                                                     Text( 'ชำระในแอwพลิเคชั่นธนาคาร',textScaleFactor: 1.0,
                                                                     style: new TextStyle(
                                                                      fontWeight: FontWeight.w400,
                                                                      color: Color(0xff979696),
                                                                      fontSize: 14,
                                                                    ),),
                                                            ],),
                                                            Image.asset(
                                                                                              'assets/images/Rectangle 92.png',
                                                                                              height: 30,
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
                                                     

           InkWell(
                                             onTap: () {
                                               String name = 'บัตรเครดิต/เดบิต';
                                               Map<String,dynamic> data = {
                                                 'name' : 'บัตรเครดิต/เดบิต',
                                                 'name1' : 'บัตรเครดิต/เดบิต',
                                                 'Code' : 'creditcard',
                                               };
                                               Navigator.pop(context,data);
                                             },
            child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(  
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                              Text( 'บัตรเครดิต/เดบิต',textScaleFactor: 1.0,
                                                                     style: new TextStyle(
                                                                   
                                                                    
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Color(0xff1E1E1E),
                                                                      fontSize: 18,
                                                                    ),),
                                 Text( 'บัตรเครดิต/เดบิต',textScaleFactor: 1.0,
                                                                     style: new TextStyle(
                                                                   
                                                                        fontWeight: FontWeight.w400,
                                                                      color: Color(0xff979696),
                                                                      fontSize: 14,
                                                                    ),),
                                                            ],),
                                                            Image.asset(
                                          'assets/images/Rectangle 92.png',
                                          height: 30,
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

          InkWell(
                                             onTap: () {
                                               String name = 'QR Payment';
                                               Map<String,dynamic> data = {
                                                 'name' : 'QR Payment',
                                                 'name1' : 'QR Payment',
                                                 'Code' : 'bank_qrcode',
                                               };
                                               Navigator.pop(context,data);
                                             },
            child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(  
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                              Text( 'QR Payment',textScaleFactor: 1.0,
                                                                     style: new TextStyle(
                                                                   
                                                                    
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Color(0xff1E1E1E),
                                                                      fontSize: 18,
                                                                    ),),
                                 Text( 'QR Payment',textScaleFactor: 1.0,
                                                                     style: new TextStyle(
                                                                   
                                                                        fontWeight: FontWeight.w400,
                                                                      color: Color(0xff979696),
                                                                      fontSize: 14,
                                                                    ),),
                                                            ],),
                                                            Image.asset(
                                          'assets/images/Rectangle 92.png',
                                          height: 30,
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
                                 //        child: InkWell(
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
      
    );
  }



 

}
