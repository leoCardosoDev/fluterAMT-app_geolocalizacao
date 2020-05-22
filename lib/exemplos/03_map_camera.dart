import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCamera extends StatefulWidget {
  @override
  _MapCameraState createState() => _MapCameraState();
}

class _MapCameraState extends State<MapCamera> {
 
  Completer<GoogleMapController> _mapController = Completer();
  _onMapCreated(GoogleMapController mapController) {
    _mapController.complete(mapController);
  }

  _moveCamera() async {
   GoogleMapController googleMapController = await _mapController.future;
   googleMapController.animateCamera(
    CameraUpdate.newCameraPosition(
     CameraPosition(
      target: LatLng(-23.562436, -46.655005),
      zoom: 16,
      tilt: 0,
      bearing: 270,
     )
    )
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Câmera'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: _moveCamera,
        child: Icon(Icons.camera),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          //mapType: MapType.none,
          //mapType: MapType.satellite,
          //mapType: MapType.terrain,
          //mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.562436, -46.655005),
            zoom: 16,
          ),
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
  
}
