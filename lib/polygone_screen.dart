import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
   const PolygoneScreen({Key? key}) : super(key: key);

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.629402, 73.161562),
    zoom: 14,
  );


  final Set<Marker> _markers={};
  Set<Polygon> _polygone=HashSet<Polygon>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _polygone.add(Polygon(polygonId: PolygonId('1'),points: _points,
   fillColor: Colors.red.withOpacity(0.3),

     geodesic: true,
     strokeWidth: 4,
     
     strokeColor: Colors.deepOrange
   ));
  }
  List<LatLng> _points=[
    LatLng(33.629402, 73.161562),

    LatLng(33.667699, 72.717303
    ),
    LatLng(33.465733, 72.788027),
    LatLng(33.629402, 73.161562)

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Polygon')),
      body:GoogleMap(initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,
        myLocationButtonEnabled: true,
         polygons: _polygone,
        onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
        },
      ),
    );
  }
}
