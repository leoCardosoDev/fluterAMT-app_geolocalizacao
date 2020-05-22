import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarcadores extends StatefulWidget {
  @override
  _MapMarcadoresState createState() => _MapMarcadoresState();
}

class _MapMarcadoresState extends State<MapMarcadores> {
  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markes = {};

  _onMapCreated(GoogleMapController mapController) {
    _mapController.complete(mapController);
  }

  _moveCamera() async {
    GoogleMapController googleMapController = await _mapController.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(-23.563370, -46.652923),
      zoom: 16,
      tilt: 0,
      bearing: 0,
    )));
  }

  _loadMarkes() {
    Set<Marker> localMarkers = {};

    Marker markShop = Marker(
        markerId: MarkerId('mark-shop'),
        position: LatLng(-23.563370, -46.652923),
        infoWindow: InfoWindow(title: "Shopping Cidade de São Paulo"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
        onTap: () {
          print('Hello');
        });

    Marker markHospital = Marker(
        markerId: MarkerId('mark-shop'),
        position: LatLng(-23.562868, -46.655874),
        infoWindow: InfoWindow(title: "12º Cartório de São Paulo"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
        onTap: () {
          print('World');
        });

    localMarkers.add(markShop);
    localMarkers.add(markHospital);

    setState(() {
      _markes = localMarkers;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMarkes();
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
            target: LatLng(-23.563370, -46.652923),
            zoom: 16,
          ),
          onMapCreated: _onMapCreated,
          markers: _markes,
        ),
      ),
    );
  }
}
