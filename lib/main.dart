import 'package:flutter/material.dart';
import 'package:geolocalizacaoapp/exemplos/06_map_polylines.dart';
//import 'package:geolocalizacaoapp/exemplos/05_map_polygons.dart';
//import 'package:geolocalizacaoapp/exemplos/04_map_marcadores.dart';
//import 'package:geolocalizacaoapp/exemplos/03_map_camera.dart';
//import 'package:geolocalizacaoapp/exemplos/02_map_sample.dart';
//import 'package:geolocalizacaoapp/exemplos/01_config_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapas e Geolocalização',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MapPolylines(),
    );
  }
}