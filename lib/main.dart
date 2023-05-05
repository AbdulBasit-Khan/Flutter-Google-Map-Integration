import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/convert_latlang_to_adress.dart';
import 'package:googlemap/custom_marker_info_window.dart';
import 'package:googlemap/custom_marker_screen.dart';
import 'package:googlemap/google_places_api.dart';
import 'package:googlemap/home_screen.dart';
import 'package:googlemap/network_image_marker.dart';
import 'package:googlemap/polygone_screen.dart';
import 'package:googlemap/polyline.dart';
import 'package:googlemap/style_googlemap_screen.dart';
import 'package:googlemap/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const StyleGoogleMapScreen(),
    );
  }
}


