import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  Uint8List? markerImage;
  final Completer<GoogleMapController> _controller =Completer();
  List<String> images =['images/car.png','images/car.png'];
  final List<Marker> _markers=<Marker>[

  ];
  final List<LatLng> _latLang =<LatLng>[
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
  ];
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 14,
  );
  Future<Uint8List> getBytesFromAssets(String path,int width)async{
  ByteData data=await rootBundle.load(path);
  ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(),targetWidth: width);
  ui.FrameInfo fi=await codec.getNextFrame();
  return(await fi.image.toByteData(format:ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData()async{
  for(int i=0;i<images.length;i++){
    final Uint8List markerIcon=await getBytesFromAssets(images[i], 100);
    _markers.add(
    Marker(markerId: MarkerId(i.toString()),
    position:_latLang[i],
      icon:BitmapDescriptor.fromBytes(markerIcon),
      infoWindow: InfoWindow(
        title:'This is title marker'+i.toString()
      )
    )
  );
  setState(() {

  });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SafeArea(
       child:GoogleMap(initialCameraPosition: _kGooglePlex,
       myLocationEnabled: true,
       markers: Set<Marker>.of(_markers),
       myLocationButtonEnabled: true,
       onMapCreated: (GoogleMapController controller){
         _controller.complete(controller);
       },
       )
     )
    );
  }
}
