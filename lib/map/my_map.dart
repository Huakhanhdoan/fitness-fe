import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(

        initialZoom: 17,
        initialCenter: LatLng(21.028, 105.8048),
      ),
      children: [ // Widget con của FlutterMap
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName:
          'net.tlserver6y.flutter_map_location_marker.example',
          maxZoom: 19,
        ),
        CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.always ,
        ),
      ],
    );
  }
}
