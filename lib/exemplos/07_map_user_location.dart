import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapUserLocation extends StatefulWidget {
  @override
  _MapUserLocationState createState() => _MapUserLocationState();
}

class _MapUserLocationState extends State<MapUserLocation> {
  Completer<GoogleMapController> _mapController = Completer();
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-23.489838, -46.894934),
    zoom: 19,
  );

  Set<Marker> _markes = {};
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};

  _onMapCreated(GoogleMapController mapController) {
    _mapController.complete(mapController);
  }

  _moveCamera() async {
    GoogleMapController googleMapController = await _mapController.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  _recoveryUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18,
      );

      _moveCamera();
    });
  }

  _addListernerUserLocation() {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    geolocator.getPositionStream(locationOptions).listen((Position position) {
      Set<Marker> localMarkers = {};
      Marker locationUser = Marker(
          markerId: MarkerId('mark-user'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: "Shopping Cidade de São Paulo"),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          onTap: () {
            print('Hello');
          });

      localMarkers.add(locationUser);

      setState(() {
        _markes = localMarkers;
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18,
        );
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recoveryUserLocation();
    _addListernerUserLocation();
    _moveCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        markers: _markes,
      ),
    );
  }
}
