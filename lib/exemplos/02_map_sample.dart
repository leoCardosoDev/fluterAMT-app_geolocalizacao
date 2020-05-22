import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
 Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text('Mapas e Geolocalização'),
     ),
     body: Container(
      child: GoogleMap(
       mapType: MapType.normal,
       initialCameraPosition: CameraPosition(
        target: LatLng(-23.562436, -46.655005),
        zoom: 16,
       ),
       onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
       },
      ),
     ),
    );
  }
}
