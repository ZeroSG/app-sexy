import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../my_constant.dart';
 import 'package:http/http.dart' as http;

import '../Home/home.dart';
import '../Home/vdo.dart';

class Message_Information extends StatefulWidget {
   Map<String, dynamic>? data ;
   Message_Information({super.key,this.data});

  @override
  State<Message_Information> createState() => _Message_InformationState();
}

class _Message_InformationState extends State<Message_Information> {
 late   Map<String, dynamic>? nows = widget.data;
 
 
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(nows!['video'].toString() == 'null'){
     
    }else{
      _controller = VideoPlayerController.networkUrl(Uri.parse(
        '${MyConstant().domain2}/upload/news/${nows!['video']}'))
      ..initialize().then((_) {
         _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
         
        });
      });
    }
     
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 late double screenW, screenH;
  @override
  Widget build(BuildContext context) {
         screenW = MediaQuery.of(context).size.width;
    screenH = MediaQuery.of(context).size.height;
    return  Scaffold(
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
       
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Container(
                 alignment: Alignment.center,
                  child: Text('ข่าวสาร : ${nows!['title']}',style: TextStyle(
                // fontFamily: 'IBM',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 0, 0, 0),
              ),),
                                         ),
              Container(
                margin: EdgeInsets.only(top: 15),
                 alignment: Alignment.center,
                  child: Text('${nows!['date']}',style: TextStyle(
                // fontFamily: 'IBM',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 0, 0, 0),
              ),),
                                         ),
             Container(
              //  margin: EdgeInsets.only(top: 20,right: 20,left: 20),
               child: 
              nows!['video'].toString() == 'null'? Container(
                height: 200,
                width: 300,
                child: Image.network('${MyConstant().domain2}/upload/news/${nows!['image']}')):
             _controller.value.isInitialized
              ? Container(
                 height: 200,
                width: 400,
                child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
              ): Container(),)
              ,  
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Container(
                   alignment: Alignment.topLeft,
                    child: Text('${nows!['detail']}',style: TextStyle(
                  // fontFamily: 'IBM',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 0, 0, 0),
                             ),),
                                           ),
               ),                            
            ],
          ),
        ),
      ),
    );
  }
}