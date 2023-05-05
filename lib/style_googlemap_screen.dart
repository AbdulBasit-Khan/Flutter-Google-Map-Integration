import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  final Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(25.415906, 68.310725),
    zoom: 14,
  );
  String mapTheme='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/map_theme/night_theme.json').then((value) {
    mapTheme=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title:Text('Maps Theme'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_horiz),
              itemBuilder: (context) => [
            PopupMenuItem(child: Text('Silver'),
            onTap: (){
              _controller.future.then((value) {
                DefaultAssetBundle.of(context).loadString('assets/map_theme/silver_theme.json').then((string) {
                  value.setMapStyle(string);
                });
              } );
            },
            ),
            PopupMenuItem(child: Text('Night'),
              onTap: (){
                _controller.future.then((value) {
                  DefaultAssetBundle.of(context).loadString('assets/map_theme/night_theme.json').then((string) {
                    value.setMapStyle(string);
                  });
                } );
              },
            ),
            PopupMenuItem(child: Text('Retro'),
              onTap: (){
                _controller.future.then((value) {
                  DefaultAssetBundle.of(context).loadString('assets/map_theme/retro_theme.json').then((string) {
                    value.setMapStyle(string);
                  });
                } );
              },
            ),
          ])
        ],
      ),
      body: SafeArea(child: GoogleMap(initialCameraPosition: _kGooglePlex,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller){
         controller.setMapStyle(mapTheme);
        _controller.complete(controller);
        },
      )),
    );
  }
}
