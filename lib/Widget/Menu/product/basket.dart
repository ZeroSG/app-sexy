import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CartOrder.dart';
import '../../../my_constant.dart';
 import 'package:http/http.dart' as http;



class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
    late TextEditingController _Rate = TextEditingController();
    late  List<dynamic> imgList = [

];
late bool S2 = false;
 bool loading = true;
  late int totalAmount = 0;
  late int totalAmount0 = 0;
    late int totalAmountSum = 0;
       late int totalAmountSum2 = 0;
        late int totalAmountSum3 = 0;
late  List<dynamic> show_carts = [];
  Future<void> show_cart() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_cart');
       var ressum = await http.post(uri,
       body: {
         'id_user': user_id.toString()
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);
           if(lnformation['message'] == 'Cart is empty'){
   print(lnformation['message']);
           }else{
        setState(() {
            totalAmount = 0;
                                                         totalAmountSum = 0;
                                                           totalAmountSum2 = 0;
                                                             totalAmountSum3 = 0;
         print(lnformation);
         show_carts  =lnformation['data'];
         
        // print(show_deliverys);
          for (var category in show_carts) {
                  category["NO"] = false;
            } 

            for (var category in show_carts) {
                  category["rateprice"] = 0;
            }            
           
              for (var category in show_carts) {
                  category["sumprice"] = 0;
            }    
   for (var product in show_carts) {
    if (product['amount'] == null) {
      product['amount'] = 0;
    }
  }

  
  print('Total amount: $totalAmount');
       
         
        });
           }
           show_rateprice();
         loading = false;
          // data_promotion_stores();
    }else {
       loading = false;
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }



late  List<dynamic> show_rateprices = [];
    Future<void> show_rateprice() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_rateprice');
       var ressum = await http.get(uri,
       
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
           
        
         show_rateprices  =lnformation['data']['data'];
    
        });
         loading = false;
          // data_promotion_stores();
    }else {
       loading = false;
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
     show_cart();
  }
