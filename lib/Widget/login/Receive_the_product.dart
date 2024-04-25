import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Home_Start.dart';
import '../../Style/style.dart';
import '../../my_constant.dart';
import '../Forgot password/forgot1.dart';
import '../Menu/menu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class Receive_the_product extends StatefulWidget {
  const Receive_the_product({super.key});

  @override
  State<Receive_the_product> createState() => _Receive_the_productState();
}

class _Receive_the_productState extends State<Receive_the_product> {


bool isChecked = false;
  @override
  void initState() {
   
    super.initState();
    show_warehouse();
  }

   late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
         screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
    
      backgroundColor: Colors.white,
      body:   
      
      Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
               height: 210,
               width:  MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage('assets/images/Back-button-login-Regis2.png',),
                        fit: BoxFit.fill,
                       ),
                   ),
               child: Column(children: [
                 
                 Padding(
                   padding: const EdgeInsets.only(top: 50,right: 35,left: 35),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       InkWell(
                         onTap: () {
                            Navigator.pop(context);
                         },
                         child: Container(
                             alignment: Alignment.topLeft,
                             height: 20,
                             width: MediaQuery.of(context).size.width,
                           child: Image.asset(
                              'assets/images/icons8-chevron-left-100 6.png',
                            ),
                         ),
                       ),
                         Container(height: 20,),
                       Text('รับสินค้า',textScaleFactor: 1.0,style: textwhite20,),
                         Container(height: 10,),
                         Text('กรุณาเลือกรูปแบบการรับสินค้า ',textScaleFactor: 1.0,style: textwhite18),
                     ],
                   ),
                 ),
               
                
               ]),    
             ),
             Expanded(
                child:loading ? 
                        Container(
                child: Center(child: CircularProgressIndicator())): SingleChildScrollView(
                     physics: BouncingScrollPhysics(),
                  child: 
                        ListView.builder(
                                     physics: BouncingScrollPhysics(),
                                     
                             
                                                            shrinkWrap: true,
                                                            itemCount: show_warehouses.length,
                                   itemBuilder: (context, index)  {
                            return Padding(
                             padding: const EdgeInsets.only(right: 30,left: 30,top: 0),
                              child: InkWell(
                                onTap: () {
                                 routToService(show_warehouses[index]['id'],show_warehouses[index]['name']);
                                },
                                child: Card(
                                 elevation: 5,
                                 shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                      child: Container(
                                        height: 50,
                                          decoration: BoxDecoration(
                                   border: Border.all(color: Color(0xffFFFFFF), width: 1),
                                   borderRadius: BorderRadius.circular(30),
                                   color: Color(0xffFFFFFF),
                                                     ),
                                                     child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                     Container(
                                        margin: EdgeInsets.only(left: 20),
                                         width: 40,
                                       child: Image.asset(
                                                                   '${show_warehouses[index]['img']}',
                                                                 ),
                                     ),
                                  Text('${show_warehouses[index]['name']}',textScaleFactor: 1.0,style: textblack131,),
                                  Container(
                                     margin: EdgeInsets.only(right: 30),
                                    width: 20,
                                    child: Image.asset(
                                      'assets/images/Rectangle 179.png',
                                    ),
                                  ),
                                 ],
                                                       ),
                                      ),
                                                     ),
                              ),
                            );
                          }
                        ),
                    
                 
                ),
               ),
        
            
             
             
          ],
        ),
      ),
    );
  }

 


 bool loading = true;
 late  List<dynamic> show_warehouses = [];

   Future<void> show_warehouse() async {
    try {
     setState(() {
       loading = true;
     });
      var uri = Uri.parse('${MyConstant().domain}/show_warehouse');
       var ressum = await http.get(uri,
     
            );
               
      if(ressum.statusCode == 200) {
        var lnformation = jsonDecode(ressum.body);
        setState(() {
          show_warehouses = lnformation['data']['data'] ; 
           for (var warehouses in show_warehouses) {
             if(warehouses['name'].toString() == 'รับหน้าร้าน'){
                   warehouses["img"] = 'assets/images/mdi_truck-outline.png';
             }else{
                 warehouses["img"] = 'assets/images/iconamoon_store-fill.png';
             }
                 
            } 
       loading = false;
     });
    }else {
     
    }
    } catch (e) {
      print('e ===> ${e.toString()} ');
    }
  }



  
  Future routToService(var id,name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id_warehousecode', id.toString());
      preferences.setString('name_warehousecode', name.toString());
   
  
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=>    Menu(),), (route) => true);
  //  MaterialPageRoute route =
  //       MaterialPageRoute(builder: (context) => Menu(Data_User:Data_User,index: 0,));
  //   Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }









  

   
}
