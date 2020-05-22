import 'package:flutter/material.dart';
import 'package:geolocalizacaoapp/exemplos/02_map_sample.dart';
//import 'package:geolocalizacaoapp/exemplos/01_config_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapas e Geolocalização',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MapSample(),
    );
  }
}