late List<bool>  S1 = [];
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
                              'ตะกร้าสินค้า',
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
          
                 InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                                      children: [
                                        Container(
                                          //  width: MediaQuery.of(context).size.width*1,
                    
                                          // color: Colors.white,
                    
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                    
                                            // mainAxisAlignment: MainAxisAlignment.start,
                    
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                    
                                            children: <Widget>[
                                              Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Color(0xff041D6A),
                                                value: S2,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    S2 = value!;
                        
                                                   if (S2 == false) {
                                                      for(int i = 0; i<show_carts.length;i++ ){
                                                      show_carts[i]["NO"] = false;
                                                      }
                                                       totalAmount = 0;
                                                         totalAmountSum = 0;
                                                           totalAmountSum2 = 0;
                                                             totalAmountSum3 = 0;
                                                   for (var category in show_carts) {
   if (category['NO'] == true) {
     // บวกค่า amount ทั้งหมด

  totalAmount += int.parse(category['amount'].toString());
// totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;

        }
                                                   }
     totalAmount = totalAmount == 0 ? 0: totalAmount < 100 ? 1: (totalAmount / 100).floor() * 100;
     if(totalAmount0 == 0){

}else{
  if(totalAmount >= totalAmount0){
    
  }else{
   totalAmount = totalAmount0;
  }
  
}
     if(totalAmount == 0){
    for (var category in show_carts) {
      category["rateprice"] = 0;
    }
}else{
  // print('amount === = === ${totalAmount}');
   for (var category in show_carts) {
       for (var category2 in show_rateprices) {
      if(category2['id_type_animal'] == category['product_type_animal']&&category2['id_size'] == category['id_size']&&category2['amount'] <= totalAmount){
            //  print('id_type_animal === ${category2['id_type_animal']} === ${category['product_type_animal']}');
            //  print('id_size === ${category2['id_size']} === ${category['id_size']}');
            //   print('amount === ${category2['amount']} === ${totalAmount}');
             category["rateprice"] = category2['price'];
         }
      
    }
    if (category['NO'] == true) {
      int totalAmountSum0 = int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
     totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString());
     totalAmountSum2 += totalAmountSum0-(int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString()));
     totalAmountSum3 = totalAmountSum-totalAmountSum2;   
       print('price===>${totalAmountSum2}');
        print('price===>${totalAmountSum3}');
    }
    }
}  
    //  for(int i = 0;i<show_carts.length;i++){
    //    for(int f = 0;f<show_rateprices.length;f++){
    //      if(show_rateprices[f]['product_type_animal'] == show_carts[i]['product_type_animal']&&show_rateprices[f]['id_size'] == show_carts[i]['id_size']&&show_rateprices[f]['amount'] == totalAmount){
         
    //         //  print('price===>${show_rateprices[f]['price']}');
    //          show_carts[i]["rateprice"] = show_rateprices[f]['price'];
       
    //      }
    //    }
    //  }
  //      for (var category in show_carts) {
  //  if (category['NO'] == true) {
  //   print('price===>${category["rateprice"]}');
  //   totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
  //    totalAmountSum2 += int.parse(category["rateprice"]);
  //    totalAmountSum3 = totalAmountSum-totalAmountSum2;
  //  }}
    // var filteredData = category.where((product) => product["NO"] == true).toList();
    // category = filteredData;

                                                    } else {
                                                       for(int i = 0; i<show_carts.length;i++ ){
                                                      show_carts[i]["NO"] = true;
                                                      }
                                                       totalAmount = 0;
                                                         totalAmountSum = 0;
                                                          totalAmountSum2 = 0;
                                                             totalAmountSum3 = 0;
                                                   for (var category in show_carts) {
   if (category['NO'] == true) {
     // บวกค่า amount ทั้งหมด

    totalAmount += int.parse(category['amount'].toString());
    // totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
    
        }
       
    // var filteredData = category.where((product) => product["NO"] == true).toList();
    // category = filteredData;
} totalAmount = totalAmount == 0 ? 0: totalAmount < 100 ? 1: (totalAmount / 100).floor() * 100;
if(totalAmount0 == 0){

}else{
  if(totalAmount >= totalAmount0){
    
  }else{
   totalAmount = totalAmount0;
  }
}
  if(totalAmount == 0){
    for (var category in show_carts) {
      category["rateprice"] = 0;
    }
}else{
  // print('amount === = === ${totalAmount}');
   for (var category in show_carts) {
       for (var category2 in show_rateprices) {
      if(category2['id_type_animal'] == category['product_type_animal']&&category2['id_size'] == category['id_size']&&category2['amount'] <= totalAmount){
             print('id_type_animal === ${category2['id_type_animal']} === ${category['product_type_animal']}');
             print('id_size === ${category2['id_size']} === ${category['id_size']}');
              print('amount === ${category2['amount']} === ${totalAmount}');
             category["rateprice"] = category2['price'];
         }
      
    }
    if (category['NO'] == true) {
      int totalAmountSum0 = int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
     totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString());
     totalAmountSum2 += totalAmountSum0-(int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString()));
     totalAmountSum3 = totalAmountSum-totalAmountSum2;   
       print('price===>${totalAmountSum2}');
        print('price===>${totalAmountSum3}');
    }
    }
}  
    // for (var category in show_carts) {
    //    for (var category2 in show_rateprices) {
    //   if(category2['id_type_animal'] == category['product_type_animal']&&category2['id_size'] == category['id_size']&&category2['amount'] == totalAmount){
    //          category["rateprice"] = category2['price'];
    //      }
      
    // }
    // if (category['NO'] == true) {
    //   int totalAmountSum0 = int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
    //  totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
    //  totalAmountSum2 += totalAmountSum0-(int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString()));
    //  totalAmountSum3 = totalAmountSum-totalAmountSum2;   
    //    print('price===>${totalAmountSum2}');
    //     print('price===>${totalAmountSum3}');
    // }}
    //  for(int i = 0;i<show_carts.length;i++){
    //    for(int f = 0;f<show_rateprices.length;f++){
    //      if(show_rateprices[f]['product_type_animal'] == show_carts[i]['product_type_animal']&&show_rateprices[f]['id_size'] == show_carts[i]['id_size']&&show_rateprices[f]['amount'] == totalAmount){
    //       setState(() {
    //         //  print('price===>${show_rateprices[f]['price']}');
    //          show_carts[i]["rateprice"] = show_rateprices[f]['price'];
    //       });
    //      }
    //    }
    //  }
  //       for (var category in show_carts) {
  //  if (category['NO'] == true) {
  //    print('price===>${category["rateprice"]}');
  //    totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
  //    totalAmountSum2 += int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString());
  //    totalAmountSum3 = totalAmountSum-totalAmountSum2;
  //  }}
                                                    }
                    
                                                    // print(isChecked);
                                                  });
                                                },
                                              ),
                                              Center(
                                                child: Container(
                                                  // width:  MediaQuery.of(context).size.width * 0.75,
                    
                                                  child: Text(
                                                    'ทั้งหมด',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                    
                                        // Container(
                    
                                        //   child: Image.asset(
                    
                                        //     'assets/img/Vector3.png',
                    
                                        //     // width:double.infinity,
                    
                                        //     width: 20,
                    
                                        //     height: 20,
                    
                                        //     // fit: BoxFit.contain,
                    
                                        //   ),
                    
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 5, bottom: 5),
                                  //   child: Image.asset(
                                  //     'assets/img/Rectangle 27.png',
                                  //     height: 2,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                Container(
                  child: ListView.builder(
                                             physics: BouncingScrollPhysics(),
                                            //  scrollDirection: Axis.horizontal,
                                                                    shrinkWrap: true,
                                                                    itemCount: show_carts.length,
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
                                                                                                                     Checkbox(
                                                                                                                   checkColor: Colors.white,
                                                                                                                   activeColor: Color(0xff041D6A),
                                                                                                                   value: show_carts[index]["NO"],
                                                                                                                   onChanged: (bool? value) {
                                                                                                                     setState(() {
                                                                                                                     show_carts[index]["NO"] = value!;
                                                                                                                     totalAmount = 0;
                                                                                                                        totalAmountSum = 0;
                                                                                                                             totalAmountSum2 = 0;
                                                                                                                                totalAmountSum3 = 0;
                                                                                                                      for (var category in show_carts) {
                                                                      if (category['NO'] == true) {
                                                                     totalAmount += int.parse(category['amount'].toString());
                                                                           }}  
                                                                   totalAmount = totalAmount == 0 ? 0: totalAmount < 100 ? 1: (totalAmount / 100).floor() * 100;
                                                                   if(totalAmount0 == 0){
                                                                   
                                                                   }else{
                                                                    if(totalAmount >= totalAmount0){
                                                                       
                                                                     }else{
                                                                      totalAmount = totalAmount0;
                                                                     }
                                                                     print(totalAmount);
                                                                   }
                                                                   if(totalAmount == 0){
                                                                       for (var category in show_carts) {
                                                                         category["rateprice"] = 0;
                                                                       }
                                                                   }else{
                                                                     if(totalAmount == 1){
                                                                       for (var category in show_carts) {
                                                                        if(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'){
                                                                          category["rateprice"] = 0;
                                                                        } else{
                                                                          category["rateprice"] = 0;
                                                                        }
                                                                   
                                                                    if (category['NO'] == true) {
                                                                         int totalAmountSum0 = int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
                                                                        totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString());
                                                                        // totalAmountSum2 += totalAmountSum0-(int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString()));
                                                                        totalAmountSum3 = totalAmountSum-totalAmountSum2;   
                                                                          print('price===>${totalAmount}');
                                                                          //  print('price===>${totalAmountSum3}');
                                                                       }
                                                                   
                                                                   
                                                                       } 
                                                                     }else{

                                                                     
                                                                      for (var category in show_carts) {
                                                                          for (var category2 in show_rateprices) {
                                                                         if(category2['id_type_animal'] == category['product_type_animal']&&category2['id_size'] == category['id_size']&&category2['amount'] <= totalAmount){
                                                                              
                                                                                category["rateprice"] = category2['price'];
                                                                            }
                                                                         
                                                                       }
                                                                   
                                                                    if (category['NO'] == true) {
                                                                         int totalAmountSum0 = int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
                                                                        totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString());
                                                                        totalAmountSum2 += totalAmountSum0-(int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString()));
                                                                        totalAmountSum3 = totalAmountSum-totalAmountSum2;   
                                                                          print('price===>${totalAmount}');
                                                                          //  print('price===>${totalAmountSum3}');
                                                                       }
                                                                   
                                                                   
                                                                       }}
                                                                   }
                                                                       // for (var category in show_carts) {
                                                                       //    for (var category2 in show_rateprices) {
                                                                       //   if(category2['id_type_animal'] == category['product_type_animal']&&category2['id_size'] == category['id_size']&&category2['amount'] == totalAmount){
                                                                       //          category["rateprice"] = category2['price'];
                                                                       //      }
                                                                         
                                                                       // }
                                                                       // if (category['NO'] == true) {
                                                                       //   int totalAmountSum0 = int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
                                                                       //  totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString());
                                                                       //  totalAmountSum2 += totalAmountSum0-(int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString()));
                                                                       //  totalAmountSum3 = totalAmountSum-totalAmountSum2;   
                                                                       //    print('price===>${totalAmountSum2}');
                                                                       //     print('price===>${totalAmountSum3}');
                                                                       // }}
                                                                       //  for(int i = 0;i<show_carts.length;i++){
                                                                       //    for(int f = 0;f<show_rateprices.length;f++){
                                                                       //      if(show_rateprices[f]['id_type_animal'] == show_carts[i]['id_type_animal']&&show_rateprices[f]['id_size'] == show_carts[i]['id_size']&&show_rateprices[f]['amount'] == totalAmount){
                                                                       //       setState(() {
                                                                       //         // print('price===>${show_rateprices[f]['price']}');
                                                                       //          show_carts[i]["rateprice"] = show_rateprices[f]['price'];
                                                                       //       });
                                                                       //      }
                                                                       //    }
                                                                       //  }
                                                                     //       for (var category in show_carts) {
                                                                     //  if (category['NO'] == true) {
                                                                     
                                                                     //    totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
                                                                     //    totalAmountSum2 += int.parse(category["rateprice"]);
                                                                     //    totalAmountSum3 = totalAmountSum-totalAmountSum2;
                                                                     //       print('price===>${totalAmountSum2}');
                                                                     //  }}
                                                                                                                       // if (S2 == false) {
                                                                                                                       //   for(int i = 0; i<catagory!.length;i++ ){
                                                                                                                       //   catagory![i]["NO"] = false;
                                                                                                                       //   }
                                                                                                                         
                                                                                                                       // } else {
                                                                                                                       //    for(int i = 0; i<catagory!.length;i++ ){
                                                                                                                       //   catagory![i]["NO"] = true;
                                                                                                                       //   }
                                                                                                                       // }
                                                                                       
                                                                                                                       // print(isChecked);
                                                                                                                     });
                                                                                                                   },
                                                                                                                 ),
                                                                                                                   Container(
                                                                                                                      margin: EdgeInsets.only(left: 10),
                                                                                                                      child: Image.network(
                                                                              '${MyConstant().domain2}/${show_carts[index]['image_path']}',
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
                                                                                                                      child: Text('${show_carts[index]['product_type']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
                                                                                                                    ),
                                                                                                                             Container(
                                                                                                                      child: Text('ตัวเลือก : ${show_carts[index]['product_name']},${show_carts[index]['size_name']}',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffAFAFAF), fontSize: 12,fontWeight: FontWeight.w500),),
                                                                                                                    ),
                                                                                                                             Row(
                                                                                                                               children: [
                                                                     Text('${show_carts[index]['price']} ฿',textScaleFactor: 1.0,style: TextStyle(
                                                                                                           // fontFamily: 'IBM',
                                                                                                                 decoration: TextDecoration.lineThrough,
                                                                                                                 decorationColor: Color(0xFF989898),
                                                                                                           fontSize: 12,
                                                                                                           fontWeight: FontWeight.w400,
                                                                                                           color: Color(0xff979696),
                                                                                                         ),), 
                                                                                                                              '${show_carts[index]["rateprice"].toString()}'== '0'  ?
                                                                                                                               Container(
                                                                                                                      child: Text('${show_carts[index]['sale_price']} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 14,fontWeight: FontWeight.w600),),
                                                                                                                    ):Container(
                                                                                                                      child: Text('${show_carts[index]["rateprice"].toString()} ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBA1F23), fontSize: 14,fontWeight: FontWeight.w600),),
                                                                                                                    ),
                                                                                                                               ],
                                                                                                                             ),
                                                                                                                           
                                                                                                             Container(
                                                                                                               margin: EdgeInsets.only(top: 5),
                                                                                                               child: Row(
                                                                                                                 children: [
                                                                                                                   InkWell(
                                                                                                                     onTap: () {
                                                                                                                       setState(() {
                                                                                                                         if(int.parse(show_carts[index]['amount'].toString()) > 0){
                                                                                                                            cart(show_carts[index]['cart_id_product_amount'],show_carts[index]['id_cart'],'-10');
                                                                                                                         }
                                                                                                                          
                                                                                                                         // totalAmount = 0;
                                                                                                                         //     totalAmountSum = 0;
                                                                                                                         //     totalAmountSum2 = 0;
                                                                                                                         //        totalAmountSum3 = 0;
                                                                   //                                                    for (var category in show_carts) {
                                                                   //    if (category['NO'] == true) {
                                                                   //      // บวกค่า amount ทั้งหมด
                                                                   
                                                                   //   totalAmount += int.parse(category['amount'].toString());
                                                                   // totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
                                                                   //      totalAmountSum3 = totalAmountSum-totalAmountSum2;  
                                                                   //         }
                                                                   //     // var filteredData = category.where((product) => product["NO"] == true).toList();
                                                                   //     // category = filteredData;
                                                                   // }
                                                                                                                       });
                                                                                                                     },
                                                                                                                     child: Container(
                                                                                                                       height: 30,
                                                                                                                       width: 30,
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
                                                                                                                             fontSize: 14,
                                                                                                                             fontWeight: FontWeight.w600,
                                                                                                                             color: Color(0xffFFFFFF),
                                                                                                                           ),
                                                                                                                         ),
                                                                                                                       ),
                                                                                                                     ),
                                                                                                                   ),
                                                                                                                   Container(
                                                                                                                     margin: EdgeInsets.only(right: 10,left: 10),
                                                                                                                     child: Text(
                                                                                                                       '${show_carts[index]['amount']}',
                                                                                                                       textScaleFactor: 1.0,
                                                                                                                       style: TextStyle(
                                                                                                                         // fontFamily: 'IBM',
                                                                                                                         fontSize: 13,
                                                                                                                         fontWeight: FontWeight.w400,
                                                                                                                         color: Color(0xff000000),
                                                                                                                       ),
                                                                                                                     ),
                                                                                                                   ),
                                                                                                                   InkWell(
                                                                                                                     onTap: () {
                                                                                                                       setState(() {
                                                                                                                         totalAmount = 0;
                                                                                                                          totalAmountSum = 0;
                                                                                                                             totalAmountSum2 = 0;
                                                                                                                                totalAmountSum3 = 0;
                                                                      cart(show_carts[index]['cart_id_product_amount'],show_carts[index]['id_cart'],'10');
                                                                   //                                                    for (var category in show_carts) {
                                                                                                                  
                                                                   //    if (category['NO'] == true) {
                                                                   //      // บวกค่า amount ทั้งหมด
                                                                   
                                                                   //   totalAmount += int.parse(category['amount'].toString());
                                                                   // totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
                                                                   //      totalAmountSum3 = totalAmountSum-totalAmountSum2;  
                                                                   //         }
                                                                   //     // var filteredData = category.where((product) => product["NO"] == true).toList();
                                                                   //     // category = filteredData;
                                                                   // }
                                                                                                                       });
                                                                                                                     },
                                                                                                                     child: Container(
                                                                                                                       height: 30,
                                                                                                                       width: 30,
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
                                                                                                                             fontSize: 14,
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
                                                                                                              
                                                                                                          
                                                                                                         
                                                                                                                          ],)
                                                                                                                        ),
                                                                                                                 ),
                                                                                                                  
                                                                                                                  ],
                                                                                                                ),
                                                                   ),
                                             GestureDetector(
                                               onTap: () {
                                                 
                                                 delete_cart(show_carts[index]['id_cart']);
                                               },
                                               child: Container(
                                                 child: Icon(Icons.cancel,color: Colors.red,),
                                               ),
                                             )
                                                                 ],
                                                               ),
                                                              ),
                     );
                   }
                               ),
                ),
               totalAmount.toString() == '1'  ?Container(
                   alignment: Alignment.topLeft,
                  child: Text('*ตอนนี้คุณได้เรทราคาปลีก',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBD2325), fontSize: 12,fontWeight: FontWeight.w600),),
              )
               :Container(
                   alignment: Alignment.topLeft,
                  child: Text('*ตอนนี้คุณได้เรทราคา $totalAmount ตัว',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBD2325), fontSize: 12,fontWeight: FontWeight.w600),),
              ),

              Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:  Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //  color: Color(0xff979696),
                          ),
                          margin: EdgeInsets.only(top: 10), //ขนาดแยกบน
                          // width: screenW * 0.75,
                          child: TextField(
                             controller: _Rate,
                            // style: TextStyle(
                            //     color: Colors.black), //เปลี่ยนสี่คำใน inPut
                            decoration: InputDecoration(
                              // hintStyle: TextStyle(
                              //   color: Color(0xff979696),
                              // ), //เปลี่ยนสี่คำใน hin
                              labelText: 'รหัสลูกค้า',
                              // prefixIcon: Icon(
                              //   Icons.perm_identity,
                              //   color: const Color.fromARGB(255, 141, 141, 141),
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              //   //กรอบสี่เหลี่ยม
                              //   borderRadius:
                              //       BorderRadius.circular(20), //ขนาดมุม
                              //   borderSide:
                              //       BorderSide(color: const Color.fromARGB(255, 0, 0, 0)), //สี
                              // ),
                              // focusedBorder: OutlineInputBorder(
                              //   //กรอบสี่เหลี่ยม
                              //   borderRadius:
                              //       BorderRadius.circular(20), //ขนาดมุม
                              //   borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                              // ),
                            ),
                          )),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      totalAmount0 = 1000;
                      
                                                       totalAmount = 0;
                                                         totalAmountSum = 0;
                                                           totalAmountSum2 = 0;
                                                             totalAmountSum3 = 0;
                                                   for (var category in show_carts) {
   if (category['NO'] == true) {
     // บวกค่า amount ทั้งหมด

  totalAmount += int.parse(category['amount'].toString());
// totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;

        }
                                                   }
     totalAmount = totalAmount == 0 ? 0: totalAmount < 100 ? 1: (totalAmount / 100).floor() * 100;
     if(totalAmount0 == 0){

}else{
  if(totalAmount >= totalAmount0){
    
  }else{
   totalAmount = totalAmount0;
  }
}
     if(totalAmount == 0){
    for (var category in show_carts) {
      category["rateprice"] = 0;
    }
}else{
  // print('amount === = === ${totalAmount}');
   for (var category in show_carts) {
       for (var category2 in show_rateprices) {
      if(category2['id_type_animal'] == category['product_type_animal']&&category2['id_size'] == category['id_size']&&category2['amount'] <= totalAmount){
             print('id_type_animal === ${category2['id_type_animal']} === ${category['product_type_animal']}');
             print('id_size === ${category2['id_size']} === ${category['id_size']}');
              print('amount === ${category2['amount']} === ${totalAmount}');
             category["rateprice"] = category2['price'];
         }
      
    }
    if (category['NO'] == true) {
      int totalAmountSum0 = int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString()) ;
     totalAmountSum += int.parse(category['sale_price'].toString() == '0'||category['sale_price'].toString() == ''||category['sale_price'].toString() == 'null'?category['price'].toString():category['sale_price'].toString())*int.parse(category['amount'].toString());
     totalAmountSum2 += totalAmountSum0-(int.parse(category["rateprice"].toString())*int.parse(category['amount'].toString()));
     totalAmountSum3 = totalAmountSum-totalAmountSum2;   
       print('price===>${totalAmountSum2}');
        // print('price===>${totalAmountSum3}');
    }
    }
}  
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Image.asset(
                      'assets/images/Rectangle 163.png',
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
                   Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),                                  
             Container(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                     Container(
                
                  child: Text('รวมค่าสินค้า',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
               Container(
                
                  child: Text('$totalAmountSum ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w600),),
              ),
                 ],
               ),
             ),
             Container(
               margin: EdgeInsets.only(top: 5),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                     Container(
                
                  child: Text('ส่วนลด',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
               Container(
                
                  child: Text('-$totalAmountSum2 ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffFAAB35), fontSize: 14,fontWeight: FontWeight.w600),),
              ),
                 ],
               ),
             )    ,
             Container(
                 margin: EdgeInsets.only(top: 5),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                     Container(
                
                  child: Text('ค่าสินค้าหลังหักส่วนลด',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w500),),
              ),
               Container(
                
                  child: Text('$totalAmountSum3 ฿',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffBD2325), fontSize: 16,fontWeight: FontWeight.w600),),
              ),
                 ],
               ),
             )    ,   
             Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Image.asset(
              'assets/images/Line 11.png',
              // height: 2,
            ),
          ),   
               Container(
                 alignment: Alignment.bottomRight,
                
                 child: InkWell(
                                   onTap: () async{
                                       List<dynamic> products2 = show_carts; // สร้างรายการใหม่เพื่อทำการแก้ไข
  late List<dynamic>? products2_0 = []; 
for (var category in products2) {
   if (category['NO'] == true) {
     setState(() {
            category['sumprice'] = int.parse(category['rateprice'].toString()) * int.parse(category['amount'].toString());
     });
 
      products2_0.add(category);
        }
    print(products2_0);
    // var filteredData = category.where((product) => product["NO"] == true).toList();
    // category = filteredData;
}

Map<String, List<dynamic>> groupedData = {};
for (var item in products2_0) {
  var status = item['status'];
  groupedData.putIfAbsent(status, () => []);
  groupedData[status]!.add(item);
}

// Convert the grouped data to the desired format
List<dynamic> show_rateprices0 = [];
groupedData.forEach((key, value) {
  show_rateprices0.add({
    'name': key,
     'show_delivery': null,
     'S3' : -1,
    'data': value
  });
});

print('object===>$show_rateprices0');
    
                                      var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>CartOrder(products2:products2_0,Sum:totalAmountSum3,totalAmount:totalAmount,products3:show_rateprices0) ),);
                                 if (navigationResult == null ) {
                         
                                 }
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
                                                    'ชำระเงิน',
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



  Future<void> cart(var id_product_amount,var id,var amount) async {
    try {
      setState(() {
        loading = true;
      });
      print(amount);
       print(id);
       EasyLoading.show(status: 'กำลังบันทึกข้อมูล');
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String user_id = preferences.getString('id').toString();
        print('id_product_amount==> $id_product_amount');
      print('id_product_amount==> $id');
      var uri = Uri.parse('${MyConstant().domain}/cart');
       var ressum = await http.post(uri,
       body: {
         'id_user': user_id,
         'id_product_amount': id_product_amount.toString(),
          'amount': '$amount',
      
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);
          EasyLoading.showSuccess(lnformation['message'].toString()).then((value)async {
            setState(() {
         print(lnformation);
              show_cart() ;
                 loading = false;
 
       
         
        });
        });   
       
          // data_promotion_stores();
    }else {

      var  lnformation  = jsonDecode(ressum.body);
        printWrapped(lnformation['message'].toString());
        EasyLoading.showError(lnformation['message'].toString());
    }
    } catch (e) {
       printWrapped(e.toString());
      EasyLoading.showError(e.toString());
    }
  }




   Future<void> delete_cart(var id) async {
    try {
      setState(() {
        loading = true;
      });
     
       EasyLoading.show(status: 'กำลังลบข้อมูล');
 
    

      var uri = Uri.parse('${MyConstant().domain}/delete_cart');
       var ressum = await http.post(uri,
       body: {
        //  'id_user': user_id,
        //  'id_product_amount': id_product_amount.toString(),
           'id': '$id',
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);
          EasyLoading.showSuccess(lnformation['message'].toString()).then((value)async {
            setState(() {
         print(lnformation);
              show_cart() ;
                 loading = false;
 
       
         
        });
        });   
       
          // data_promotion_stores();
    }else {

      var  lnformation  = jsonDecode(ressum.body);
        printWrapped(lnformation['message'].toString());
        EasyLoading.showError(lnformation['message'].toString());
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
