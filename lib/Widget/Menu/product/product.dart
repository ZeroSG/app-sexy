import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import '../account/buy_again.dart';
import 'basket.dart';
import 'productS.dart';
 import 'package:http/http.dart' as http;

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late TextEditingController _searchController = TextEditingController(); 
  int num=0;
    late  List<dynamic> type_animal = [

];
  late  List<dynamic> type_size = [

];


 late  List<dynamic> Categorys = [{'name':'หมวดหมู่','id':'0'}];
 late  List<dynamic> sizes = [{'name':'ขนาด','id':'0'}];
 late  List<dynamic> prices = [{'name':'ราคา','id':'0'},{'name':'ราคาต่ำสุด','id':'1'},{'name':'ราคาสูงสุด','id':'2'}];
late Map<String,dynamic>?  Category = Categorys[0],size= sizes[0],price= prices[0];

late  List<dynamic> data = [];
 bool loading = true;
Future<void> show_product() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String id_warehousecode = preferences.getString('id_warehousecode').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_product');
       var ressum = await http.post(uri,
       body: {
         'id_warehousecode': '$id_warehousecode'
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         
         type_animal  =lnformation['data']['type_animal'];
         type_size =lnformation['data']['size'];
         data =lnformation['data']['data'];
         Categorys = [{'name':'หมวดหมู่','id':'0'}];
         sizes = [{'name':'ขนาด','id':'0'}];

         for(var i in type_size){
       
    if (!sizes.contains({'name':'${i['name']}','id':'${i['id']}'})) {
      sizes.add({'name':'${i['name']}','id':'${i['id']}'});
    }
   
         }
 
  for(var i in type_animal){
     
    if (!Categorys.contains({'name':'${i['name']}','id':'${i['id']}'})) {
      Categorys.add({'name':'${i['name']}','id':'${i['id']}'});
    }
   
         }
          int chunkSize = 6;

  List<List<dynamic>> chunks = [];

  for (int i = 0; i < type_animal.length; i += chunkSize) {
    int end = (i + chunkSize < type_animal.length) ? i + chunkSize : type_animal.length;
    chunks.add(type_animal.sublist(i, end));
 
  }

   type_animal = chunks;

         loading = false;

       
         
        });
          // data_promotion_stores();
    }else {
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }



  Future<void> show_productfilter() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String id_warehousecode = preferences.getString('id_warehousecode').toString();
      var uri = Uri.parse('${MyConstant().domain}/filter');
       var ressum = await http.post(uri,
       body: {
           "id_type_animal":  Category!['id'].toString() =='0'? '':'${Category!['id'].toString()}',
           "price":  price!['id'].toString() =='0'? '':'${price!['id'].toString()}',
           "id_size": size!['id'].toString() =='0'? '':'${size!['id'].toString()}',
           "id_warehousecode" : '$id_warehousecode'
       }
            );
         print(ressum.statusCode)   ;  
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         
      
         data =lnformation['data'];
         loading = false;

       
         
        });
          // data_promotion_stores();
    }else {
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
    show_product();
  }

