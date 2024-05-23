import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../my_constant.dart';
 import 'package:http/http.dart' as http;

import '../Home/home.dart';
import '../Home/vdo.dart';
import 'Information.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
 late  List<dynamic> data = [];
 String name = '',logo = '';
 bool loading = true;

  Future<void> show_news() async {
    try {
      setState(() {
        loading = true;
      });
       SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
           name = preferences.getString('name').toString();
            logo = preferences.getString('logo').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_news');
       var ressum = await http.get(uri
       ,headers: {
       "Authorization":access_token
      }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         
       
         data =lnformation['data']['data'];
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
    show_news();
  }
 late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
         screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return  Scaffold(
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
                                   height: 60,
                                  width: 60,
                                  child: logo == '' || logo == 'null' ?Image.asset(
                                        'assets/home/Rectangle 17.png',
                                      ):ClipRRect(  borderRadius: BorderRadius.circular(50),child: Image.network(logo)),
                                ),
                              ),
                            ),


                        
                                         Container(
                                            margin: const EdgeInsets.only(left: 0,right: 0,top: 20),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Container(
                                         child: Text('$name',style: TextStyle(
              // fontFamily: 'IBM',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffFFFFFF),
            ),),
                                       ),
                                       Container(
                                         child: Text('ข่าวสาร',style: TextStyle(
              // fontFamily: 'IBM',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFFFFF),
            ),),
                                       ),
                                     ],
                                   ),
                                 ),
                                     
                                    
                               
                       ],
                     ),
                      
                    ),
                  ),
           Expanded(child: 
              ListView.builder(
                                     physics: BouncingScrollPhysics(),
                                     
                                  
                                                            shrinkWrap: true,
                                                            itemCount: data.length,
                                   itemBuilder: (context, index)  {
                                   
                 return InkWell(
                   onTap: () async{
                        Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Message_Information(data: data[index],) ),);
                                 if (navigationResult == null ) {

                                 }
                   },
                   child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 0,left: 30),
                                    child: Row(
                                      children: [
                                         Container(
                                                           height: 140,
                                                          width: 140,
                                                          child: ClipRRect(
                                         borderRadius: BorderRadius.circular(10),
                                                            child: data[index]['image'].toString() == 'null'? GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => VideoPlayerScreen(videoUrl: '${MyConstant().domain2}/upload/news/${data[index]['video']}'),
                     ),
                   );
                                                              },
                                                              child: VideoPlayerItem(videoUrl: '${MyConstant().domain2}/upload/news/${data[index]['video']}'),
                                                            ):Image.network('${MyConstant().domain2}/upload/news/${data[index]['image']}'),
                                                          
                                                          ),
                                                        ),  
                 
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text('${data[index]['title']}',textScaleFactor: 1.0,style: TextStyle(
                                                  fontSize: 14,fontWeight: FontWeight.w500
                                                ),),
                                              ),
                                             Container(
                                                child: Text('${data[index]['date']}',textScaleFactor: 1.0,style: TextStyle(
                                                  fontSize: 8,fontWeight: FontWeight.w500,color: Color(0xff979696),
                                                ),),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 10),
                                               width: MediaQuery.of(context).size.width*0.56,
                                                child: Text('${data[index]['detail']}',textScaleFactor: 1.0,style: TextStyle(
                                                  fontSize: 10,fontWeight: FontWeight.w500
                                                ),),
                                              ),
                                            ],
                                          ),
                                        )                
                                      ],
                                    ),
                                  ),
                                ),
                 );
               }
             ))       
          ],
        ),
      ),
    );
  }
}