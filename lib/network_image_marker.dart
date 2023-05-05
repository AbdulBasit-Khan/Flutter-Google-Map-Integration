import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageCustomMarker> createState() => _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(25.415906, 68.310725),
    zoom: 14,
  );
  final List<Marker> _markers=<Marker>[];
  List<LatLng> latlng=[
    LatLng(25.415906, 68.310725),
    LatLng(25.393500, 68.370807),
    LatLng(25.401912, 68.341989),
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Future<Uint8List?> loadNetworkImage(String path)async{
  final completer=Completer<ImageInfo>();
  var image=NetworkImage(path);
  image.resolve(ImageConfiguration()).addListener(
    ImageStreamListener((info,_) {
     completer.complete(info);
    })
  );
  final imageInfo=await completer.future;
  final byteData=await imageInfo.image.toByteData(format:ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
  loadData()async{
  for(int i=0;i<latlng.length;i++){
    Uint8List? image=await loadNetworkImage('https://images.pexels.com/photos/10394207/pexels-photo-10394207.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load');
    final ui.Codec markerImageCodec=await ui.instantiateImageCodec(
      image!.buffer.asUint8List(),
      targetHeight: 100,
      targetWidth: 100,
    );
    final ui.FrameInfo frameInfo=await markerImageCodec.getNextFrame();
    final ByteData? byteData=await frameInfo.image.toByteData(
      format:ui.ImageByteFormat.png
    );
    final Uint8List resizedImageMarker=byteData!.buffer.asUint8List();
    _markers.add(Marker(
      markerId:MarkerId(i.toString()),
      position: latlng[i],
      icon:BitmapDescriptor.fromBytes(resizedImageMarker),
      infoWindow: InfoWindow(
       title: 'Title of marker'+i.toString()
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
      body:SafeArea(child: GoogleMap(initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
        },
        mapType: MapType.normal,
        
      ))
    );
  }
}