bool DD = true;
   late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: loading ? 
                        Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator())):Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(70),
                      bottomLeft: Radius.circular(70),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFBD2325), Color(0xFFE05C45)],
                        ),
                      ),
                      height: 125,
                      width: MediaQuery.of(context).size.width * 1,
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Expanded(
                           child: Container(
                              margin: EdgeInsets.only(left: 50,top: 10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Color(0xffEFEFEF), width: 1),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xffEFEFEF).withOpacity(0.43),
                                  ),
                                  height: 40,
                                  // margin: EdgeInsets.only(top: 16),
                                  // width: screenW * 0.85,
                                  child: TextField(
                                     controller: _searchController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Color(0xffEFEFEF).withOpacity(0.43),fontSize: 13),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.only(top: 10,left: 20),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      hintText: 'คุณกำลังมองหาหนูประเภทไหนอยู่ ?',
                                      hintStyle: TextStyle(color: Color(0xffFFFFFF)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Color(0xffEFEFEF).withOpacity(0.43)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Color(0xffEFEFEF).withOpacity(0.43)),
                                      ),
                                    ),
                                  ),
                                ),
                         ),
                         GestureDetector(
                               onTap: () async{
                                  Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Basket() ),);
                                 if (navigationResult == null ) {
                              
                                 }
                               },
                           child: Container(
                               margin: EdgeInsets.only(right: 40,left: 10,top: 10),
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
                      
                    ),
                  ),
           Expanded(child: 
          Container(
            
            margin: EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(physics: BouncingScrollPhysics(),
               child: Container(
                 child: Column(
                   children: [
                       Padding(
                            padding: const EdgeInsets.only(right: 40,left: 40,top: 20,bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                       
                                        child: Text('หมวดหมู่',textScaleFactor: 1.0,style: TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.w600
                                        ),),
                                      ),
                          
                               InkWell(
                                 onTap: () {
                                   setState(() {
                                     if(DD == false){
                                        DD = true; 
                                     }else{
                                       DD = false;
                                     }
                                   });
                                 },
                                 child: Container(
                                     decoration: BoxDecoration(
                                      border: Border.all(color: Color.fromARGB(255, 241, 4, 4), width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                                     height: 40,
                                                 
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 35,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(10.0),
                                                            child: Image.asset(
                                                                  'assets/images/Rectangle 60.png',
                                                                ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(right: 20),
                                                          child: Text('ตัวกรอง',style: TextStyle(
                                                            fontSize: 10,fontWeight: FontWeight.w500,color: Color(0xffBD2325)
                                                          ),),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                               ),       
                              ],
                            ),
                          ),

                          DD ? Container()
                          : Container(
                            
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                                      padding:  EdgeInsets.only(right: 5,left: 20,top :0,bottom: 10),
                                   child: Container(
                                     decoration: BoxDecoration(
                                                            border: Border.all(color: Color(0xffBD2325), width: 1),
                                                            borderRadius: BorderRadius.circular(30),
                                                            color: Color(0xffFFFFFF),
                                                          ),
                                     margin: EdgeInsets.only(top: 16),
                                     child: DropdownButtonFormField(
                                                     decoration: InputDecoration(
                                                       enabledBorder: OutlineInputBorder(
                                                         borderSide: BorderSide(
                                                           width: 1,
                                                           color: Color(0xffBD2325)
                                                         ),
                                                         borderRadius: BorderRadius.circular(60),
                                                       ),
                                                       isDense: true,
                                                       contentPadding: EdgeInsets.fromLTRB(18, 7, 15, 12),
                                                       border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                           width: 1,
                                                           color: Color(0xffBD2325)
                                                         ),
                                                         borderRadius: BorderRadius.circular(60),
                                                       ),
                                                     ),
                                                     isExpanded: true,
                                                     hint: Text(
                                                       'กรุณาเลือก',
                                                       // style: textContentGrey,
                                                     ),
                                                     icon: Icon(
                                                       Icons
                                                           .keyboard_arrow_down, // You can use a different icon if you prefer
                                                       color: Color(0xffBD2325), // Set the color to red
                                                     ),
                                                     iconSize: 20,
                                                    value: Category!['id'],
                                                     items: Categorys
                                                         .map((item) => DropdownMenuItem<String>(
                                                               value: item['id'].toString(),
                                                               child: Text(
                                                                 item['name'].toString(),
                                                                 // style: textContentGrey,
                                                               ),
                                                             ))
                                                         .toList(),
                                                     validator: (value) {
                                                       print('value===>$value');
                                                       if (value == null) {
                                                         return 'กรุณาเลือก';
                                                       }
                                                     },
                                                     onChanged: (value)async {
                                                       setState(() {
                                                         for(var i in Categorys){
                                                           if(i!['id'].toString() == value.toString()){
                                                               Category = i;
                                                               show_productfilter();
                                                           }
                                                         }
                                                        
                                                       });
                                                     },
                                                     onSaved: (value) {
                                                       // selectedValue = value.toString();
                                                     },
                                                   ),
                                   ),
                                  //                     child: Container(
                                  //                         decoration: BoxDecoration(
                                  //                           border: Border.all(color: Color(0xffBD2325), width: 1),
                                  //                           borderRadius: BorderRadius.circular(30),
                                  //                           color: Color(0xffFFFFFF),
                                  //                         ),
                                  //                         height: 40,
                                  //                         margin: EdgeInsets.only(top: 16),
                                  //                         // width: screenW * 0.85,
                                  //                         child: TextField(
                                  //                           readOnly: true,
                                  //                            controller: _searchController,
                                  //                           // keyboardType: TextInputType.emailAddress,
                                  //                           style: TextStyle(color: Color(0xff000000),fontSize: 13),
                                  //                           decoration: InputDecoration(
                                  //                             filled: true,
                                  //                             contentPadding: EdgeInsets.only(top: 10,left: 20),
                                  //                             border: InputBorder.none,
                                                             
                                  //                             hintText: 'หมวดหมู่',
                                  //                             hintStyle: TextStyle(color: Color(0xff000000)),
                                  //                             enabledBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(30),
                                  // borderSide: BorderSide(color: Color(0xffFFFFFF)),
                                  //                             ),
                                  //                             focusedBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(30),
                                  // borderSide: BorderSide(color: Color(0xffFFFFFF)),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                                    ),
                                ),
                                Expanded(
                                  child: Padding(
                                                      padding:  EdgeInsets.only(right: 0,left: 0,top :0,bottom: 10),
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Color(0xffBD2325), width: 1),
                                                            borderRadius: BorderRadius.circular(30),
                                                            color: Color(0xffFFFFFF),
                                                          ),
                                                          height: 40,
                                                          margin: EdgeInsets.only(top: 16),
                                                          // width: screenW * 0.85,
                                                          child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xffBD2325)
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(18, 7, 15, 12),
                    border: OutlineInputBorder(
                       borderSide: BorderSide(
                        width: 1,
                        color: Color(0xffBD2325)
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'กรุณาเลือก',
                    // style: textContentGrey,
                  ),
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down, // You can use a different icon if you prefer
                    color: Color(0xffBD2325), // Set the color to red
                  ),
                  iconSize: 20,
                 value: size!['id'],
                  items: sizes
                      .map((item) => DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: Text(
                              item['name'].toString(),
                              // style: textContentGrey,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    print('value===>$value');
                    if (value == null) {
                      return 'กรุณาเลือก';
                    }
                  },
                  onChanged: (value)async {
                    setState(() {
                       for(var i in sizes){
                                                           if(i!['id'].toString() == value.toString()){
                                                               size = i;
                                                               show_productfilter();
                                                           }
                                                         }
                     
                    });
                  },
                  onSaved: (value) {
                    // selectedValue = value.toString();
                  },
                ),
                                                        ),
                                                    ),
                                ),
                                Expanded(
                                  child: Padding(
                                                      padding:  EdgeInsets.only(right: 20,left: 5,top :0,bottom: 10),
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Color(0xffBD2325), width: 1),
                                                            borderRadius: BorderRadius.circular(30),
                                                            color: Color(0xffFFFFFF),
                                                          ),
                                                          height: 40,
                                                          margin: EdgeInsets.only(top: 16),
                                                          // width: screenW * 0.85,
                                                          child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xffBD2325)
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(18, 7, 15, 12),
                    border: OutlineInputBorder(
                       borderSide: BorderSide(
                        width: 1,
                        color: Color(0xffBD2325)
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'กรุณาเลือก',
                    // style: textContentGrey,
                  ),
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down, // You can use a different icon if you prefer
                    color: Color(0xffBD2325), // Set the color to red
                  ),
                  iconSize: 20,
                 value: price!['id'],
                  items: prices
                      .map((item) => DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: Text(
                              item['name'].toString(),
                              // style: textContentGrey,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    print('value===>$value');
                    if (value == null) {
                      return 'กรุณาเลือก';
                    }
                  },
                  onChanged: (value)async {
                    setState(() {
                        for(var i in prices){
                                                           if(i!['id'].toString() == value.toString()){
                                                               price = i;
                                                               show_productfilter();
                                                           }
                                                         }
                
                    });
                  },
                  onSaved: (value) {
                    // selectedValue = value.toString();
                  },
                ),
                                                        ),
                                                    ),
                                ),
                                
                              ],
                            ),
                          ),
                       Container(
                         margin: EdgeInsets.only(top: 20),
                         child: CarouselSlider(
                            options: CarouselOptions(
                              height: 220,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: num,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: Duration(seconds: 5),
                              // autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.1,
                              onPageChanged: ((index, reason) {
                                setState(() {
                                  num = index;
                                });
                              }),
                              scrollDirection: Axis.horizontal,
                            ),
                            items: type_animal.map((i) {
                              return Column(
                                children: [
                                  Container(
                                             height: 100,
                               
                                    child: ListView.builder(
                                           physics: BouncingScrollPhysics(),
                                           scrollDirection: Axis.horizontal,
                                                                  shrinkWrap: true,
                                                                  itemCount: i.length > 3 ? 3 :i.length,
                                         itemBuilder: (context, index)  {
                                        return  InkWell(
                                                 onTap: () async{
                                          Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                               builder: (_) =>Buy_Again(index:2,id_type_animal:i[index]['id'].toString(),id_type_animalname:i[index]['name'].toString()) ),);
                                       if (navigationResult != null ) {
                                  
                                       }
                                     },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Builder(
                                                  builder: (context) {
                                                    return Container(
                                                      margin: EdgeInsets.only(right: 10),
                                                                                    height: 100,
                                                                                    width: 100,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xffE05C45),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 20,left: 20),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisAlignment:MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Image.asset(
                                                                                                'assets/home/Rectangle 89.png',
                                                                                          ),
                                                                                          Text('${i[index]['name'].toString()}',textScaleFactor: 1.0,style: TextStyle(
                                                                // fontFamily: 'IBM',
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w500,
                                                                color: Color(0xffFFFFFF),
                                                              ),),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    
                                                                                  );
                                                  }
                                                ),
                                                  //  Container(
                                                  //    margin: EdgeInsets.only(right: 10),
                                                  //                               height: 100,
                                                  //                               width: 100,
                                                  //                               decoration: BoxDecoration(
                                                  //                                 color: Color(0xffFF8158),
                                                  //                                 borderRadius: BorderRadius.circular(10),
                                                  //                               ),
                                                  //                               child: Padding(
                                                  //                                 padding: const EdgeInsets.only(right: 20,left: 20),
                                                  //                                 child: Column(
                                                  //                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                  //                                   mainAxisAlignment:MainAxisAlignment.center,
                                                  //                                   children: [
                                                  //                                     Image.asset(
                                                  //                                           'assets/home/Rectangle 89.png',
                                                  //                                     ),
                                                  //                                     Text('${i[0]['name'].toString()}',textScaleFactor: 1.0,style: TextStyle(
                                                  //           // fontFamily: 'IBM',
                                                  //           fontSize: 10,
                                                  //           fontWeight: FontWeight.w500,
                                                  //           color: Color(0xffFFFFFF),
                                                  //         ),),
                                                  //                                   ],
                                                  //                                 ),
                                                  //                               ),
                                                                                
                                                  //                             ),
                                                          //                      Container(
                                                          //                        margin: EdgeInsets.only(right: 10),
                                                          //                       height: 100,
                                                          //                       width: 100,
                                                          //                       decoration: BoxDecoration(
                                                          //                         color: Color(0xffFAAB35),
                                                          //                         borderRadius: BorderRadius.circular(10),
                                                          //                       ),
                                                          //                       child: Padding(
                                                          //                         padding: const EdgeInsets.only(right: 20,left: 20),
                                                          //                         child: Column(
                                                          //                           crossAxisAlignment: CrossAxisAlignment.center,
                                                          //                           mainAxisAlignment:MainAxisAlignment.center,
                                                          //                           children: [
                                                          //                             Image.asset(
                                                          //                                   'assets/home/Rectangle 89.png',
                                                          //                             ),
                                                          //                             Text('${i[0]['name'].toString()}',textScaleFactor: 1.0,style: TextStyle(
                                                          //   // fontFamily: 'IBM',
                                                          //   fontSize: 10,
                                                          //   fontWeight: FontWeight.w500,
                                                          //   color: Color(0xffFFFFFF),
                                                          // ),),
                                                          //                           ],
                                                          //                         ),
                                                          //                       ),
                                                                                
                                                          //                     ),                            
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                   i.length <= 3 ? Container() 
                                   :Container(
                                      margin: EdgeInsets.only(top: 10),
                                             height: 100,
                               
                                    child: ListView.builder(
                                           physics: BouncingScrollPhysics(),
                                           scrollDirection: Axis.horizontal,
                                                                  shrinkWrap: true,
                                                                  itemCount: i.length,
                                         itemBuilder: (context, index)  {
                                        if(index > 2){
                                      return  InkWell(
                                                 onTap: () async{
                                          Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                               builder: (_) =>Buy_Again(index:2,id_type_animal:i[index]['id'].toString(),id_type_animalname:i[index]['name'].toString()) ),);
                                       if (navigationResult != null ) {
                                  
                                       }
                                     },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Builder(
                                                  builder: (context) {
                                                    return Container(
                                                      margin: EdgeInsets.only(right: 10),
                                                                                    height: 100,
                                                                                    width: 100,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xffE05C45),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(right: 20,left: 20),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisAlignment:MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Image.asset(
                                                                                                'assets/home/Rectangle 89.png',
                                                                                          ),
                                                                                          Text('${i[index]['name'].toString()}',textScaleFactor: 1.0,style: TextStyle(
                                                                // fontFamily: 'IBM',
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w500,
                                                                color: Color(0xffFFFFFF),
                                                              ),),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    
                                                                                  );
                                                  }
                                                ),
                                                  //  Container(
                                                  //    margin: EdgeInsets.only(right: 10),
                                                  //                               height: 100,
                                                  //                               width: 100,
                                                  //                               decoration: BoxDecoration(
                                                  //                                 color: Color(0xffFF8158),
                                                  //                                 borderRadius: BorderRadius.circular(10),
                                                  //                               ),
                                                  //                               child: Padding(
                                                  //                                 padding: const EdgeInsets.only(right: 20,left: 20),
                                                  //                                 child: Column(
                                                  //                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                  //                                   mainAxisAlignment:MainAxisAlignment.center,
                                                  //                                   children: [
                                                  //                                     Image.asset(
                                                  //                                           'assets/home/Rectangle 89.png',
                                                  //                                     ),
                                                  //                                     Text('${i[0]['name'].toString()}',textScaleFactor: 1.0,style: TextStyle(
                                                  //           // fontFamily: 'IBM',
                                                  //           fontSize: 10,
                                                  //           fontWeight: FontWeight.w500,
                                                  //           color: Color(0xffFFFFFF),
                                                  //         ),),
                                                  //                                   ],
                                                  //                                 ),
                                                  //                               ),
                                                                                
                                                  //                             ),
                                                          //                      Container(
                                                          //                        margin: EdgeInsets.only(right: 10),
                                                          //                       height: 100,
                                                          //                       width: 100,
                                                          //                       decoration: BoxDecoration(
                                                          //                         color: Color(0xffFAAB35),
                                                          //                         borderRadius: BorderRadius.circular(10),
                                                          //                       ),
                                                          //                       child: Padding(
                                                          //                         padding: const EdgeInsets.only(right: 20,left: 20),
                                                          //                         child: Column(
                                                          //                           crossAxisAlignment: CrossAxisAlignment.center,
                                                          //                           mainAxisAlignment:MainAxisAlignment.center,
                                                          //                           children: [
                                                          //                             Image.asset(
                                                          //                                   'assets/home/Rectangle 89.png',
                                                          //                             ),
                                                          //                             Text('${i[0]['name'].toString()}',textScaleFactor: 1.0,style: TextStyle(
                                                          //   // fontFamily: 'IBM',
                                                          //   fontSize: 10,
                                                          //   fontWeight: FontWeight.w500,
                                                          //   color: Color(0xffFFFFFF),
                                                          // ),),
                                                          //                           ],
                                                          //                         ),
                                                          //                       ),
                                                                                
                                                          //                     ),                            
                                              ],
                                            ),
                                          ),
                                        );
                                        }
                                        else{
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                       ),
                        Container(
                          margin: EdgeInsets.only(top: 8,bottom: 5),
                          height: 10,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: type_animal.length,
                  
                              //   separatorBuilder:  (context, index) {
                  
                              //   return const SizedBox(width: 2,);
                  
                              // },
                  
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async{
                                      
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: num == index
                                          ? Color(0xFFBA1F23)
                                          : Color(0xFFD34739).withOpacity(0.54),
                                    ),
                                                  
                                    width: num == index ? 40 : 10,
                                    // child: Image.asset(category.image),
                                  ),
                                );
                              }),
                        ),
             
             
                        Padding(padding: EdgeInsets.only(right: 25,left: 25,top: 20),
                        child:  StaggeredGrid.count(
                          mainAxisSpacing : 10,
                          crossAxisSpacing :10,
                           crossAxisCount: 3, 
                           children: data.sublist(0, data.length).map<Widget>((item) {
                             return InkWell(
                               onTap: () async{
                                  Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>ProductS(id_product: item['id_product'],name:item['type']) ),);
                                 if (navigationResult == null ) {
                                     show_product();
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
                                                                              child: Text('${item['size_name']}',textScaleFactor: 1.0,
                                                                                                                                                      
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
                        ),        )
                   ],
                 ),
               ),
             ),
          ))       
          ],
        ),
      ),
    );
  }
}