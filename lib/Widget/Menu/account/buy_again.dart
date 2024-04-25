import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import 'package:http/http.dart' as http;

import '../product/productS.dart';




class Buy_Again extends StatefulWidget {
   int? index;
   var id_type_animal;
   var id_type_animalname;
   Buy_Again({super.key,this.index,this.id_type_animal,this.id_type_animalname});

  @override
  State<Buy_Again> createState() => _Buy_AgainState();
}

class _Buy_AgainState extends State<Buy_Again> {

    late  List<dynamic> imgList = [
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
  'https://images.pexels.com/photos/3586056/pexels-photo-3586056.jpeg',
];
   
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index.toString() == '1'){
      product_user();
    }else{
      show_id_type_animal();
    }
  }

  bool loading = true;
  late  List<dynamic> show_animal = [];
  Future<void> show_id_type_animal() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String id_warehousecode = preferences.getString('id_warehousecode').toString();
      var uri = Uri.parse('${MyConstant().domain}/filter');
       var ressum = await http.post(uri,
       body: {
           "id_type_animal":  widget.id_type_animal.toString(),
         "price":  "",
  "id_size": "",
  "id_warehousecode" : "$id_warehousecode"
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
       
         show_animal  =lnformation['data'];
      
        // print(show_deliverys);
                 loading = false;
 
       
         
        });
          // data_promotion_stores();
    }else {
     setState(() {
         loading = false;
      });
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


  

  Future<void> product_user() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
      var uri = Uri.parse('${MyConstant().domain}/product_user');
       var ressum = await http.post(uri,
       body: {
         'id_user': user_id
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         show_animal  =lnformation['data'];
      
                 loading = false;
 
         print('show_animal===>$show_animal');
         
        });
          // data_promotion_stores();
    }else {
      setState(() {
         loading = false;
      });
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
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
                             widget.index.toString() == '1' ? 'ซื้ออีกครั้ง':widget.id_type_animalname.toString(),
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
                   child: Padding(padding: EdgeInsets.only(top: 20),
                            child: new StaggeredGrid.count(
                              mainAxisSpacing : 10,
                              crossAxisSpacing :10,
                               crossAxisCount: 3, 
                               children: show_animal.map<Widget>((item) {
                               return  InkWell(
                                   onTap: () async{
                                      Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                             builder: (_) =>ProductS(id_product: item['id_product'],name:item['type']) ),);
                                     if (navigationResult == null ) {
                                          if(widget.index.toString() == '1'){
                       product_user();
                     }else{
                       show_id_type_animal();
                     }
                                     }
                                   },
                                   child: Container(
                                                                      height: 150,
                                                                      // width: 120,
                                                                      decoration: BoxDecoration(
                                                                        color: Color(0xFFF5F5F5),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          mainAxisAlignment:MainAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Image.network(
                                                                              '${MyConstant().domain2}/${item['path_img']}',
                                                                              // height: 70,
                                                                                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: widget.index.toString() == '1'?Text('${item['name']}',textScaleFactor: 1.0,
                                                                                                                                                          
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 1,
                                                                                  style: TextStyle(
                                                                                                                              fontSize: 14,
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              color: Colors.black,
                                                                                                                            ),)
                                                                                  : Text('${item['size_name']}',textScaleFactor: 1.0,
                                                                                                                                                          
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 1,
                                                                                  style: TextStyle(
                                                                                                                              fontSize: 14,
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              color: Colors.black,
                                                                                                                            ),),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                   Expanded(
                                                                                     child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                       children: [
                                                                                          Text('${item['sale_price']} ฿',textScaleFactor: 1.0,
                                                                                           overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 1,
                                                                                    style: TextStyle(
                                                                                                                                 // fontFamily: 'IBM',
                                                                                                                                 fontSize: 14,
                                                                                                                                 fontWeight: FontWeight.w600,
                                                                                                                                 color: Color(0xffBA1F23),
                                                                                                                               ),),
                                                                                           Text('${item['price']} ฿',textScaleFactor: 1.0,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 1,
                                                                                    style: TextStyle(
                                                                                                                           // fontFamily: 'IBM',
                                                                                                                                 decoration: TextDecoration.lineThrough,
                                                                                                                                 decorationColor: Color(0xFF989898),
                                                                                                                           fontSize: 12,
                                                                                                                           fontWeight: FontWeight.w400,
                                                                                                                           color: Color(0xff979696),
                                                                                                                         ),), 
                                                                                       ],
                                                                                     ),
                                                                                   ),
                                                                                     GestureDetector(
                                                      onTap: () {
                                          // ทำสิ่งที่คุณต้องการเมื่อปุ่มถูกแตะ
                                          print('Button tapped!');
                                                      },
                                                      child: Container(
                                          width: 25.0,
                                          height: 25.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFFFAAB35), // สีพื้นหลังของปุ่ม
                                          ),
                                          child: Center(
                                            child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                           height: 25,
                                                          width: 25,
                                                          child: Image.asset(
                                                                'assets/images/+.png',
                                                              ),
                                                        ),
                                            ),
                                          ),
                                                      ),
                                                    ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      
                                                                    ),
                                 );
                               }).toList(),
                            ),        ),
                 ),
               )
                 
            ],)
          ),
        ),
      
    );
  }



 

}
