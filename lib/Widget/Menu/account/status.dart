import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';




class Status extends StatefulWidget {

   Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {


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
      body:  Container(
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
               Container(
                 
                 child: Row(
                          children: [
                            Container(
                              child: Text(
                                'คำสั่งซื้อของฉัน',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
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
         
             
            
           Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 20,bottom: 20),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        // color: Colors.amber,
                                                       child: Row(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                        Container(
                                           margin: EdgeInsets.only(left: 10),
                                           child: Image.asset('assets/images/Rectangle 120.png',
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
                                         child: Text('จัดส่งสำเร็จ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w400),),
                                       ),
                                                Container(
                                         child: Text('วันที่ พ. 29 ธันวาคม 2023',textScaleFactor: 1.0,style: TextStyle(color: Color(0xffD00000), fontSize: 14,fontWeight: FontWeight.w400),),
                                       ),
                                                Container(
                                         child: Text('จัดส่งแบบธรรมดาในประเทศ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w400),),
                                       ),
                                             ],)
                                           ),
                                       ),
                                       ],
                                     ),
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
           Container(
              // decoration: BoxDecoration(
              //               color: Color(0xffBD616E).withOpacity(0.31),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                 Container(
                                   
                                  //  margin: EdgeInsets.only(bottom: 15),
                                   child: 
                                       Container(
                                         child: Text('หมายเลขติดตามพัสดุ',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff979696), fontSize: 14,fontWeight: FontWeight.w400),),
                                       ),
                                     
                                 ),
                                 Container(
                                     child: Row(
                                       children: [
                                      
                                         
                                        Container(
                                         child: Text('1234567890',textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000), fontSize: 14,fontWeight: FontWeight.w400),),
                                       ),
                                      Container(
                                         margin: EdgeInsets.only(left: 10),
                                         child: Image.asset('assets/images/icons8-link-100 1.png',
                                         height: 18,),
                                       ),
                                       ],
                                     ),
                                   ),
                                 
                               ],),
                             ),
                           ),
                           Container(
                child: ListView.builder(
                                           physics: BouncingScrollPhysics(),
                                          //  scrollDirection: Axis.horizontal,
                                                                  shrinkWrap: true,
                                                                  itemCount: 4,
                                         itemBuilder: (context, index)  {
                                            return Container(
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: Text('29 ธันวาคม', textScaleFactor: 1.0, style: TextStyle(color: index != 0?Color(0xff979696):Color(0xff1E1E1E), fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            Container(
              child: Text('16:15', textScaleFactor: 1.0, style: TextStyle(color: index != 0?Color(0xff979696):Color(0xff1E1E1E), fontSize: 12, fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10,top: index != 0 ? 0:5),
        child: Stack(
         alignment: Alignment.topCenter,
          children: [
           
            Container(
                width: 2,
                height: index == 3 ? 10:50, // ตั้งความสูงของเส้นตรงเป็น 10 พิกเซล
                color: Color(0xff979696)
              ),
            Container(
              margin: EdgeInsets.only(top: index != 0 ? 5:0),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index != 0 ?Color(0xff979696):Color(0xff11C739),
              ),
            ),
            
            
          ],
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Text('พัสดุถูกจัดส่งสำเร็จแล้ว', textScaleFactor: 1.0, 
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: index != 0 ?Color(0xff979696):Color(0xff11C739), fontSize: 14, fontWeight: FontWeight.w400)),
        ),
      ),
    ],
  ),
);                    
                                         }))
                                            ],)
                                          ),
                                       
              
                 
            ],)
          ),
        ),
      
    );
  }



 

}
