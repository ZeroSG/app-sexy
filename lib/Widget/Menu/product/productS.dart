import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import 'basket.dart';
 import 'package:http/http.dart' as http;
class ProductS extends StatefulWidget {
  var id_product;
  var name;
  
  ProductS({super.key,this.id_product,this.name});

  @override
  State<ProductS> createState() => _ProductSState();
}

class _ProductSState extends State<ProductS> {
  late List<dynamic> imgList = [
   
  ];
  late  List<dynamic> typeList =[];
  String? typeListname = '';
  Map<String,dynamic>? datas = null;
  var imgListid = '';
  int imgLists = 0;
  int Sum = 10;
late  List<dynamic> data = [];
late  List<dynamic> data2 = [];
 bool loading = true;
  Future<void> show_Detailproduct() async {
    try {
      setState(() {
        loading = true;
      });
      var uri = Uri.parse('${MyConstant().domain}/show_Detailproduct');
       var ressum = await http.post(uri,
       body: {
         'id': widget.id_product.toString()
       }
            );
       
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

          
  
  // วนลูปเพื่อดึงชื่อ type และเพิ่มเข้า List ถ้ายังไม่มีใน List อยู่
 
          
        setState(() {
         
    
         data =lnformation['data'];
          datas = data[0];

          for (var type in data) {
    String typeName = type['type'];
    if (!typeList.contains(typeName)) {
      typeList.add(typeName);
    }
  }
  print(typeList);
  if(typeList.length ==0){
   
  }else{
  
    typeListname = typeList[0];
    for(var i = 0 ;i<data.length ;i++ ){
     if(data[i]['type'].toString() == typeListname){
       data2.add(data[i]);
     }
    }
    
  }      
 print(data2) ;     

         

 
 setState(() {
                                       
                                         typeListname = widget.name.toString();
                                         data2 = [];
                                           for(var i = 0 ;i<data.length ;i++ ){
     if(data[i]['type'].toString() == typeListname){
       data2.add(data[i]);
     }
    }
                                        for(var i = 0;i<data.length;i++){
                                           if(data[i]['type'].toString()== typeListname){
                                             print(data[i]);
                                              datas = data[i];
                                       
                                               Sum = int.parse('${datas!["amount"]}') >= 10  ? 10: int.parse('${datas!["amount"]}') < 0 ? 0: int.parse('${datas!['amount']}');
                                             break;
                                           }
                                        }
                                       });


         loading = false;

       
         
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show_Detailproduct();
  }
  
  late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    print(screenW * 0.7);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffD34739),
        leading: IconButton(
          icon: Container(
            margin: EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/icons8-chevron-left-100 8.png',
              height: 18,
              color: Colors.white,
            ),
          ), // เปลี่ยนไอคอนตามที่ต้องการ
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
                               onTap: () async{
                                  Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Basket() ),);
                                 if (navigationResult == null ) {

                                 }
                               },
            child: Container(
              margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset(
                    'assets/home/Rectangle 31.png',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body:loading ? 
                        Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator())):SingleChildScrollView(physics: BouncingScrollPhysics(),
      
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 150,
                          color:datas!['path_img'].toString().split('.').first == 'jpg'? Color(0xffD34739):Color.fromARGB(255, 255, 255, 255),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(60),
                            topLeft: Radius.circular(60),
                          ),
                          child: Container(
                            height: 70,
                            width: screenW * 0.7,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      datas == null ?  Container(
                         
                        )
                        :Container(
                          child: Image.network(
                          '${MyConstant().domain2}/${datas!['path_img']}',
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 5),
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: data.length,
      
                              //   separatorBuilder:  (context, index) {
      
                              //   return const SizedBox(width: 2,);
      
                              // },
      
                              itemBuilder: (context, index) {
                                if(data[index]['type'].toString() == typeListname){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        imgListid = data[index]['id'].toString();
                                         datas = data[index];
                                        Sum = int.parse('${datas!["amount"]}') >= 10  ? 10: int.parse('${datas!["amount"]}') < 0 ? 0: int.parse('${datas!['amount']}');

                                         
                                    
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: datas.toString() == data[index].toString()
                                                ? Color(0xffAA4755)
                                                : Colors.white,
                                            width: 1),
                                        // borderRadius: BorderRadius.circular(30),
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Image.network(
                                         '${MyConstant().domain2}/${data[index]['path_img']}',
                                                                  ),
                                    ),
                                  ),
                                );
                              }else{
                                return Container();
                              }
                              }),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(child: Padding(
                                padding: const EdgeInsets.only(right: 5,left: 5),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Container(
                                       child:  Text(
                                              '${datas!['name']}',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                // fontFamily: 'IBM',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                     ),  
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                       child:  Text(
                                              'ราคา   ',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                // fontFamily: 'IBM',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                     ), 
                                     Container(
                                       child:  Text(
                                              '${datas!['sale_price']} ฿  ',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                // fontFamily: 'IBM',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xffBA1F23),
                                              ),
                                            ),
                                     ), 
                                   Container(
        child: RichText(
          text: TextSpan(
            text: ' ', // เพิ่มข้อความที่ไม่ถูกขีดเส้นกลาง
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff979696),
               decoration: TextDecoration.lineThrough,
               decorationColor:Color(0xff979696),
            ),
          ),
        ),
      ),
                                          ],
                                        ),
                                      ),
                                  ]),
                                ),
                              )),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if(Sum == 0){

                                              }else{
                                                Sum =  Sum -10;
                                              }
                                            
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFAAB35),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '-',
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                  // fontFamily: 'IBM',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 25,left: 25),
                                          child: Text(
                                            '$Sum',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              // fontFamily: 'IBM',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              print(datas);
                                              if(int.parse('${datas!['amount']}')<=0 || '${datas!['amount']}' == 'null'){
                                               Sum =  Sum +10;
                                              }else{
                                                   if(int.parse('${datas!['amount']}') < Sum +10){

                                              }else{
                                                Sum =  Sum +10;
                                              }
                                              }
                                            
                                             
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFAAB35),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '+',
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                  // fontFamily: 'IBM',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: int.parse('${datas!['amount']}')<=0 || '${datas!['amount']}' == 'null' ?Text(
                                      '*สินค้ารอการ Pre - Order ประมาณ 15-20 วัน',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        // fontFamily: 'IBM',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffD00000),
                                      ),
                                    )
                                    : Text(
                                      '*สินค้าในสต็อคเหลือน้อย',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        // fontFamily: 'IBM',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffD00000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          
                                       child:  Text(
                                              'ประเภท',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                // fontFamily: 'IBM',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                     ),  
               Container(
                 child: Row(
                   children: [
                     Expanded(
                       child: Container(
                           height: 40,
                           child: 
                             
                             ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: typeList.length,
                  
                              itemBuilder: (context, index) {
                                 return InkWell(
                                     onTap: () {
                                       setState(() {
                                         loading = true;
                                         typeListname = typeList[index];
                                         data2 = [];
                                           for(var i = 0 ;i<data.length ;i++ ){
     if(data[i]['type'].toString() == typeListname){
       data2.add(data[i]);
     }
    }
                                        for(var i = 0;i<data.length;i++){
                                           if(data[i]['type'].toString()== typeListname){
                                             print(data[i]);
                                              datas = data[i];
                                              loading = false;
                                               Sum = int.parse('${datas!["amount"]}') >= 10  ? 10: int.parse('${datas!["amount"]}') < 0 ? 0: int.parse('${datas!['amount']}');
                                             break;
                                           }
                                        }
                                       });
                                     },
                                     child: Container(
                                                margin: EdgeInsets.only(right: 5),
                                                decoration: typeListname  == typeList[index] ? BoxDecoration(
                                                  color: Color(0xffBD2325) ,
                                                  border: Border.all(
                                                color: Color(0xffBD2325) ,
                                                width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ):BoxDecoration(
                                                  
                                                  border: Border.all(
                                                color: Color(0xffD34739) ,
                                                width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                                                  child: Center(
                                                    child: Text(
                                                      '${typeList[index]}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                        // fontFamily: 'IBM',
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                        color: typeListname  == typeList[index] ?Color(0xffFFFFFF):Color(0xffD34739),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                   );
                               }
                             ),
                                
                         
                       ),
                     ),
                     Container(
                       child: Row(
                         children: [
                           Container(
              margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                 border: Border.all(
                                            color: Color(0xffBD2325) ,
                                            width: 1),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 15,
                  width: 15,
                  child: Image.asset(
                    'assets/home/Rectangle 31.png',
                  ),
                ),
              ),
            ),
                               InkWell(
                                 onTap: () {
                                
                                   cart(datas!['id_product_amount'].toString(),Sum);
                                 },
                                 child: Container(
                                           
                                            decoration: BoxDecoration(
                                              color: Color(0xff000000),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
                                              child: Center(
                                                child: Text(
                                                  'ซื้อสินค้า',
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                    // fontFamily: 'IBM',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffFFFFFF),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                               ),
                              
                         ],
                       ),
                     )
                   ],
                 ),
               )         ,
                  Container(
                          
                                       child:  Text(
                                              'ขนาด',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                // fontFamily: 'IBM',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                     ),   
      
                      Padding(padding: EdgeInsets.only(),
                          child: new StaggeredGrid.count(
                            mainAxisSpacing : 10,
                            crossAxisSpacing :10,
                             crossAxisCount: 6, 
                             children: data2.map<Widget>((item) {
                              if(item['type'].toString() == typeListname){
                               return InkWell(
                                 onTap: () async{
                                     setState(() {
                                        imgListid = item['id'].toString();
                                        datas = item;
                                     Sum = int.parse('${datas!["amount"]}') >= 10  ? 10: int.parse('${datas!["amount"]}') < 0 ? 0: int.parse('${datas!['amount']}');

                                      });
                                 },
                                 child:  Container(
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                              color: datas.toString() == item.toString()?Color(0xffBD2325) :Color.fromARGB(15, 255, 255, 255) ,
                                              border: Border.all(
                                            color: Color(0xffBD2325) ,
                                            width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 5,left: 5,top: 5,bottom: 5),
                                              child: Center(
                                                child: Text(
                                                  item['size_name'],
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                    // fontFamily: 'IBM',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: datas.toString() == item.toString()?Color(0xffFFFFFF) : Color(0xffBD2325),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                               );
                              }else{
                                return Container(
                                  height: 0,
                                );
                              }
                             }).toList(),
                          ),        )    
                          , Container(
                          margin: EdgeInsets.only(top: 10),
                                       child:  Text(
                                              'รายละเอียดสินค้า',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                // fontFamily: 'IBM',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                     ),
                          Container(
                          
                                       child:  HtmlWidget(
                                              '''${datas!['detail']}''',
                                              // textScaleFactor: 1.0,
                                              // style: TextStyle(
                                              //   // fontFamily: 'IBM',
                                              //   fontSize: 13,
                                              //   fontWeight: FontWeight.w500,
                                              //   color: Color(0xff979696),
                                              // ),
                                            ),
                                     ),  
                           Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),    Container(
                 margin: EdgeInsets.only(bottom: 20),         
                                       child:  Center(
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             Text(
                                                    'ดูเพิ่มเติม',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      // fontFamily: 'IBM',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffBD2325),
                                                    ),
                                                  ),
                                               Container(
                                                 margin:EdgeInsets.only(left: 5),
                                                 child: Image.asset(
                                                             'assets/images/Rectangle 187.png',
                                                             height: 15,
                                                           ),
                                               ),    
                                           ],
                                         ),
                                       ),
                                     ), 
                                               
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }


  
  Future<void> cart(var id_product_amount,var amount) async {
    try {
      setState(() {
        loading = true;
      });
     
       EasyLoading.show(status: 'กำลังบันทึกข้อมูล');
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
        print(id_product_amount);
       print(user_id);
      var uri = Uri.parse('${MyConstant().domain}/cart');
       var ressum = await http.post(uri,
       body: {
         'id_user': user_id,
         'id_product_amount': id_product_amount.toString(),
          'amount': '$amount',
          //  'id': '$id',
       }
            );
              
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

     void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
