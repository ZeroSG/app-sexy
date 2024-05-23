import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sexy/Widget/Menu/Home/vdo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../Style/style.dart';
import '../../../my_constant.dart';
import '../account/buy_again.dart';
import '../message/Information.dart';
import '../product/basket.dart';
 import 'package:http/http.dart' as http;

import '../product/productS.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int num=0;
    late  List<dynamic> imgList = [

];
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
 late  List<dynamic> data = [];
 String name = '',logo = '';
 bool loading = true;
Future<void> data_banner() async {
    try {
      setState(() {
        loading = true;
      });
        SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
           name = preferences.getString('name').toString();
           logo = preferences.getString('logo').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_dashboard');
       var ressum = await http.get(uri,
       headers: {
       "Authorization":access_token
      }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         
         imgList  =lnformation['data']['banner'];
         data =lnformation['data']['data'];
              
         print(lnformation['data']['banner']);
       show_news();
         
        });
          // data_promotion_stores();
    }else {
      show_news();
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


 late  List<dynamic> news = [];
  Future<void> show_news() async {
    try {
      setState(() {
        loading = true;
      });
        SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
           name = preferences.getString('name').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_news');
       var ressum = await http.get(uri,
       headers: {
       "Authorization":access_token
      }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         
       
         news =lnformation['data']['data'];
                 show_product();
      
       
         
        });
          // data_promotion_stores();
    }else {
      show_product();
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }


 late  List<dynamic> type_animal = [];
  Future<void> show_product() async {
    try {
      setState(() {
        loading = true;
      });
         SharedPreferences preferences = await SharedPreferences.getInstance();
       String access_token = preferences.getString('access_token').toString();
       String id_warehousecode = preferences.getString('id_warehousecode').toString();
      var uri = Uri.parse('${MyConstant().domain}/show_product');
       var ressum = await http.post(uri,
       headers: {
       "Authorization":access_token
      },
       body: {
         'id_warehousecode': '$id_warehousecode'
       }
            );
              
      if(ressum.statusCode == 200){
          var  lnformation  = jsonDecode(ressum.body);

        setState(() {
         
         type_animal  =lnformation['data']['type_animal'];
 



         loading = false;

       
         
        });
          // data_promotion_stores();
    }else {
       loading = false;
      //  data_promotion_stores();
    }
    } catch (e) {
      print('e ===>1 ${e.toString()} ');
    }
  }

     void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
     data_banner();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

late TextEditingController _searchController = TextEditingController(); 
 late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
         screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: loading ? 
                        Container(
                width: screenW * 1,
                height: screenW * 1,
                child: Center(child: CircularProgressIndicator())):Container(
        child: Stack(
          children: [
            // Container(
            //   color: Colors.black,
            //   height: 300,
            //   width: MediaQuery.of(context).size.width*1,

            // ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(80),
                bottomLeft: Radius.circular(80),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFBD2325), Color(0xFFE05C45)],
                  ),
                ),
                height: 250,
                width: MediaQuery.of(context).size.width * 1,
              ),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                     Padding(
                      padding:  EdgeInsets.only(right: 44,left: 44,top :0,bottom: 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                              Container(
                             
                              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(0.0),
                                child:  Container(
                                  height: 60,
                                  width: 60,
                                  child: logo == '' || logo == 'null' ?
                                  Image.asset(
                                        'assets/home/Rectangle 17.png',
                                      ):ClipRRect(  borderRadius: BorderRadius.circular(50),child: Image.network(logo)),
                                ),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                                 Container(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         child: Text('สวัสดี  $name',style: TextStyle(
              // fontFamily: 'IBM',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffFFFFFF),
            ),),
                                       ),
                                       Container(
                                         child: Text('เริ่มดูสินค้ากันเลย!',style: TextStyle(
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
                             GestureDetector(
                               onTap: () async{
                                  Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Basket() ),);
                                 if (navigationResult == null ) {

                                 }
                               },
                               child: Container(
                                                        
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
                      )),
                    Padding(
                      padding:  EdgeInsets.only(right: 44,left: 44,top :0,bottom: 10),
                      child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xffEFEFEF), width: 1),
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffEFEFEF).withOpacity(0.43),
                          ),
                          height: 40,
                          margin: EdgeInsets.only(top: 16),
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
                              hintText: 'คุณกำลังมองหาสินค้าอะไร',
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
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.75,
                        initialPage: num,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
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
                      items: imgList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                 newindex1(context,'${MyConstant().domain2}/upload/recommend/${i['path']}');
                                // Navigator.push( 
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => FullPhotoPage(url: '$i'),
                                //   ),
                                // );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    shadowColor: Color(0xFFBA1F23).withOpacity(0.27),
                                      shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                               elevation: 10,
                                    child: Container(
                                        height: 160,
                                        width: 357,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.network(
                                            '${MyConstant().domain2}/upload/recommend/${i['path']}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                  ),
                                ),
                                
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8,bottom: 5),
                      height: 10,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: imgList.length,
              
                          //   separatorBuilder:  (context, index) {
              
                          //   return const SizedBox(width: 2,);
              
                          // },
              
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: num == index
                                    ? Color(0xFFBA1F23)
                                    : Color(0xFFD34739).withOpacity(0.54),
                              ),
              
                              width: num == index ? 40 : 10,
                              // child: Image.asset(category.image),
                            );
                          }),
                    ),
                    Expanded(
                      child:Container(
                        margin: EdgeInsets.only(bottom: 80),
                        child: SingleChildScrollView(physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 40,top: 20,bottom: 5),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text('หมวดหมู่',textScaleFactor: 1.0,style:  TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.w600
                                  ),),
                                ),
                                Container(
                                  height: 90,
                                   margin: EdgeInsets.only(left: 25,right: 25),
                                  child: ListView.builder(
                                     physics: BouncingScrollPhysics(),
                                     scrollDirection: Axis.horizontal,
                                                            shrinkWrap: true,
                                                            itemCount: type_animal.length > 3 ?4:3,
                                   itemBuilder: (context, index)  {
                                     return Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: index == 3 ? Container(
                                           height: 80,
                                           width: 80,
                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Color(0xffBD2325), width: 1),
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: Center(child:Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                               
                                                                Container(
                                          child: Image.asset(
                                            'assets/images/icons8-more-100 1.png',
                                            // width:double.infinity,
                                            width: 27,
                                            height: 27,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text('ทั้งหมด',textScaleFactor: 1.0,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),)
                                                              ],
                                                            ) 
                                                            ),
                                       )
                                       : InkWell(
                                           onTap: () async{
                                    Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Buy_Again(index:2,id_type_animal:type_animal[index]['id'].toString(),id_type_animalname:type_animal[index]['name'].toString()) ),);
                                 if (navigationResult != null ) {

                                 }
                               },
                                         child: Container(
                                                              height: 80,
                                                              width: 80,
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
                                                                    Text('${type_animal[index]['name']}',textScaleFactor: 1.0,style: TextStyle(
                                          // fontFamily: 'IBM',
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffFFFFFF),
                                                                             ),),
                                                                  ],
                                                                ),
                                                              ),
                                                              
                                                            ),
                                       ),
                                     );
                                   }
                                                 ),
                                ),
                                Padding(
                            padding: const EdgeInsets.only(right: 40,left: 40,top: 10,bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                       
                                        child: Text('สินค้าแนะนำ',textScaleFactor: 1.0,style: TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.w600
                                        ),),
                                      ),
                          
                               Container(
                                                   height: 25,
                                                  width: 25,
                                                  child: Image.asset(
                                                        'assets/images/Rectangle 96.png',
                                                      ),
                                                ),       
                              ],
                            ),
                          ),
                                Container(
                                  height: 160,
                                   margin: EdgeInsets.only(left: 25),
                                  child: ListView.builder(
                                     physics: BouncingScrollPhysics(),
                                     
                                     scrollDirection: Axis.horizontal,
                                                            shrinkWrap: true,
                                                            itemCount: data.length > 5 ?5:data.length,
                                   itemBuilder: (context, index)  {
                                     return Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: GestureDetector(
                                         onTap: () async{
                                             Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>ProductS(id_product: data[index]['id_product_amount'],name:data[index]['type']) ),);
                                 if (navigationResult == null ) {
                                     data_banner();
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
                                                                          '${MyConstant().domain2}/${data[index]['path_img']}',
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text('${data[index]['size_name']} (${data[index]['name']})',textScaleFactor: 1.0,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          maxLines: 1,
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
                                                                                  Text('${data[index]['sale_price']} ฿',maxLines:1,textScaleFactor: 1.0,style: TextStyle(
                                                                                                                   // fontFamily: 'IBM',
                                                                                                                   fontSize: 14,
                                                                                                                   overflow: TextOverflow.ellipsis,
                                                                                                                   fontWeight: FontWeight.w600,
                                                                                                                   color: Color(0xffBA1F23),
                                                                                                                 ),),
                                                                                    Text('${data[index]['price']} ฿',maxLines:1,textScaleFactor: 1.0,style: TextStyle(
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
                          
                          Padding(
                            padding: const EdgeInsets.only(right: 40,left: 40,top: 10,bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                       
                                        child: Text('ข่าวสาร',textScaleFactor: 1.0,style: TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.w600
                                        ),),
                                      ),
                          
                               Container(
                                                   height: 25,
                                                  width: 25,
                                                  child: Image.asset(
                                                        'assets/images/Rectangle 96.png',
                                                      ),
                                                ),       
                              ],
                            ),
                          ),
                              ListView.builder(
                                     physics: BouncingScrollPhysics(),
                                     
                                  
                                                            shrinkWrap: true,
                                                            itemCount: news.length > 1 ?1:news .length,
                                   itemBuilder: (context, index)  {
                                   
                 return InkWell(
                   onTap: () async{
                        Map<String, dynamic>  navigationResult = await Navigator.push(context,MaterialPageRoute(
                                         builder: (_) =>Message_Information(data: news[index],) ),);
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
                                                            child: news[index]['image'].toString() == 'null'? GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => VideoPlayerScreen(videoUrl: '${MyConstant().domain2}/upload/news/${news[index]['video']}'),
                     ),
                   );
                                                              },
                                                              child: VideoPlayerItem(videoUrl: '${MyConstant().domain2}/upload/news/${news[index]['video']}'),
                                                            ):GestureDetector(
                                                              onTap: () {
                                                                newindex1(context,'${MyConstant().domain2}/upload/news/${news[index]['image']}');
                                                              },
                                                              child: Image.network('${MyConstant().domain2}/upload/news/${news[index]['image']}')),
                                                          
                                                          ),
                                                        ),  
                 
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text('${news[index]['title']}',textScaleFactor: 1.0,style: TextStyle(
                                                  fontSize: 14,fontWeight: FontWeight.w500
                                                ),),
                                              ),
                                             Container(
                                                child: Text('${news[index]['date']}',textScaleFactor: 1.0,style: TextStyle(
                                                  fontSize: 8,fontWeight: FontWeight.w500,color: Color(0xff979696),
                                                ),),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 10),
                                               width: MediaQuery.of(context).size.width*0.56,
                                                child: Text('${news[index]['detail']}',textScaleFactor: 1.0,style: TextStyle(
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
             )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



    Future<dynamic> nowVDO(BuildContext context) {
    return showDialog(
        barrierColor: Color.fromARGB(255, 148, 174, 149).withOpacity(0.3),
        // barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              // child:  SingleChildScrollView(
              child: Column(
                children: [
               
                  
                         
               
                ],
              ),
              // )
            );
          });
        });
  }
}
class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  VideoPlayerItem({required this.videoUrl});

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}