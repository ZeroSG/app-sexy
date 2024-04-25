import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
import '../product/productS.dart';
import 'Account settings.dart';
import 'GoogleMap.dart';
import 'Set_up.dart';
import 'buy_again.dart';
import 'order.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
   String name = '';
   bool loading = true;
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
 
 
  
];

   late  List<dynamic> show_historys = [];
  Future<void> show_history() async {
  try {
    setState(() {
      loading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('id').toString();
    var uri = Uri.parse('${MyConstant().domain}/show_history');
    var ressum = await http.post(uri,
        // headers: {
        //   // "Content-Type": "application/json",
        // },
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
    },];
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


late  List<dynamic> product_users = [];
  Future<void> product_user() async {
  try {
    setState(() {
      loading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString('name').toString();
   String user_id = preferences.getString('id').toString();
    var uri = Uri.parse('${MyConstant().domain}/product_user');
    var ressum = await http.post(uri,
        // headers: {
        //   // "Content-Type": "application/json",
        // },
        body: {
           'id_user': user_id
        });
    if (ressum.statusCode == 200) {
      var lnformation = jsonDecode(ressum.body);
      setState(() {
        product_users = lnformation['data'];
        print(product_users);
      // for (var data in lnformation['data']) {
      //   mergedData.addAll(data[0]);
      // }
          //  List<dynamic> combinedData = lnformation['data'].expand((element) => element).toList();

    
      // product_users == product_userss;

       show_history();
      });
    } else {
      setState(() {
            show_history();
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
    product_user();
     show_history();
  }
 late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
         screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return  Scaffold(
      body:  loading ? 
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
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                        Container(
                              margin: const EdgeInsets.only(left: 40,right: 10,top: 20),
                              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                        'assets/home/Rectangle 17.png',
                                      ),
                                ),
                              ),
                            ),


                        
                                       Container(
                                         margin: EdgeInsets.only(top: 20),
                                         child: Text('Name $name',textScaleFactor: 1.0,style: TextStyle(
              // fontFamily: 'IBM',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffFFFFFF),
            ),),
                                       ),
                                     
                                    
                           GestureDetector(
                             onTap: () async{
                                 var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Account_Settings() ),);
                                 if (navigationResult == null ) {

                                 }
                             },
                             child: Container(
                               
                                decoration: BoxDecoration(
                                      
                                           shape: BoxShape.circle,
                                         ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 20),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                          'assets/images/Rectangle95.png',
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
           SingleChildScrollView(physics: BouncingScrollPhysics(),
             child: Padding(
               padding: const EdgeInsets.all(30.0),
               child: Container(
                 child: Column(
                   children: [
                         Container(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                             Container(
                               margin: EdgeInsets.only(bottom: 15),
                               child: Row(
                                 children: [
                                   Container(
                                     margin: EdgeInsets.only(right: 10),
                                     child: Image.asset('assets/images/icons8-bullet-list-100 4.png',
                                     height: 18,),
                                   ),
                                   Container(
                                     child: Text('การซื้อของฉัน',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                   ),
                                 ],
                               ),
                             ),
                             InkWell(
                               onTap: () async{
                                    Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Order(status:{
       'id': 1,
      'nameTH':'ที่ต้องชำระ',
       'nameEN':'Awaiting payment',
    },) ),);
                                 if (navigationResult != null ) {

                                 }
                               },
                               child: Container(
                                 child: Row(
                                   children: [
                                  
                                     Container(
                                       child: Text('ประวัติการซื้อ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
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
                           ],),
                         ),
                       Container(
                        child: Row(
                          children: [
                            Expanded(child: GestureDetector(
                                 onTap: () async{
                                     var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Order(status: {
       'id': 1,
      'nameTH':'ที่ต้องชำระ',
       'nameEN':'Awaiting payment',
    },) ),);
                                 if (navigationResult != null ) {

                                 }
                                 },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                       
                                        Container(
                                             margin: EdgeInsets.only(bottom: 10),
                                             child: Image.asset('assets/images/icons8-open-box-100 (2) 2.png',
                                             height: 24,),
                                           ),
                                           imgList[0]['NO'] == 0 ? Container(
                                          width: 12,
                                          height: 12,
                                          
                                         
                                        )
                                          :  Container(
                                          width: 12,
                                          height: 12,
                                          
                                          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
                                        ),
                                      ],
                                    ),
                                     Container(
                                         child: Text('ที่ต้องชำระ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                       ),  
                                  ]),
                                ),
                              ),
                            ),),
                           Expanded(child:  GestureDetector(
                                 onTap: () async{
                                     var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Order(status: {
       'id': 2,
      'nameTH':'ที่ต้องจัดส่ง',
       'nameEN':'Awaiting delivery',
    },) ),);
                                 if (navigationResult != null ) {

                                 }
                                 },
                             child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(children: [
                                    Stack(
                                       alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                             margin: EdgeInsets.only(bottom: 10),
                                             child: Image.asset('assets/images/icons8-package-delivery-logistics-100 2.png',
                                             height: 24,),
                                           ),
                                            imgList[1]['NO'] == 0 ?Container(
                                          width: 12,
                                          height: 12,
                                          
                                         
                                        )
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
                                     Container(
                                         child: Text('ที่ต้องจัดส่ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                       ),  
                                  ]),
                                ),
                              ),
                           ),),
                          Expanded(child:  GestureDetector(
                                 onTap: () async{
                                     Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Order(status:    {
       'id': 3,
      'nameTH':'ที่ต้องได้รับ',
       'nameEN':'Awaiting received',
    },) ),);
                                 if (navigationResult != null ) {

                                 }
                                 },
                            child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(children: [
                                    Stack(
                                       alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                             margin: EdgeInsets.only(bottom: 10),
                                             child: Image.asset('assets/images/icons8-truck-100 2.png',
                                             height: 24,),
                                           ),
                                          imgList[2]['NO'] == 0 ? Container(
                                          width: 12,
                                          height: 12,
                                          
                                         
                                        )
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
                                     Container(
                                         child: Text('ที่ต้องได้รับ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                       ),  
                                  ]),
                                ),
                              ),
                          ),),
                          ],
                        )
                       ),  
                     Container(
                          margin: EdgeInsets.only(top: 25),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                             Container(
                               margin: EdgeInsets.only(bottom: 15),
                               child: Row(
                                 children: [
                                   Container(
                                     margin: EdgeInsets.only(right: 10),
                                     child: Image.asset('assets/images/icons8-bullet-list-100 4.png',
                                     height: 18,),
                                   ),
                                   Container(
                                     child: Text('ซื้ออีกครั้ง',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                   ),
                                 ],
                               ),
                             ),
                             InkWell(
                               onTap: () async{
                                     var navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Buy_Again(index:1) ),);
                                 if (navigationResult != null ) {

                                 }
                               },
                               child: Container(
                                                         
                                 child: Row(
                                   children: [
                                  
                                     Container(
                                       child: Text('ดูเพิ่มเติม',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
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
                           ],),
                         ),
           
                    Container(
                                  height: 160,
                                   margin: EdgeInsets.only(left: 25),
                                  child: ListView.builder(
                                     physics: BouncingScrollPhysics(),
                                     
                                     scrollDirection: Axis.horizontal,
                                                            shrinkWrap: true,
                                                            itemCount: product_users.length > 5 ?5:product_users.length,
                                   itemBuilder: (context, index)  {
                                     return Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: GestureDetector(
                                         onTap: () async{
                                             var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>ProductS(id_product: product_users[index]['id_product'],name: product_users[index]['type'],) ),);
                                 if (navigationResult == null ) {
                                     product_user();
                                 }
                                         },
                                         child: Container(
                                                              height: 160,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                color: Color(0xFFF5F5F5),
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 10,left: 10),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment:MainAxisAlignment.center,
                                                                  children: [
                                                                    Image.network(
                                                                          '${MyConstant().domain2}/${product_users[index]['path_img']}',
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text('${product_users[index]['name']}',textScaleFactor: 1.0,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          maxLines: 2,
                                                                          style: TextStyle(
                                                                                                                // fontFamily: 'IBM',
                                                                                                                fontSize: 14,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                color: Colors.black,
                                                                                                              ),),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                           Expanded(
                                                                             child: Column(
                                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                                               children: [
                                                                                  Text('${product_users[index]['sale_price']} ฿',maxLines:1,textScaleFactor: 1.0,style: TextStyle(
                                                                                                                   // fontFamily: 'IBM',
                                                                                                                   fontSize: 14,
                                                                                                                   overflow: TextOverflow.ellipsis,
                                                                                                                   fontWeight: FontWeight.w600,
                                                                                                                   color: Color(0xffBA1F23),
                                                                                                                 ),),
                                                                                    Text('${product_users[index]['price']} ฿',maxLines:1,textScaleFactor: 1.0,style: TextStyle(
                                                                                                                   // fontFamily: 'IBM',
                                                                                                                     overflow: TextOverflow.ellipsis,
                                                                                                                         decoration: TextDecoration.lineThrough,
                                                                                                                         decorationColor: Color(0xFF989898),
                                                                                                                   fontSize: 11,
                                                                                                                   fontWeight: FontWeight.w400,
                                                                                                                   color: Color(0xff979696),
                                                                                                                 ),), 
                                                                               ],
                                                                             ),
                                                                           ),
                                                                             GestureDetector(
                                              
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
                                       ),
                                     );
                                   }
                                                 ),
                                ),    
                       Line('icons8-user-100 (1) 2.png','ตั้งค่าบัญชี',() async{
                             var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Settings() ),);
                                 if (navigationResult != null ) {

                                 }
                         },),   
                       Line('icons8-user-100 (1) 3.png','Google Map',() async{
                             var  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>GoogleMap2() ),);
                                 if (navigationResult != null ) {

                                 }
                         },),   
                       Line('icons8-user-100 (1) 4.png','แบบสอบถาม',() async{
                            //  Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                            //              builder: (_) =>Account_Settings() ),);
                            //      if (navigationResult != null ) {

                            //      }
                         },),           
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

  Container Line(var img,name,Function()? onTap) {
    return Container(
                      margin: EdgeInsets.only(top: 10),
                       child: InkWell(
                         onTap: onTap,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                               
                                     Container(
                                       margin: EdgeInsets.only(right: 10),
                                       child: Image.asset('assets/images/$img',
                                       height: 18,),
                                     ),
                                     Container(
                                       child: Text('$name',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff1E1E1E), fontSize: 12,fontWeight: FontWeight.w400),),
                                     ),
                                   ],
                                 
                               
                              
                             ),
                               Container(
                                   
                                       child: Image.asset('assets/images/Line 5.png',
                                       height: 18,),)
                           ],
                         ),
                       ),
                     );
  }
}