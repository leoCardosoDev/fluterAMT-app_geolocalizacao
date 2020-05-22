import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapGeocoding extends StatefulWidget {
  @override
  _MapGeocodingState createState() => _MapGeocodingState();
}

class _MapGeocodingState extends State<MapGeocoding> {
  Completer<GoogleMapController> _mapController = Completer();
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-23.489838, -46.894934),
    zoom: 19,
  );

  Set<Marker> _markes = {};

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
  
  

  _recoveryAddress() async {
    List<Placemark> listAddress = await Geolocator().placemarkFromAddress("Rua Bélgica, 129 "
      "Engenho Novo");

    if (listAddress != null && listAddress.length > 0) {
      Placemark address = listAddress[0];
      String result;
      result = "\n Area:  " + address.administrativeArea;
      result += "\n Sub area: " + address.subAdministrativeArea;
      result += "\n Local: " + address.locality;
      result += "\n Sub Local: " + address.subLocality;
      result += "\n Via: " + address.thoroughfare;
      result += "\n Sub Via: " + address.subThoroughfare;
      result += "\n CEP: " + address.postalCode;
      result += "\n País: " + address.country;
      result += "\n Cod. País: " + address.isoCountryCode;
      result += "\n Lat Long: " + address.position.toString();

      print(result);
    }
    
  }

  //Lat: -23.4864984, Long: -46.892402999999995

  _recoveryAddressLatLon() async {
   List<Placemark> listAddress = await Geolocator().placemarkFromCoordinates(-23.4864984, -46.892402999999995);
 
   if (listAddress != null && listAddress.length > 0) {
    Placemark address = listAddress[0];
    String result;
    result = "\n Area:  " + address.administrativeArea;
    result += "\n Sub area: " + address.subAdministrativeArea;
    result += "\n Local: " + address.locality;
    result += "\n Sub Local: " + address.subLocality;
    result += "\n Via: " + address.thoroughfare;
    result += "\n Sub Via: " + address.subThoroughfare;
    result += "\n CEP: " + address.postalCode;
    result += "\n País: " + address.country;
    result += "\n Cod. País: " + address.isoCountryCode;
    result += "\n Lat Long: " + address.position.toString();
  
    print(result);
   }
 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_recoveryAddress();
   _recoveryAddressLatLon();
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
