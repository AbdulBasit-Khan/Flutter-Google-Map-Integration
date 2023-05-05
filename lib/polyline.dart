import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({Key? key}) : super(key: key);

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.738045, 73.084488),
    zoom: 14,
  );
  final Set<Marker> _markers={};
  final Set<Polyline> _polyline={};
  List<LatLng> latlng=[

    LatLng(33.738045, 73.084488),
    LatLng(25.3960, 68.3578),

    LatLng(33.567997728, 72.635997456)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<latlng.length;i++){
    _markers.add(
      Marker(markerId: MarkerId(i.toString()),
      position: latlng[i],
          icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title:"Really cool place",
          snippet: "5 star rating"

        )

      )
    ) ;
    setState(() {
      
    });
    _polyline.add(Polyline(polylineId:PolylineId('1'),
        color: Colors.orange
        ,
        points: latlng
    ));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle:true,title: Text('Polyline'),),
      body:GoogleMap(initialCameraPosition: _kGooglePlex,
       markers: _markers,
        onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
        },
        myLocationEnabled: true,
        polylines: _polyline,
      )
    );
  }
}
