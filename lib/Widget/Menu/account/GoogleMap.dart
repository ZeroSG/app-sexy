import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class GoogleMap2 extends StatefulWidget {
  String? Urlmaps;
  
   GoogleMap2({super.key,this.Urlmaps});

  @override
  State<GoogleMap2> createState() => _GoogleMap2State();
}

class _GoogleMap2State extends State<GoogleMap2> {
  

  Marker shMarker(LatLng La_Ln){
  return Marker(
    markerId: MarkerId('d'),
    position: La_Ln,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    infoWindow: InfoWindow(title: '${LatLng(13.7933215,100.4958788)}'));
}
  @override
  Widget build(BuildContext context) {
    var googleMap = GoogleMap(
             zoomControlsEnabled    :true,
                       zoomGesturesEnabled     :true,
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              // onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                  target: (LatLng(13.7933215,100.4958788)),
                                  zoom: 15.2),
                             markers: <Marker> [shMarker(LatLng(13.7933215,100.4958788))].toSet(),
                            );
    return  Scaffold(
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
      body: googleMap,
    );
  }
}