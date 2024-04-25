import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Account settings.dart';
import 'address.dart';
import 'tax.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  
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
      body: SingleChildScrollView(
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
                              'ตั้งค่าบัญชี',
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
          Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                'บัญชีของฉัน',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Line('บัญชี',() async{
                             Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Account_Settings() ),);
                                 if (navigationResult != null ) {
                                   
                                 }
                         },),
                           Line('ที่อยู่ของฉัน',() async{
                              Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>address() ),);
                                 if (navigationResult != null ) {

                                 }
                         },),
                          Line('ใบกำกับภาษีของฉัน',() async{
                              Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>tax() ),);
                                 if (navigationResult != null ) {

                                 }
                         },)
            ],)
          ),
        ),
      ),
    );
  }



   Container Line(var name,Function()? onTap) {
    return Container(
                      margin: EdgeInsets.only(top: 10),
                       child: InkWell(
                         onTap: onTap,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                               
                                     Container(
                                       child: Text('$name',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 12,fontWeight: FontWeight.w400),),
                                     ),
                                       Container(
                                     margin: EdgeInsets.only(left: 10),
                                     child: Image.asset('assets/images/Rectangle 96.png',
                                     height: 16,),
                                   ),
                                   ],
                                 
                               
                              
                             ),
                               Container(
                                   
                                       child: Image.asset('assets/images/Line 5.png',
                                       height: 18,),),

                                          
                           ],
                         ),
                       ),
                     );
  }

}
