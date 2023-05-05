import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class ConvertLatLangToAdress extends StatefulWidget {
  const ConvertLatLangToAdress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLangToAdress> createState() => _ConvertLatLangToAdressState();
}

class _ConvertLatLangToAdressState extends State<ConvertLatLangToAdress> {
 String stAddress='',stAdd='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Google Map'),
        centerTitle: true,
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          GestureDetector(
            onTap:()async{
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
              //final query = "1600 Amphiteatre Parkway, Mountain View";


             // final coordinates=new Coordinates(25.361064, 68.350958);

              setState(() {
                stAddress=locations.last.latitude.toString()+" "+locations.last.longitude.toString();
                stAdd=placemarks.reversed.last.country.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height:50,
                decoration: BoxDecoration(
                  color:Colors.green
                ),
                child: Center(
                  child:Text('Convert')
                ),
              ),
            ),
          )
        ],
    )
    );
  }
}
