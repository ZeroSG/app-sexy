import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../my_constant.dart';
import 'Home/home.dart';
import 'account/account.dart';
import 'message/message.dart';
import 'product/product.dart';
 import 'package:http/http.dart' as http;


class Menu extends StatefulWidget {
  int? index ;
   Menu({super.key,this.index});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
   late double screenW, screenH;
 

 late int? _index = 0;




  bool L = false;
   late String? logo = '';
    bool loading = true;
    Future<void> show_logo() async {
    try {
      setState(() {
        loading = true;
      });
      var uri = Uri.parse('${MyConstant().domain}/show_logo');
       var ressum = await http.get(uri,
      
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);
    
        setState(() {
         logo  ='https://fern.orangeworkshop.info/sexy/public/upload/logo/${lnformation['data']['data'][0]['path']}';
         routToService(logo);
         
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

   Future routToService(var logo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
 preferences.setString('logo', logo.toString());
setState(() {
  loading = false;
});
         
  }
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show_logo();
    if(widget.index == null){
 
    }else{
       _index = 3;
    }
  }


  
  @override
  Widget build(BuildContext context) {
    

        screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    
    return
    
    DefaultTabController(
        length: 4,
        initialIndex: _index!,
      child: Scaffold(
        
        body: loading ? Center(child: CircularProgressIndicator())
        :getAppV0(_index!),
                
        
         
              
        extendBody: true,
        bottomNavigationBar: Stack(
         alignment :AlignmentDirectional.bottomStart,
            children: [
                Container(
                height: 60,
                width: screenW*1,    
               
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30),),
                    child: Container(
                      decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFBD2325), Color(0xFFE05C45)],
            ),
          ),
                      //  color: Colors.amber,
                        // margin: EdgeInsets.only(top: 3),
                       child: TabBar(
                         indicatorColor :Color(0xFFE05C45),
                  onTap: (x) {
                      setState(() {
                        _index = x;
                        print(_index);
                      });
                    },
                    tabs: [
                      Tab(icon:  Center(
        child: Image(image: AssetImage('assets/menu/icons8-home 2.png',),
        height: 27,
        color: Color(0xFFFFFFFF),
        fit: BoxFit.fill,),
      ), child: Align(
                      alignment: Alignment.center,
                      child: Text('หน้าหลัก',textScaleFactor: 1.0,
                                  style: new TextStyle(
                                    color: Color(0xFFFFFFFF),
                                     fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),),
                    ),iconMargin :EdgeInsets.only(bottom: 1)),

                     Tab(icon:  Center(
        child: Image(image: AssetImage('assets/menu/icons8-windows-11 1.png',),
        height: 27,
        color: Color(0xFFFFFFFF),
        fit: BoxFit.fill,),
      ), child: Align(
                      alignment: Alignment.center,
                      child: Text('สินค้า',textScaleFactor: 1.0,
                                  style: new TextStyle(
                                    color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),),
                    ),iconMargin :EdgeInsets.only(bottom: 1)),

                     Tab(icon:  Center(
        child: Image(image: AssetImage('assets/menu/Group.png',),
        height: 27,
        color: Color(0xFFFFFFFF),
        fit: BoxFit.fill,),
      ), child: Align(
                      alignment: Alignment.center,
                      child: Text('ข่าวสาร',textScaleFactor: 1.0,
                                  style: new TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),),
                    ),iconMargin :EdgeInsets.only(bottom: 1)),

                     Tab(icon:  Center(
        child: Image(image: AssetImage('assets/menu/icons8-user-100 (13) 1.png',),
        height: 27,
        color: Color(0xFFFFFFFF),
        fit: BoxFit.fill,),
      ), child: Align(
                      alignment: Alignment.center,
                      child: Text('บัญชี',textScaleFactor: 1.0,
                                  style: new TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),),
                    ),iconMargin :EdgeInsets.only(bottom: 1)),
                    ]
                       ),
//                        BottomNavigationBar(
//                       type: BottomNavigationBarType.fixed,
//                       currentIndex: _index!,
//                       backgroundColor: Color(0xFFBD2325),
//                       selectedItemColor: Color.fromARGB(255, 255, 255, 255),
//                       unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
//                       selectedFontSize: 10.0,
//                       unselectedFontSize: 10,
                   
//                        onTap: (x) {
                      
//                         setState(() {
//                           _index = x;
                         
//                         });
//                       },
//                       items: <BottomNavigationBarItem>[
//                         BottomNavigationBarItem(
//                           icon: Image.asset('assets/menu/Group.png',
//                           color: Colors.white,
//                               height: 25, width: 25, fit: BoxFit.fill),
//                           // icon: Image.asset('assets/images/menu/icon-home.png'),
//                           label: "หน้าหลัก",
//                         ),
//                         BottomNavigationBarItem(
//                           icon: Image.asset('assets/menu/Group.png',
//                          color: Colors.white,
//                               height: 25, width: 25, fit: BoxFit.fill,),
//                           label: "สินค้า",
                          
                          
//                         ),
//                         BottomNavigationBarItem(
//                           // icon: SvgPicture.asset('assets/images/menu/icon-chat.svg',
//                           //     height: 25, width: 25, fit: BoxFit.scaleDown),
//                           icon: Image.asset('assets/menu/Group.png', 
//                                  color: Colors.white,  height: 25, width: 25, fit: BoxFit.fill,),
//                           label: "ข่าวสาร",
//                         ),
//                         BottomNavigationBarItem(
                          
//                          icon: Image.asset('assets/menu/Group.png',
// color: Colors.white,                              height: 25, width: 25, fit: BoxFit.fill),
//                           label: "บัญชี",
//                         ),
                       
//                       ]),
                    ),
                 
                ),
              ),
              
           
               
            ],
          )

        
      ),
    );
  }

}

 

  Widget getAppV0(int index){
  switch(index){
    case 0:
    return  Home();
     case 1:
    return   Product();
     case 2:
    return  Message();
    case 3:
    return  Account();

  }
return Container();
}