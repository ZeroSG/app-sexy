import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:sexy/Widget/Menu/product/pay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Home_Start.dart';
import '../../../my_constant.dart';
 import 'package:http/http.dart' as http;

import '../account/add_address.dart';
import '../account/add_tax.dart';
import '../menu.dart';
import 'CartOrder2.dart';
import 'Payment channels.dart';



class CartOrder extends StatefulWidget {
  List<dynamic>? products2 ;
  List<dynamic>? products3 ;
  var Sum;
  var totalAmount;
   CartOrder({super.key,this.products2,this.Sum,this.totalAmount,this.products3});

  @override
  State<CartOrder> createState() => _CartOrderState();
}

class _CartOrderState extends State<CartOrder> {

    late  List<dynamic> show_promotions = [

];
late List<dynamic>? products2 = widget.products2;
late List<dynamic>? products3 = widget.products3;
  // late Map<String,dynamic>? show_deliveryss =null;
  int Sumdelivery = 0;
  late Map<String,dynamic>? show_promotionss =null;
  late Map<String,dynamic>? show_addressss =null;
   late Map<String,dynamic>? channelCode =null;
   late  List<dynamic> T = [];
     late  List<dynamic> T2 = [];
   String? TN = '00:00';
    String? TN_2 = '';
    int? show_addressint = -1;
   String? gram = '';
 bool loading = true;
 Future<void> calculate_gram() async {
    try {
      setState(() {
        loading = true;
    
      });
            List<int> id_cart2 = [];
  for (var product in products2!) {
     if (product['NO'] == true) {
          id_cart2.add(product['id_cart']);
        }
  }

       late String result = id_cart2.join(',');
      var uri = Uri.parse('${MyConstant().domain}/calculate_gram');
       var ressum = await http.post(uri,body: {
         'id':result.toString()
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         print(lnformation);
         gram  =lnformation['total_gram'].toString();
        show_promotion();
            
 
          // แก้ไขค่า amount ที่เป็น null เป็น 1
 

         
        });
          // data_promotion_stores();
    }else {
    show_promotion();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }

Future<void> show_promotion() async {
    try {
      setState(() {
        loading = true;
      });
      var uri = Uri.parse('${MyConstant().domain}/show_promotion');
       var ressum = await http.get(uri
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         print(lnformation);
         show_promotions  =lnformation['data']['data'];
        show_address();
            
 
          // แก้ไขค่า amount ที่เป็น null เป็น 1
 

         
        });
          // data_promotion_stores();
    }else {
     show_address();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


  late  List<dynamic> show_deliverys = [];
  Future<void> show_delivery() async {
    try {
      setState(() {
        loading = true;
        Sumdelivery = 0;
      });
      var uri = Uri.parse('${MyConstant().domain}/show_delivery');
       var ressum = await http.post(uri,
       body: {
         'gram':'$gram',
         'provice':'${show_addressss!['province']}'
       }
            );
           print('lnformation===>${ressum.statusCode}');       
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
        //  print(lnformation);
         show_deliverys  =lnformation['data']['data'];
        late int? show_deliverysss = lnformation['data']['rate']['price_out'];
        print(show_deliverysss);

          for (var category in show_deliverys) {
            if(category['name'].toString() == 'รับหน้าร้าน'){
                category["price"] = '0';
            }else{
                category["price"] = '${show_deliverysss}';
            }
                  
            } 
           for(var products in products3!){
               print('$products');
              if(products['name'].toString() == 'สินค้าพรีออเดอร์'){
                print('object22222');
            for(int i = 0;i<show_deliverys.length;i++){
               if(show_deliverys[i]['name'] == 'พรีออเดอร์'){
                  products['show_delivery']  =  show_deliverys[i];
                   products['S3'] = show_deliverys[i]['id'];
                  Sumdelivery += show_deliverysss!;

               }
              
             
           
           }   }
           } 

           for(int i = 0;i<show_deliverys.length;i++){
               if(show_deliverys[i]['name'] == 'รับหน้าร้าน'){
                 DateTime now = DateTime.now();
                  // แปลงเวลาเริ่มต้นเป็นวินาที
int startTimeInSeconds = DateTime.parse("${now.year.toString().padLeft(4,'0')}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} " + show_deliverys[i]['time_start']).millisecondsSinceEpoch ~/ 1000;

// แปลงเวลาสิ้นสุดเป็นวินาที
int endTimeInSeconds = DateTime.parse("${now.year.toString().padLeft(4,'0')}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} " + show_deliverys[i]['time_end']).millisecondsSinceEpoch ~/ 1000;
 
print(startTimeInSeconds);  
print(endTimeInSeconds);  
 // เพิ่มเวลาที่ละ interval นาทีจนกว่าจะถึงเวลาสิ้นสุด
for (int f = startTimeInSeconds; f <= endTimeInSeconds; f += int.parse(show_deliverys[i]['time'].toString()) * 60) {
  DateTime currentTime = DateTime.fromMillisecondsSinceEpoch(f * 1000);
  String formattedTime = currentTime.toIso8601String().substring(11, 16); // เลือกเฉพาะช่วงเวลา (hh:mm)
  T.add(formattedTime);
}
               }
           
             
           
           }
          //  T2 = [];
            for(int i = 0;i<show_deliverys.length;i++){
               if(show_deliverys[i]['name'] == 'พรีออเดอร์'){
                 if(show_deliverys[i]['lenght_1'].toString() != 'null'){
                    T2.add(show_deliverys[i]['lenght_1'].toString());             
                 }
                  if(show_deliverys[i]['lenght_2'].toString() != 'null'){
                    T2.add(show_deliverys[i]['lenght_2'].toString());
                     for(var products in products3!){
                          if(products['name'].toString() == 'สินค้าพรีออเดอร์'){
                    TN_2 =  show_deliverys[i]['lenght_2'].toString();    
                    }
                     }     
                   
                        
                 }
                  if(show_deliverys[i]['lenght_3'].toString() != 'null'){
                    T2.add(show_deliverys[i]['lenght_3'].toString());             
                 }
               }
            }
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

  String? id_warehousecode = '';
  String? name_warehousecode = '';
  late  List<dynamic> show_addresss = [];
  Future<void> show_address() async {
    try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        loading = true;
        id_warehousecode = preferences.getString('id_warehousecode').toString();
         name_warehousecode = preferences.getString('name_warehousecode').toString();
      });
       String user_id = preferences.getString('id').toString();
     
      var uri = Uri.parse('${MyConstant().domain}/show_address');
       var ressum = await http.post(uri,
       body: {
         'id_user': user_id
       }
            );
          // print('lnformation===>');     
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
        
         show_addresss  =lnformation['data']['data'];
         for(int i = 0;i< show_addresss.length;i++){
           if(show_addresss[i]['status'] == 'active'){
             show_addressss = show_addresss[i];
             show_addressint =  show_addresss[i]['id'];
           }
         }
          show_tax_address();
                 
 
       
         
        });
          // data_promotion_stores();
    }else {
         show_tax_address();
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


    late  List<dynamic> show_tax_addresss = [];
    late  Map<String, dynamic>? show_tax_addressss = null;
    late  int? show_tax_addresssint = -1;
  Future<void> show_tax_address() async {
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
          // print('lnformation===>');     
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
        
         show_tax_addresss  =lnformation['data']['data'];
         for(int i = 0;i< show_tax_addresss.length;i++){
          //  if(show_tax_addresss[i]['status'] == 'active'){
          //   //  show_tax_addressss = show_addresss[i];
          //   //  show_tax_addresssint =  show_addresss[i]['id'];
          //  }
         }
          show_delivery();
                 
 
       
         
        });
          // data_promotion_stores();
    }else {
         show_delivery();
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
    calculate_gram();
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
                              'สั่งซื้อ',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 16,
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
             child: Row(
               children: [
                 Expanded(child: Container(
                   child: Row(
                     children: [
                        Container(
                                                        
                                decoration: BoxDecoration(
                                             color: Color(0xffBA1F23),
                                             shape: BoxShape.circle,
                                           ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                     height: 25,
                                    width: 25,
                                    child: Image.asset(
                                          'assets/images/Rectangle 127.png',
                                        ),
                                  ),
                                ),
                                                         ),
                       Expanded(child: Container(
                         margin: EdgeInsets.only(left: 5),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                               Container(
                            child: Text(
                              'ที่อยู่',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: Color(0xff1E1E1E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        show_addressss == null ? Container()
                        :   Container(
                            child: Text(
                              '${show_addressss!['address']}  ${show_addressss!['streetAddress']}  ${show_addressss!['subdistrict']}  ${show_addressss!['district']}  ${show_addressss!['province']} ${show_addressss!['postcode']}',
                              textScaleFactor: 1.0,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(0xff979696),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                           ],
                         ),
                       )),
                     ],
                   ),
                 )),
                 GestureDetector(
                   onTap: () {
                     showModalBottomSheet(
                               barrierColor: Colors.red.withOpacity(0.31),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(50.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (ctx) => _buildBottomSheet4(
                                      ctx));
                   },
                   child: Container(
                                             margin: EdgeInsets.only(left: 10),
                                             child: Image.asset('assets/images/Rectangle 96.png',
                                             height: 18,),
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
              ListView.builder(
                                             physics: BouncingScrollPhysics(),
                                            //  scrollDirection: Axis.horizontal,
                                                                    shrinkWrap: true,
                                                                    itemCount: products3!.length,
                                           itemBuilder: (context, index1)  {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                            child: ListView.builder(
                                                       physics: BouncingScrollPhysics(),
                                                      //  scrollDirection: Axis.horizontal,
                                                                              shrinkWrap: true,
                                                                              itemCount: products3![index1]['data'].length,
                                                     itemBuilder: (context, index)  {
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                                                          // color: Colors.amber,
                                                                         child: Row(
                                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                           children: [
                                                                            Expanded(
                                                                               child: Row(
                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                            children: [
                                                                                                                             Container(
                                                                                                                                margin: EdgeInsets.only(left: 10),
                                                                                                                                child: Image.network(
                                                                                                                    '${MyConstant().domain2}/${products3![index1]['data'][index]['image_path']}',
                                                                                                                                height: 70,),
                                                                                                                              ),
                                                                                                                          
                                                                                                                           Expanded(
                                                                                                                             child: Container(
                                                                                                                                 //  color: Colors.red,
                                                                                                                                    margin: EdgeInsets.only(left: 10),
                                                                                                                                    child: Column(
                                                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                      children: [
                                                                                                                                       Container(
                                                                                                                                child: Text('${products3![index1]['data'][index]['product_type']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                                                                                              ),
                                                                                                                                       Container(
                                                                                                                                child: Text('ตัวเลือก : ${products3![index1]['data'][index]['product_name']},${products3![index1]['data'][index]['size_name']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffAFAFAF), fontSize: 12,fontWeight: FontWeight.w500),),
                                                                                                                              ),
                                                                                                                                       Row(
                                                                                                                                         children: [
                                                                                                                                    Text('${products3![index1]['data'][index]['price']} ฿',textScaleFactor: 1.0,style: TextStyle(
                                                                                                                     // fontFamily: 'IBM',
                                                                                                                           decoration: TextDecoration.lineThrough,
                                                                                                                           decorationColor: Color(0xFF989898),
                                                                                                                     fontSize: 15,
                                                                                                                     fontWeight: FontWeight.w400,
                                                                                                                     color: Color(0xff979696),
                                                                                                                   ),), 
                                                                                                                                         '${products3![index1]['data'][index]["rateprice"].toString()}'== '0'  ? Container(
                                                                                                                                child: Text(' ${products3![index1]['data'][index]['sale_price']} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 17,fontWeight: FontWeight.w600),),
                                                                                                                                
                                                                                                                              )
                                                                                                                                         :  Container(
                                                                                                                                child: Text(' ${products3![index1]['data'][index]['rateprice']} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 17,fontWeight: FontWeight.w600),),
                                                                                                                                
                                                                                                                              ),
                                                                                                                                         ],
                                                                                                                                       ),
                                                                                                                                     
                                                                                                                      
                                                                                                                    
                                                                                                                   
                                                                                                                                    ],)
                                                                                                                                  ),
                                                                                                                           ),
                                                                                                                            
                                                                                                                            ],
                                                                                                                          ),
                                                                             ),
                                                        Container(
                                                           child: Text('${products3![index1]['data'][index]['amount']} ตัว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 16,fontWeight: FontWeight.w600),),
                                                       )
                                                                           ],
                                                                         ),
                                                                        ),
                               );
                             }
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                                             child: Text('ตัวเลือกการจัดส่ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                           ),
                                  GestureDetector(
                                    onTap: () {
                                          showModalBottomSheet(
                                            barrierColor: Colors.red.withOpacity(0.31),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(50.0),
                                              ),
                                            ),
                                            context: context,
                                            builder: (ctx) => _buildBottomSheet3(
                                                ctx,index1));
                                        },
                                    child: Container(
                                                               margin: EdgeInsets.only(left: 10),
                                                               child: Image.asset('assets/images/Rectangle 96.png',
                                                               height: 20,),
                                                             ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        products3![index1]['show_delivery'] == null ? Container()
                        : Padding(
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
                                                                 child: Text('${products3![index1]['show_delivery']['name']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                               ),
                                          '${products3![index1]['show_delivery']['name']}'== 'รับหน้าร้าน' ? 
                                          Container(
                                                                 child: Text('จะมารับในวันที่ ${DateFormat('dd/MM/yyyy').format(dateTime1_!)} $TN น.',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                               )
                                          :Container(
                                                                 child: Text('${products3![index1]['show_delivery']['detail']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                               ),
                                      ]),
                                    ),
                                     Container(
                                                                 child: '${products3![index1]['show_delivery']['price']}' == 'null' ?Text('0 ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),) :Text('${products3![index1]['show_delivery']['price']} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
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
                      ],
                    ),
                  );
                }
              ), 
           Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Container(
                                                   margin: EdgeInsets.only(right: 5),
                                                   child: Image.asset('assets/images/Rectangle 148.png',
                                                   height: 20,),
                                                 ),
                            Container(
                                                       child: Text('ข้อมูลการชำระเงิน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                     ),
                          ],
                        ),
                       
                      ],
                    ),
                  ),
                ),
                Container(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                     Container(
                
                  child: Text('รวมการสั่งซื้อ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
               Container(
                
                  child: Text('${widget.Sum} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
              ),
                 ],
               ),
             ),
             ListView.builder(
                                             physics: BouncingScrollPhysics(),
                                            //  scrollDirection: Axis.horizontal,
                                                                    shrinkWrap: true,
                                                                    itemCount: products3!.length,
                                           itemBuilder: (context, index1)  {
                 return Container(
                   margin: EdgeInsets.only(top: 5),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                         Container(
                    
                      child: Text('การจัดส่ง (${index1+1})',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                  ),
                   Container(
                    
                      child:  products3![index1]['show_delivery'] == null ||'${products3![index1]['show_delivery']['price']}' == 'null'? Text('0 ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),) : Text('${products3![index1]['show_delivery']['price']} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
                  ),
                     ],
                   ),
                 );
               }
             )    ,

            show_promotionss == null? Container()
            : Container(
               margin: EdgeInsets.only(top: 5),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                     Container(
                
                  child: Text('คาส่วนลด',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
              Container(
                                                         child:show_promotionss!['discount_percent'] == null? Text('${show_promotionss!['discount_bath']} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),) :
                                                         Text('${(int.parse('${show_promotionss!['discount_percent']}')/100) * int.parse('${widget.Sum}')} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
                                                       ),
              //  Container(
                
              //     child: '${show_deliveryss!['price']}' == 'null'? Text('0 ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),) : Text('${show_deliveryss!['price']} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
              // ),
                 ],
               ),
             )  ,
             Container(
                 margin: EdgeInsets.only(top: 5),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                     Container(
                
                  child: Text('ยอดชำระเงินทั้งหมด',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
               Container(
                
                  child: show_promotionss == null? Text('${int.parse('${widget.Sum}')-Sumdelivery} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBD2325), fontSize: 16,fontWeight: FontWeight.w600),)
                  : show_promotionss!['discount_percent'] == null? Text('${int.parse('${widget.Sum}')-Sumdelivery-int.parse('${show_promotionss!['discount_bath']}')} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBD2325), fontSize: 16,fontWeight: FontWeight.w600),)
                  :Text('${int.parse('${widget.Sum}')-Sumdelivery-((int.parse('${show_promotionss!['discount_percent']}')/100) * int.parse('${widget.Sum}'))} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBD2325), fontSize: 16,fontWeight: FontWeight.w600),),
              ),
                 ],
               ),
             )    ,   
                 Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ), 
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                            Container(
                                                       child: Text('ใบกำกับภาษี',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                     ),
                        
                        Row(
                          children: [
                             Container(
                                                       child: Text('ขอใบกำกับภาษี',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                     ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                               barrierColor: Colors.red.withOpacity(0.31),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(50.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (ctx) => _buildBottomSheet2(
                                      ctx));
                              },
                              child: Container(
                                                         margin: EdgeInsets.only(left: 10),
                                                         child: Image.asset('assets/images/Rectangle 96.png',
                                                         height: 20,),
                                                       ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                show_tax_addressss == null ?  Container()
                :  Padding(
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
                                                         child: Text('${show_tax_addressss!['type_tax']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                       ),
                                 Container(
                                                         child: Text('${show_tax_addressss!['name_tax']} |  ${show_tax_addressss!['number_tax']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                       ),
                                   Container(
                                                         child: Text('${show_tax_addressss!['address_tax']}  ${show_tax_addressss!['streetAddress_tax']}  ${show_tax_addressss!['subdistrict_tax']}  ${show_tax_addressss!['district_tax']}  ${show_tax_addressss!['province_tax']} ${show_tax_addressss!['postcode_tax']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                       ),
                              ]),
                            ),
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Container(
                                                       child: Text('โค้ดส่วนลด',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                     ),
                          ],
                        ),
                      Row(
                          children: [
                             Container(
                                                       child:S2 == -1 ? Text('ใช้โค้ด',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),)
                                                       :  Container(
                                                         child:show_promotionss!['discount_percent'] == null? Text('ส่วนลด ${show_promotionss!['discount_bath']} บาท',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),) :
                                                         Text('ส่วนลด ${show_promotionss!['discount_percent']} %',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                       ),
                                                     ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                      barrierColor: Colors.red.withOpacity(0.31),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(50.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (ctx) => _buildBottomSheet(
                                      ctx));
                              },
                              child: Container(
                                                         margin: EdgeInsets.only(left: 10),
                                                         child: Image.asset('assets/images/Rectangle 96.png',
                                                         height: 20,),
                                                       ),
                            ),
                          ],
                        ),
                      ],
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
          Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Container(
                                                   margin: EdgeInsets.only(left: 0),
                                                   child: Image.asset('assets/images/Rectangle 149.png',
                                                   height: 20,),
                                                 ),
                            Container(
                                                       child: Text('ช่องทางการขำระเงิน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                     ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async{
                                   Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Payment_Channels() ),);
                                 if (navigationResult != null ) {
                                   setState(() {
                                      channelCode = navigationResult; 
                                   });
                                     
                                 }
                          },
                          child: Container(
                                                     margin: EdgeInsets.only(left: 10),
                                                     child: Image.asset('assets/images/Rectangle 96.png',
                                                     height: 20,),
                                                   ),
                        ),
                      ],
                    ),
                  ),
                ),
              channelCode == null  ? Container()
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                           
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Container(
                                                       child: Text('${channelCode!['name']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                     ),
                                 Container(
                                                       child: Text('${channelCode!['name1']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff9A9696), fontSize: 12,fontWeight: FontWeight.w400),),
                                                     ),
                            ]),
                          ),
                        
                        ],
                      ),
                    ),
                  ),
                ),
           Container(
                 alignment: Alignment.bottomRight,
                
                 child: InkWell(
                                   onTap: () async{
                                     createWo();
                                //       Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                //          builder: (_) =>CartOrder() ),);
                                //  if (navigationResult == null ) {
                                     
                                //  }
                                   },
                                   child: Container(
                                              width: screenW*0.3,
                                              decoration: BoxDecoration(
                                                color: Color(0xff000000),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
                                                child: Center(
                                                  child: Text(
                                                    'สั่งซื้อ',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      // fontFamily: 'IBM',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                 ),
               ), 
                
            ],)
          ),
        ),
      ),
    );
  }


  late int? S2 = -1;
    // late int? S3 = -1;
  StatefulBuilder _buildBottomSheet(
      BuildContext context) {
        
    // children: snapshot.data.docs.map((document){
   return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {

        return Container(
          height: screenH*0.7,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              // border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 4.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text('เลือกโค้ดส่วนลด',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
              
               Expanded(
                 child: Container(
                        child: ListView.builder(
                                                   physics: BouncingScrollPhysics(),
                                                  //  scrollDirection: Axis.horizontal,
                                                                          shrinkWrap: true,
                                                                          itemCount: show_promotions.length,
                                                 itemBuilder: (context, index)  {
                           return Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                                                                      // color: Colors.amber,
                                                                     child: Row(
                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                      Container(
                                                         margin: EdgeInsets.only(left: 10),
                                                         child: Image.network(
                                            '${MyConstant().domain2}/upload/promotion/${show_promotions[index]['path']}',
                                                         height: 70,),
                                                       ),
                                                   
                                                    Expanded(
                                                      child: Container(
                                                          //  color: Colors.red,
                                                             margin: EdgeInsets.only(left: 10),
                                                             child: Column(
                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                               children: [
                                                                Container(
                                                         child:show_promotions[index]['discount_percent'] == null? Text('ส่วนลด ${show_promotions[index]['discount_bath']} บาท',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),) :
                                                         Text('ส่วนลด ${show_promotions[index]['discount_percent']} %',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                       ),
                                                                Container(
                                                         child: Text('*ใช้ได้ถึง วันที่ ${DateFormat('dd/MM/yyyy').format(DateTime.parse(show_promotions[index]['end_date'].toString()))} ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 12,fontWeight: FontWeight.w500),),
                                                       ),
                                                            
                                                              
                                               
                                             
                                            
                                                             ],)
                                                           ),
                                                    ),
                                                        GestureDetector(
                                                        onTap: () {
                                                          setState1(() {
                                                            setState(() {
                                                            if(S2 == show_promotions[index]['id']){
                                                              S2 = -1;
                                                              show_promotionss = null;
                                                            }else{
                                                                show_promotionss = show_promotions[index];
                                                               S2 = show_promotions[index]['id'];
                                                            }
                                                            
                                                            print(S2);
                                                            // Navigator.pop(context);
                                                          }); });
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              left: 5),
                                                          child: S2 == show_promotions[index]['id']
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
                                                                    ),
                           );
                         }
                                     ),
                      ),
               ),
            ],
          ),
        );
      }
    );
  }

    late TextEditingController _name = TextEditingController();
     late TextEditingController _No = TextEditingController();
      late TextEditingController _address = TextEditingController();
       late TextEditingController _road = TextEditingController();
        late TextEditingController _province = TextEditingController();
         late TextEditingController _District = TextEditingController();
          late TextEditingController _district = TextEditingController();
           late TextEditingController _code = TextEditingController();
   StatefulBuilder _buildBottomSheet2(
      BuildContext context) {
        
    // children: snapshot.data.docs.map((document){
          int? show_tax_addresssint2 = -1;
          Map<String, dynamic>? show_tax_addressss2 = null;
         if(show_tax_addresssint == -1){
             for(int i = 0;i< show_tax_addresss.length;i++){
           if(show_tax_addresss[i]['tax_status'] == 'active'){
             show_tax_addresssint2 =  show_tax_addresss[i]['id'];
             show_tax_addressss2 =  show_tax_addresss[i];
             print('${show_tax_addresssint2} == ${show_tax_addresss[i]['id']}');
           }
         } 
         }else{
         show_tax_addresssint2 =  show_tax_addresssint;
          
         }
           
          
          
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
        return Container(
            height: screenH*0.7,
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
                // border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 4.0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('กรอกข้อมูลสำหรับออกใบกำกับภาษี',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                ),
                Expanded(
                       child: Container(
                              child: ListView.builder(
                                 //  physics: BouncingScrollPhysics(),
                                                        //  scrollDirection: Axis.horizontal,
                                                                                shrinkWrap: true,
                                                                                itemCount: show_tax_addresss.length,
                                                       itemBuilder: (context, index)  {
                                 return GestureDetector(
                                   onTap: () {
                                     
                                   },
                                   child: Padding(
                                                       padding: const EdgeInsets.only(top: 10),
                                                       child: Container(
                                                         width: screenW*1,
                                                         color:  show_tax_addresss[index]['status'] == 'active' ? Color(0xffEFEFEF):Color(0xffFFFFFF),
                                                         child: Padding(
                                                           padding: const EdgeInsets.all(20.0),
                                                           child: Row(
                                                             children: [
                                                               Expanded(
                                                                 child: Column(
                                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                 children: [
                                                                                                    Container(
                                                                                                           child: Text(
                                                                                                             '${show_tax_addresss[index]['type_tax']}',
                                                                                                             textScaleFactor: 1.0,
                                                                                                             style: TextStyle(
                                                                                                                 color: Color(0xff1E1E1E),
                                                                                                                 fontSize: 14,
                                                                                                                 fontWeight: FontWeight.w500),
                                                                                                           ),
                                                                                                         ),
                                                                                                    Container(
                                                                                                           child: Text(
                                                                                                             '${show_tax_addresss[index]['name_tax']} |  ${show_tax_addresss[index]['number_tax']}',
                                                                                                             textScaleFactor: 1.0,
                                                                                                             style: TextStyle(
                                                                                                                 color: Color(0xff1E1E1E),
                                                                                                                 fontSize: 14,
                                                                                                                 fontWeight: FontWeight.w500),
                                                                                                           ),
                                                                                                         ),
                                                                                                          Container(
                                                                                                           child: Text(
                                                                                                             '${show_tax_addresss[index]['address_tax']}  ${show_tax_addresss[index]['streetAddress_tax']}  ${show_tax_addresss[index]['subdistrict_tax']}  ${show_tax_addresss[index]['district_tax']}  ${show_tax_addresss[index]['province_tax']} ${show_tax_addresss[index]['postcode_tax']}',
                                                                                                             textScaleFactor: 1.0,
                                                                                                             style: TextStyle(
                                                                                                                 color: Color(0xff979696),
                                                                                                                 fontSize: 14,
                                                                                                                 fontWeight: FontWeight.w500),
                                                                                                           ),
                                                                                                         ),
                                                                                                         show_tax_addresss[index]['tax_status'] == 'active' ? Container(
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
                                                                GestureDetector(
                                                          onTap: ()async {
                                                          setState1(() {
                                     setState(() {
                                       
                                       if(show_tax_addresssint2 == show_tax_addresss[index]['id']){
                                                                           setState((){
                                                                              show_tax_addressss2 = null;
                                                                    show_tax_addresssint2 = -1;
                                                                           });
                                                                            
                                                                          }else{
                                                                              setState((){
                                                                                show_tax_addressss2 = show_tax_addresss[index];
                                                                     show_tax_addresssint2 = show_tax_addresss[index]['id'];
                                                                           });
                                                                            
                                                                          }
                                     }); });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                left: 5),
                                                            child: show_tax_addresssint2 == show_tax_addresss[index]['id']
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
                                                         ),
                                                       ),
                                                     ),
                                 );
                               }
                                           ),
                            ),
                     ),
                  Container(
                 alignment: Alignment.bottomRight,
                
                 child: InkWell(
                                   onTap: () async{
                                  setState(() {
                                    show_tax_addresssint =  show_tax_addresssint2;
                                    show_tax_addressss = show_tax_addressss2;
                                    Navigator.pop(context);
                                  });  
                                //       Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                //          builder: (_) =>CartOrder() ),);
                                //  if (navigationResult == null ) {
                                     
                                //  }
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(top: 10),
                                              width: screenW*0.3,
                                              decoration: BoxDecoration(
                                                color: Color(0xff000000),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                                                child: Center(
                                                  child: Text(
                                                    'ตกลง',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      // fontFamily: 'IBM',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                 ),
               ), 
  //                 TextButton(onPressed: ()async {
              
  //               var  navigationResult = await Navigator.push(context,MaterialPageRoute(
  //                                        builder: (_) =>APP_tax() ),);
  //                                if (navigationResult == null ) {
  //                                  show_tax_address();
  //                                }

  //           }, child: Container(
  //               decoration: BoxDecoration(
  //   color: Color(0xff000000),
  //  borderRadius: BorderRadius.circular(15),
  // ),
  //             margin: EdgeInsets.only(right: 5,left: 5),
  //             //  height: 60,
  //             //  width: 100,
  //             child: Center(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Container(
  //           margin: EdgeInsets.only(right: 5),
  //           child: Image.asset(
  //             'assets/images/icons8-add-100 1.png',
  //             height: 18,
  //           ),
  //         ), 
  //                     Text('เพิ่มใบกำกับภาษีใหม่', textScaleFactor: 1.0,
  //                             style: TextStyle(
                                
                        
  //                       fontSize: 12,
  //                       color: Color.fromARGB(255, 255, 255, 255)),
  //                           ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )),
              ],
            ),
      );
          }
        );
    
  }

 TextEditingController _dateController2  = TextEditingController();
   StatefulBuilder _buildBottomSheet3(
      BuildContext context,int index ) {
        Map<String, dynamic>? show_deliveryss2 = products3![index]['show_delivery'];
        int? S32 = products3![index]['S3'];
        String? TN2 = TN;
        String? TN_22 = TN_2;
        _dateController2.text = _dateController.text;
        print(show_deliveryss2);
        print(S32);
    // children: snapshot.data.docs.map((document){
      return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
        return Container(
          height: screenH*0.7,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              // border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 4.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text('ตัวเลือกในการจัดส่ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
              
               Expanded(
                 child: Container(
                   
                        child: ListView.builder(
                                                   physics: BouncingScrollPhysics(),
                                                  //  scrollDirection: Axis.horizontal,
                                                                          shrinkWrap: true,
                                                                          itemCount: show_deliverys.length,
                                                 itemBuilder: (context, index)  {
                   return show_deliverys[index]['name'] != 'รับหน้าร้าน' ? show_deliverys[index]['name'] == 'พรีออเดอร์'?
                   Container(
                      margin: EdgeInsets.only(top: 10),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             Expanded(
                               child: Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('${show_deliverys[index]['name']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                   ),
                             ),

                               Row(
                                 children: [
                                  Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('${show_deliverys[index]['price']} ฿',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                   ),
                                   GestureDetector(
                                                                onTap: () {
                                                                  setState1(() {
                                                                    if(S32 == show_deliverys[index]['id']){
                                                                     setState((){
                                                                         show_deliveryss2 = null;
                                                                      S32 = -1;
                                                                     });
                                                                      
                                                                    }else{
                                                                        setState((){
                                                                         show_deliveryss2 = show_deliverys[index];
                                                                       S32 = show_deliverys[index]['id'];
                                                                     });
                                                                      
                                                                    }
                                                                    print(show_deliveryss2);
                                                                  });
                                                                },
                                                                child: Container(
                                                                  margin: EdgeInsets.only(
                                                                      left: 5),
                                                                  child: S32 == show_deliverys[index]['id']
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
                               
                           ],
                         ),
                         Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('${show_deliverys[index]['detail']}',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Color(0xff9A9696)),),
                                   ),
                      Container(
                           margin: EdgeInsets.only(top: 10),
                           height: 40,
                           child: ListView.builder(
                                                     physics: BouncingScrollPhysics(),
                                                     scrollDirection: Axis.horizontal,
                                                                            shrinkWrap: true,
                                                                            itemCount: T2.length,
                                                   itemBuilder: (context, index1)  {
                                return GestureDetector(
                                  onTap: () {
                                      setState1(() {
                                         setState(() {
                                                            if(TN_22 ==  T2[index1].toString()){
                                                              
                                                              TN_22 = '';
                                                            }else{
                                                               TN_22 = T2[index1].toString();
                                                            }
                                                            
                                                            // print(TN);
                                                            // Navigator.pop(context);
                                                          });});
                                  },
                                  child: Container(
                                                        margin: EdgeInsets.only(right: 10),
                                                        decoration: BoxDecoration(
                                                          color:  TN_22 == T2[index1].toString() ? Color(0xffFAAB35):Color.fromARGB(255, 255, 255, 255) ,
                                                          border: Border.all(
                                                        color: TN_22 == T2[index1].toString() ? Color(0xffFAAB35):Color(0xffFAAB35) ,
                                                        width: 1),
                                                          borderRadius:
                                                              BorderRadius.circular(50),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                                          child: Center(
                                                            child: Text(
                                                              '${T2[index1]}',
                                                              textScaleFactor: 1.0,
                                                              style: TextStyle(
                                                                // fontFamily: 'IBM',
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w600,
                                                                color:  TN_22 == T2[index1].toString() ? Color.fromARGB(255, 255, 255, 255):Color(0xffFAAB35)
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                );
                              }
                            ),
                         ),
                    
                       ],
                     ),
                   )
                  : Container(
                      margin: EdgeInsets.only(top: 10),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             Expanded(
                               child: Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('${show_deliverys[index]['name']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                   ),
                             ),

                               Row(
                                 children: [
                                  Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('${show_deliverys[index]['price']} ฿',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                   ),
                                   GestureDetector(
                                                                onTap: () {
                                                                  setState1(() {
                                                                    if(S32 == show_deliverys[index]['id']){
                                                                     setState((){
                                                                         show_deliveryss2 = null;
                                                                      S32 = -1;
                                                                     });
                                                                      
                                                                    }else{
                                                                        setState((){
                                                                         show_deliveryss2 = show_deliverys[index];
                                                                       S32 = show_deliverys[index]['id'];
                                                                     });
                                                                      
                                                                    }
                                                                    print(show_deliveryss2);
                                                                  });
                                                                },
                                                                child: Container(
                                                                  margin: EdgeInsets.only(
                                                                      left: 5),
                                                                  child: S32 == show_deliverys[index]['id']
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
                               
                           ],
                         ),
                         Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('${show_deliverys[index]['detail']}',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Color(0xff9A9696)),),
                                   ),
                      
                     id_warehousecode.toString() != '${show_deliverys[index]['id']}' ?
                       show_deliverys[index]['name'] == 'พรีออเดอร์' ? Container()
                       :Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('*ปัจจุบันอยู่ สถานะ $name_warehousecode ถ้ากดตกลงจะหลับหน้าหลัก และ รีเซ็ต',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.red),),
                                   ):Container(),
                       ],
                     ),
                   )
                   :Container(
                      margin: EdgeInsets.only(top: 10),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                     Row(
                       children: [
                         Expanded(
                           child: Container(
                                //  margin: EdgeInsets.only(top: 10),
                                 child: Text('${show_deliverys[index]['name']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                               ),
                         ),

                           GestureDetector(
                                                        onTap: ()async {
                                                          setState1(() {
                                                             if(S32 == show_deliverys[index]['id']){
                                                                     setState((){
                                                                        show_deliveryss2 = null;
                                                              S32 = -1;
                                                                     });
                                                                      
                                                                    }else{
                                                                        setState((){
                                                                          show_deliveryss2 = show_deliverys[index];
                                                               S32 = show_deliverys[index]['id'];
                                                                     });
                                                                      
                                                                    }
                                                           
                                                            
                                                            print(show_deliveryss2);
                                                            // Navigator.pop(context);
                                                          });
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              left: 5),
                                                          child: S32 == show_deliverys[index]['id']
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
                      id_warehousecode.toString() != '${show_deliverys[index]['id']}' ?
                         show_deliverys[index]['name'] == 'พรีออเดอร์' ? Container()
                       :Container(
                                    //  margin: EdgeInsets.only(top: 10),
                                     child: Text('*ปัจจุบันอยู่ สถานะ $name_warehousecode',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.red),),
                                   ):Container(),
                         Container(
                           margin: EdgeInsets.only(top: 10),
                           child: Text('วันที่',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                         ),
                          Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        onTap: () {
                          chooseDate1();
                        },
                        readOnly: true,
                        controller: _dateController2,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'วันเดือนปี',
                          // labelStyle: b2,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        ),
                      ),
                    ),
                     Container(
                           margin: EdgeInsets.only(top: 10),
                           child: Text('เวลา',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                         ),

                  
                         Container(
                           margin: EdgeInsets.only(top: 10),
                           height: 40,
                           child: ListView.builder(
                                                     physics: BouncingScrollPhysics(),
                                                     scrollDirection: Axis.horizontal,
                                                                            shrinkWrap: true,
                                                                            itemCount: T.length,
                                                   itemBuilder: (context, index1)  {
                                return GestureDetector(
                                  onTap: () {
                                      setState1(() {
                                         setState(() {
                                                            if(TN2 ==  T[index1].toString()){
                                                              
                                                              TN2 = '00:00';
                                                            }else{
                                                               TN2 = T[index1].toString();
                                                            }
                                                            
                                                            // print(TN);
                                                            // Navigator.pop(context);
                                                          });});
                                  },
                                  child: Container(
                                                        margin: EdgeInsets.only(right: 10),
                                                        decoration: BoxDecoration(
                                                          color:  TN2 == T[index1].toString() ? Color(0xffFAAB35):Color.fromARGB(255, 255, 255, 255) ,
                                                          border: Border.all(
                                                        color: TN2 == T[index1].toString() ? Color(0xffFAAB35):Color(0xffFAAB35) ,
                                                        width: 1),
                                                          borderRadius:
                                                              BorderRadius.circular(50),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                                          child: Center(
                                                            child: Text(
                                                              '${T[index1]}',
                                                              textScaleFactor: 1.0,
                                                              style: TextStyle(
                                                                // fontFamily: 'IBM',
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w600,
                                                                color:  TN2 == T[index1].toString() ? Color.fromARGB(255, 255, 255, 255):Color(0xffFAAB35)
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                );
                              }
                            ),
                         ),
                                               
                     
                     ]),
                   );
                 }
               ))),
                Container(
                 alignment: Alignment.bottomRight,
                
                 child: InkWell(
                                   onTap: () async{
                                  setState(() {
                                    if(id_warehousecode.toString() == '${S32}'||'${S32}' == '3'){
                                      Sumdelivery = 0;
                                    products3![index]['show_delivery'] =  show_deliveryss2;
                                    products3![index]['S3'] = S32;
                                    if(products3![index]['show_delivery']['name'] == 'รับหน้าร้าน'){
                                      TN = TN2;
                                      _dateController.text = _dateController2.text;
                                    }
                                     if(products3![index]['show_delivery']['name'] == 'พรีออเดอร์'){
                                      TN_2 = TN_22;
                                      
                                    }

                                    for(var i in products3!){
                                        if(i['show_delivery'].toString() != 'null'){
                                          if('${i['show_delivery']['price']}' == '0'){
                                           Sumdelivery += 0;
                                          }
                                         else{
                                           Sumdelivery += int.parse('${i['show_delivery']['price'].toString()}');
                                        } 
                                    }
                                    }
                                    print('Sumdelivery===$Sumdelivery');
                                    Navigator.pop(context);
                                      // check_product();
                                    }else{
                                      id_warehousecode = S32.toString();
                                       check_product();
                                    }
                                   
                                  });  
                                //       Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                //          builder: (_) =>CartOrder() ),);
                                //  if (navigationResult == null ) {
                                     
                                //  }
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(top: 10),
                                              width: screenW*0.3,
                                              decoration: BoxDecoration(
                                                color: Color(0xff000000),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                                                child: Center(
                                                  child: Text(
                                                    'ตกลง',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      // fontFamily: 'IBM',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                 ),
               ), 
            ],
          ),
        );
      }
    );
  }
    late TextEditingController _dateController = TextEditingController();



 StatefulBuilder _buildBottomSheet4(
      BuildContext context) {
               int? show_addressint2 = show_addressint;
           Map<String, dynamic>? show_addressss2 = show_addressss;
    // children: snapshot.data.docs.map((document){
   return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState1) {
      
        return Container(
          height: screenH*0.7,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              // border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 4.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text('เลือกเลือกที่อยู่จัดส่ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
              
               Expanded(
                 child: Row(
                   children: [
                     
                     Expanded(
                       child: Container(
                              child: ListView.builder(
                                 //  physics: BouncingScrollPhysics(),
                                                        //  scrollDirection: Axis.horizontal,
                                                                                shrinkWrap: true,
                                                                                itemCount: show_addresss.length,
                                                       itemBuilder: (context, index)  {
                                 return GestureDetector(
                                   onTap: () {
                                     
                                   },
                                   child: Padding(
                                                       padding: const EdgeInsets.only(top: 10),
                                                       child: Container(
                                                         width: screenW*1,
                                                         color:  show_addresss[index]['status'] == 'active' ? Color(0xffEFEFEF):Color(0xffFFFFFF),
                                                         child: Padding(
                                                           padding: const EdgeInsets.all(20.0),
                                                           child: Row(
                                                             children: [
                                                               Expanded(
                                                                 child: Column(
                                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                 children: [
                                                                                                    Container(
                                                                                                           child: Text(
                                                                                                             '${show_addresss[index]['name']} |  ${show_addresss[index]['phone']}',
                                                                                                             textScaleFactor: 1.0,
                                                                                                             style: TextStyle(
                                                                                                                 color: Color(0xff1E1E1E),
                                                                                                                 fontSize: 14,
                                                                                                                 fontWeight: FontWeight.w500),
                                                                                                           ),
                                                                                                         ),
                                                                                                          Container(
                                                                                                           child: Text(
                                                                                                             '${show_addresss[index]['address']} ถนน ${show_addresss[index]['streetAddress']} แขวง ${show_addresss[index]['subdistrict']} เขต ${show_addresss[index]['district']} จังหวัด ${show_addresss[index]['province']} ${show_addresss[index]['postcode']}',
                                                                                                             textScaleFactor: 1.0,
                                                                                                             style: TextStyle(
                                                                                                                 color: Color(0xff979696),
                                                                                                                 fontSize: 14,
                                                                                                                 fontWeight: FontWeight.w500),
                                                                                                           ),
                                                                                                         ),
                                                                                                         show_addresss[index]['status'] == 'active' ? Container(
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
                                                                GestureDetector(
                                                          onTap: ()async {
                                                          setState1(() {
                                     setState(() {
                                       if(show_addressint2 == show_addresss[index]['id']){
                                                                    //        setState((){
                                                                    //           show_addressss = null;
                                                                    // show_addressint = -1;
                                                                    //        });
                                                                            
                                                                          }else{
                                                                            // print(show_addresss[index]);
                                                                              setState((){
                                                                                show_addressss2 = show_addresss[index];
                                                                     show_addressint2 = show_addresss[index]['id'];
                                                                      print('show_addressss2  ==> ${show_addressss2}');
                                                                      print('show_addressss2  ==> ${show_addressint2}');
                                                                      print('show_addressss2  ==> ${show_addressint2} == ${show_addresss[index]['id']}');
                                                                           });
                                                                            
                                                                          }
                                     }); });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                left: 5),
                                                            child: show_addressint2 == show_addresss[index]['id']
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
                 Container(
                 alignment: Alignment.bottomRight,
                
                 child: InkWell(
                                   onTap: () async{
                                  setState(() {
                                    show_addressint =  show_addressint2;
                                    show_addressss =  show_addressss2;
                                    Navigator.pop(context);
                                  });  
                                //       Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                //          builder: (_) =>CartOrder() ),);
                                //  if (navigationResult == null ) {
                                     
                                //  }
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(top: 10),
                                              width: screenW*0.3,
                                              decoration: BoxDecoration(
                                                color: Color(0xff000000),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                                                child: Center(
                                                  child: Text(
                                                    'ตกลง',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      // fontFamily: 'IBM',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                 ),
               ), 
  //               TextButton(onPressed: ()async {
              
  //               var  navigationResult = await Navigator.push(context,MaterialPageRoute(
  //                                        builder: (_) =>APP_address() ),);
  //                                if (navigationResult == null ) {
  //                                   show_address();
  //                                   Navigator.pop(context);
  //                                }

  //           }, child: Container(
  //               decoration: BoxDecoration(
  //   color: Color(0xff000000),
  //  borderRadius: BorderRadius.circular(15),
  // ),
  //             margin: EdgeInsets.only(right: 5,left: 5),
  //             //  height: 60,
  //             //  width: 100,
  //             child: Center(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Container(
  //           margin: EdgeInsets.only(right: 5),
  //           child: Image.asset(
  //             'assets/images/icons8-add-100 1.png',
  //             height: 18,
  //           ),
  //         ), 
  //                     Text('เพิ่มที่อยู่ใหม่', textScaleFactor: 1.0,
  //                             style: TextStyle(
                                
                        
  //                       fontSize: 12,
  //                       color: Color.fromARGB(255, 255, 255, 255)),
  //                           ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )),
            ],
          ),
        );
      }
    );
  }


  
 DateTime? dateTime1_ = DateTime.now();
  Future<void> chooseDate1() async {
    DateTime? ChooseDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1000),
      lastDate: DateTime(DateTime.now().year + 10),
      initialDate: dateTime1_!,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff44bca3),
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 0, 0, 0),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (ChooseDateTime != null) {
      setState(() {
        dateTime1_ = ChooseDateTime;
        _dateController2.text =
            '${dateTime1_!.year}-${dateTime1_!.month}-${dateTime1_!.day}';
      });
    }
  }


 Future createWo() async {
    try {
       
      
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
       String id_warehousecode = preferences.getString('id_warehousecode').toString();
      var url = Uri.parse('${MyConstant().domain}/order');
      EasyLoading.show(status: 'กำลังบันทึกข้อมูล');
      
         List<int> falseNOProductIds = [];
  for (var product0 in products3!) {        
  for (var product in product0['data']!) {
     if (product['NO'] == true) {
          falseNOProductIds.add(product['cart_id_product_amount']);
        }
  }}

String result = falseNOProductIds.join(',');


   List<int> falseNOProductIds2 = [];
   int falseNOProductIdsint = 0;
    for (var product0 in products3!) {        
  for (var product in product0['data']!) {
     if (product['NO'] == true) {
       print('sumprice ===> ${int.parse(product['sumprice'].toString())}');
          falseNOProductIds2.add(product['amount']);
          falseNOProductIdsint += int.parse(product['amount'].toString());
        }
  }}

String result2 = falseNOProductIds2.join(',');


   List<int> falseNOProductIds3= [];
    for (var product0 in products3!) {    
  for (var product in product0['data']!) {
     if (product['NO'] == true) {
          print('sumprice ===> ${int.parse(product['sumprice'].toString())}');
          falseNOProductIds3.add(int.parse(product['sumprice'].toString()));
        }
  }}

String result3 = falseNOProductIds3.join(',');


 List<dynamic> falseNOProductIds4= [];
      
   for (var product0 in products3!) {        
  for (var product in product0['data']!) {
     if (product['NO'] == true) {
          falseNOProductIds4.add(product['id_cart'].toString());
        }
  }}

String result4 = falseNOProductIds4.join(',');


List<dynamic> falseNOProductIds5= [];
      
  for (var product0 in products3!) {        
  for (var product in product0['data']!) {
     if (product['NO'] == true) {
          falseNOProductIds5.add(product['rateprice'].toString());
        }
  }}

String result5 = falseNOProductIds5.join(',');


List<dynamic> falseNOProductIds6= [];
      
  for (var product in products3!) {
     
          falseNOProductIds6.add(product['S3']);
        
  }

String result6 = falseNOProductIds6.join(',');

List<dynamic> falseNOProductIds7= [];
      
  for (var product in products3!) {
     if(product['show_delivery']['price'].toString() == 'null'){
           falseNOProductIds7.add(0.toString());
     }else{
        falseNOProductIds7.add(product['show_delivery']['price'].toString());
     }
         
        
  }

String result7 = falseNOProductIds7.join(',');
      var response = await http.MultipartRequest('POST', url);
      print('user_id  ${user_id}');
      print('id_address  ${show_addressss!['id']}');
      print('price  ${widget.Sum}');
      print('id_delivery  ${result6}');
      print('id_warehousecode  $id_warehousecode');
      print('id_promotion  ${S2}');
          for(var i in products3!){
           if(i['show_delivery'] != null){
             if(i['show_delivery']['name'] == "รับหน้าร้าน"){
                print('123456789 ==>${_dateController.text}');
                  print('123456789 ==>${TN}');
         
             }   
           }
          }       
            
      // print('time_preorder  ${show_deliveryss!['name']}');
      print('id_product_amount  ${result}');

       print('amount  ${result2}');
        print('total_amount  ${falseNOProductIdsint}');
      print('price_detail  ${result3}');


      print('shippingamount  ${show_promotionss == null
          ?'${int.parse('${widget.Sum}')-Sumdelivery}' 
          : show_promotionss!['discount_percent'] == null? '${int.parse('${widget.Sum}')-Sumdelivery-int.parse('${show_promotionss!['discount_bath']}')}'
          :'${int.parse('${widget.Sum}')-Sumdelivery-((int.parse('${show_promotionss!['discount_percent']}')/100) * int.parse('${widget.Sum}'))}'}');

       print('id_cart  ${result4}');
      print('rate_amount  ${widget.totalAmount}');
      print('rate_product  ${result5}');
      response.fields['id_user'] =  user_id;
      response.fields['channelCode'] =  '${channelCode!['Code']}';
      response.fields['bank'] =  '${channelCode!['name1']}';
      response.fields['id_address'] =  '${show_addressss!['id']}';
       response.fields['id_tax'] =  show_tax_addressss== null?'':'${show_tax_addressss!['id']}';

        response.fields['price'] =  '${widget.Sum}';
           response.fields['id_delivery'] =  '$result6';
        
      
    //  response.fields['paymentmethod'] =  User!['username'];
      response.fields['id_warehousecode'] =  '$id_warehousecode';
       response.fields['id_promotion'] =  S2 == -1 ?'' : '$S2';
         for(var i in products3!){
           if(i['show_delivery'] != null){
             if(i['show_delivery']['name'] == "รับหน้าร้าน"){
               response.fields['date_preorder'] = _dateController.text;
           response.fields['time_preorder'] =  '$TN';
             }   
           }
          }   
        // response.fields['date_preorder'] = '${show_deliveryss!['name']}'== 'รับหน้าร้าน'? _dateController.text  : '';
        //    response.fields['time_preorder'] =  '${show_deliveryss!['name']}'== 'รับหน้าร้าน'? '$TN' : '';
      
      response.fields['id_product_amount'] = '$result';
           response.fields['amount'] =  '$result2';
           response.fields['total_amount'] =  '$falseNOProductIdsint';
          
            response.fields['price_detail'] =  '$result3';
            

           response.fields['rate_shipping'] =  '$result7';
           
          response.fields['shippingamount'] = show_promotionss == null
          ?'${int.parse('${widget.Sum}')-Sumdelivery}' 
          : show_promotionss!['discount_percent'] == null? '${int.parse('${widget.Sum}')-Sumdelivery-int.parse('${show_promotionss!['discount_bath']}')}'
          :'${int.parse('${widget.Sum}')-Sumdelivery-((int.parse('${show_promotionss!['discount_percent']}')/100) * int.parse('${widget.Sum}'))}';
            
            response.fields['id_cart'] =  '$result4';
              response.fields['rate_amount'] =  '${widget.totalAmount}';
                response.fields['rate_product'] =  '$result5';
            
 
      var res = await response.send();
      var response0 = await http.Response.fromStream(res);

      print(res.statusCode);
      // print(jsonDecode(response!.body));
      if (res.statusCode == 200) {
          var  lnformation  = jsonDecode(response0.body)['data'];
          var  lnformation2  = jsonDecode(response0.body)['message'];
        EasyLoading.showSuccess('$lnformation2').then((value)async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
       preferences.setString('id_order', lnformation.toString());
          // generatePament(lnformation,'127.01.01');
           MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => CartOrder2(index:'1'),);
        Navigator.push(context, route);
          //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          //                builder: (context)=>    Menu(),), (route) => false);
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



  // เลือกการชำระเงิน
    Future<void> check_product() async {
    try {
    List<dynamic> falseNOProductIds4= [];
      
   for (var product0 in products3!) {        
  for (var product in product0['data']!) {
     if (product['NO'] == true) {
          falseNOProductIds4.add(product['id_cart'].toString());
        }
  }}

String result4 = falseNOProductIds4.join(',');

      List<int> falseNOProductIds = [];
  for (var product0 in products3!) {        
  for (var product in product0['data']!) {
     if (product['NO'] == true) {
          falseNOProductIds.add(product['cart_id_product_amount']);
        }
  }}

String result = falseNOProductIds.join(',');

List<dynamic> falseNOProductIds6= [];
      
  for (var product in products3!) {
     
          falseNOProductIds6.add(product['S3']);
        
  }

String result6 = falseNOProductIds6.join(',');
   SharedPreferences preferences = await SharedPreferences.getInstance();
     
      var uri = Uri.parse('${MyConstant().domain}/check_product');
      var ressum;
      
            ressum = await http.post(uri,body: {
         'id_delivery': '$result6',
         'id_product_amount': '$result',
         'id_cart': '$result4',
    
      }
            );
      
    
      
       print('ressum==>${ressum.statusCode}');
      if(ressum.statusCode == 200){
     


    show_warehouse();
    //         Navigator.pushReplacement(context, MaterialPageRoute(
    // builder: (context)=> CartOrder2(Url: '${valueMap1!['PaymentUrl']}',id:'$id'),));
      print('successfully');
      }
    } catch (e) {
      print('e ===> ${e.toString()} ');
    }
  }
late  List<dynamic> show_warehouses = [];
Future<void> show_warehouse() async {
    try {
    
      var uri = Uri.parse('${MyConstant().domain}/show_warehouse');
       var ressum = await http.get(uri,
     
            );
               
      if(ressum.statusCode == 200) {
        var lnformation = jsonDecode(ressum.body);
        setState(() {
          show_warehouses = lnformation['data']['data'] ; 
           for (var warehouses in show_warehouses) {
             if(warehouses['id'].toString() == id_warehousecode){
                routToService(warehouses['id'].toString(),warehouses['name'].toString());
             }else{
                
             }
                 
            } 

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
                         builder: (context)=>    Menu(),), (route) => false);
  //  MaterialPageRoute route =
  //       MaterialPageRoute(builder: (context) => Menu(Data_User:Data_User,index: 0,));
  //   Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

}
