import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPolylines extends StatefulWidget {
  @override
  _MapPolylinesState createState() => _MapPolylinesState();
}

class _MapPolylinesState extends State<MapPolylines> {
 Completer<GoogleMapController> _mapController = Completer();
 Set<Marker> _markes = {};
 Set<Polygon> _polygons = {};
 Set<Polyline> _polylines = {};
 
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
  Set<Polyline> listPolyline = {};
  Polyline polyline = Polyline(
   polylineId: PolylineId('polyline_1'),
   color: Colors.red,
   width: 30,
   startCap: Cap.roundCap,
   endCap: Cap.roundCap,
   jointType: JointType.round,
   points: [
    LatLng(-23.489838, -46.894934),
    LatLng(-23.489472, -46.894698),
    
    LatLng(-23.488884, -46.895000),
    LatLng(-23.487676, -46.894256),
 
    LatLng(-23.486733, -46.895054),
    LatLng(-23.486133, -46.894589),
 
    LatLng(-23.486030, -46.893367),
    LatLng(-23.486540, -46.892393),
   ],
   consumeTapEvents: true,
   onTap: (){
    print('Clicado aqui!');
   },
  );
  listPolyline.add(polyline);
  setState(() {
    _polylines = listPolyline;
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
    title: Text('Polygons'),
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
      target: LatLng(-23.489838, -46.894934),
      zoom: 19,
     ),
     onMapCreated: _onMapCreated,
     markers: _markes,
     polygons: _polygons,
     polylines: _polylines,
    ),
   ),
  );
 }
}
