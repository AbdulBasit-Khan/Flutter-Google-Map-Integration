import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<Marker> _marker =[];
 final List<Marker> _list = const [
  Marker(markerId: MarkerId('1'),
  position: LatLng(25.361064, 68.350958),
    infoWindow: InfoWindow(
      title:'My current loacation'
    )
  ),
   Marker(markerId: MarkerId('2'),
       position: LatLng(25.357255, 68.356447),
       infoWindow: InfoWindow(
           title:'near Akram Biryani'
       )
   )
 ];
  Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(25.361064, 68.350958),
    zoom: 14,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
         markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          },

        ),
      ),
      floatingActionButton:FloatingActionButton(
        child:Icon(Icons.location_disabled_outlined),
        onPressed: ()async{
          GoogleMapController controller= await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(25.357255, 68.356447),zoom: 14),

          ));
          setState(() {

          });
        },
      ) ,

    );
  }
}
