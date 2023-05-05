import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  TextEditingController _controller=TextEditingController();
  var uuid=Uuid();
  String _sessionToken='1234';
  List<dynamic> placesList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });

  }
  void onChange(){
    if(_sessionToken==null){
      setState(() {
        _sessionToken=uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }
  void getSuggestion(String input)async{
    String kPLACES_API_KEY="AIzaSyA6K63yCT3xavWYWlZXs2w_ZjpPQx3qHg8";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response =await http.get(Uri.parse(request));
    var data=response.body.toString();
    print('data');
    print(data);
    print(response.body.toString());
    if(response.statusCode==200){
   setState(() {
     placesList=jsonDecode(response.body.toString())['predictions'];
   });
    }
    else{
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Google Search Places Api'),
        
      ),
      body:Padding(padding: const EdgeInsets.symmetric(vertical:12),
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search places with name'
            ),
          ),
          Expanded(child: ListView.builder(itemCount:placesList.length,itemBuilder: (context,index){
           return ListTile(
             onTap: ()async{
               List<Location> locations = await locationFromAddress(placesList[index]['description']);
               print(locations.last.longitude);
               print(locations.last.latitude);
             },
             title:Text(placesList[index]['description'])
           );
          }))
        ],
      ),
      ),

    );
  }
}
