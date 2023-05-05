import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = [
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLang.length; i++) {
      if(i%2==0){
        _markers.add(Marker(
            onTap: () {
              customInfoWindowController.addInfoWindow!(
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Center(child:CircleAvatar(radius: 30,backgroundColor: Colors.blue,)),
                  ),
                  _latLang[i]);
            },
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLang[i]));
      }
      else{_markers.add(Marker(
          onTap: () {
            customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width:300,
                            height:100,
                            decoration:const BoxDecoration(
                                image: DecorationImage(image: NetworkImage('https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                    fit: BoxFit.fitWidth,
                                    filterQuality: FilterQuality.high
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.red


                            )

                        )
                      ]),
                ),
                _latLang[i]);
          },
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _latLang[i]));
      }}

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Custom Info Window Screen'),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(zoom: 14, target: LatLng(33.6941, 72.9734)),
              markers: Set<Marker>.of(_markers),
              onTap: (position) {
                customInfoWindowController!.hideInfoWindow;
              },
              onMapCreated: (GoogleMapController controller) {
                customInfoWindowController.googleMapController = controller;
              },
              onCameraMove: (position) {
                customInfoWindowController.onCameraMove;
              },
            ),
            CustomInfoWindow(
              controller: customInfoWindowController,
              height: 300,
              width: 300,
              offset: 35,
            )
          ],
        ));
  }
}
