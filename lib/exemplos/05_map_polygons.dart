import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPolygons extends StatefulWidget {
  @override
  _MapPolygonsState createState() => _MapPolygonsState();
}

class _MapPolygonsState extends State<MapPolygons> {
  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markes = {};
  Set<Polygon> _polygons = {};

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
    
    Set<Polygon> listPolygons = {};
    Polygon polygon1 = Polygon(
      polygonId: PolygonId('polygon-1'),
      fillColor: Colors.green,
      strokeColor: Colors.red,
      strokeWidth: 10,
      points: [
        LatLng(-23.485827, -46.892651),
        LatLng(-23.486231, -46.893238),
        LatLng(-23.486525, -46.892416),
        LatLng(-23.486547, -46.891703),
      ],
      zIndex: 1,
      consumeTapEvents: true,
      onTap: (){
        print("Fução para chamar no OnTap");
      },
    );

    Polygon polygon2 = Polygon(
      polygonId: PolygonId('polygon-2'),
      fillColor: Colors.purple,
      strokeColor: Colors.orangeAccent,
      strokeWidth: 10,
      points: [
        LatLng(-23.486168, -46.894552),
        LatLng(-23.486320, -46.890827),
        LatLng(-23.486525, -46.892416),
      ],
      zIndex: 0,
      consumeTapEvents: true,
      onTap: (){
        print("Fução para chamar no OnTap");
      },
    );
    
    listPolygons.add(polygon1);
    listPolygons.add(polygon2);
    
    setState(() {
      _polygons = listPolygons;
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
            target: LatLng(-23.486525, -46.892416),
            zoom: 16,
          ),
          onMapCreated: _onMapCreated,
          markers: _markes,
          polygons: _polygons,
        ),
      ),
    );
  }
}
