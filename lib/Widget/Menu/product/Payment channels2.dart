

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import 'package:http/http.dart' as http;

import '../product/productS.dart';




class Payment_Channels2 extends StatefulWidget {
   var name;
   Payment_Channels2({super.key,this.name});

  @override
  State<Payment_Channels2> createState() => _Payment_Channels2State();
}

class _Payment_Channels2State extends State<Payment_Channels2> {

  
   
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
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                         Text( 'Krungsri Moblie App (KMA)',textScaleFactor: 1.0,
                                                                   style: new TextStyle(
                                                                 fontWeight: FontWeight.w500,
                                                                    color: Color(0xff1E1E1E),
                                                                    fontSize: 18,
                                                                  ),),
                           
                                                          GestureDetector(
                                                          onTap: ()async {
                                                           setState(() {
                                                             if(loading0 == 1){
                                                               loading0 = 0;

                                                             }else{
                                                                 loading0 = 1;
                                                             }
                                                              
                                                           });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                left: 5),
                                                            child: loading0 == 1
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
                                            Container(
                                                       margin: EdgeInsets.only(top: 10, bottom: 10),
                                                       child: Image.asset(
                                                         'assets/images/Line 11.png',
                                                         // height: 2,
                                                       ),
                                                     ),
                                                      

          Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                         Text( 'SBC Easy App',textScaleFactor: 1.0,
                                                                   style: new TextStyle(
                                                                 fontWeight: FontWeight.w500,
                                                                    color: Color(0xff1E1E1E),
                                                                    fontSize: 18,
                                                                  ),),
                           
                                                        GestureDetector(
                                                          onTap: ()async {
                                                           setState(() {
                                                             if(loading0 == 2){
                                                               loading0 = 0;

                                                             }else{
                                                                 loading0 = 2;
                                                             }
                                                           });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                left: 5),
                                                            child: loading0 == 2
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
                                           Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),    

          Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                         Text( 'Krungthai NEXT',textScaleFactor: 1.0,
                                                                   style: new TextStyle(
                                                                 fontWeight: FontWeight.w500,
                                                                    color: Color(0xff1E1E1E),
                                                                    fontSize: 18,
                                                                  ),),
                           
                                                      GestureDetector(
                                                          onTap: ()async {
                                                           setState(() {
                                                             if(loading0 == 3){
                                                                loading0 = 0;
                                                             }else{
                                                                 loading0 = 3;
                                                             }
                                                           });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                left: 5),
                                                            child: loading0 == 3
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
                                           Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),  
           Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                         Text( 'K PLUS',textScaleFactor: 1.0,
                                                                   style: new TextStyle(
                                                                 fontWeight: FontWeight.w500,
                                                                    color: Color(0xff1E1E1E),
                                                                    fontSize: 18,
                                                                  ),),
                           
                                                      GestureDetector(
                                                          onTap: ()async {
                                                           setState(() {
                                                             if(loading0 == 4){
                                                                loading0 = 0;
                                                             }else{
                                                                 loading0 = 4;
                                                             }
                                                           });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                left: 5),
                                                            child: loading0 == 4
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
                                           Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),    
           Container(
                 margin: EdgeInsets.only(top: 0,bottom: 10,right: 10,left: 10),
                 child: GestureDetector(onTap: () {
                             if(loading0 == 1){
                               Map<String,dynamic> data = {
                                                'name' : 'Mobile Banking',
                                                 'name1' : 'Krungsri Moblie App (KMA)',
                                                 'Code' : 'mobilebank_bay',
                                               };
                                                Navigator.pop(context,data);
                                                   Navigator.pop(context,data);
                             } else if(loading0 == 2){
                               Map<String,dynamic> data = {
                                                 'name' : 'Mobile Banking',
                                                 'name1' : 'SBC Easy App',
                                                 'Code' : 'mobilebank_scb',
                                               };
                                                Navigator.pop(context,data);
                                                 Navigator.pop(context,data);
                             }else if(loading0 == 3){
                               Map<String,dynamic> data = {
                                                      'name' : 'Mobile Banking',
                                                 'name1' : 'Krungthai NEXT',
                                                 'Code' : 'mobilebank_ktb',
                                               };
                                                Navigator.pop(context,data);
                                                Navigator.pop(context,data);
                             }else if(loading0 == 4){
                               Map<String,dynamic> data = {
                                                      'name' : 'Mobile Banking',
                                                 'name1' : 'K PLUS',
                                                 'Code' : 'payplus_kbank',
                                               };
                                                Navigator.pop(context,data);
                                                Navigator.pop(context,data);
                             }else{

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
      
    );
  }



 

}
