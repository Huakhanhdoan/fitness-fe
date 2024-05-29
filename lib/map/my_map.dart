import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:location/location.dart' as loc;
import 'package:open_route_service/open_route_service.dart';
import 'package:latlong2/latlong.dart';
 import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';


class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late final MapController _mapController;

  final OpenRouteService _openRouteService =
      OpenRouteService(apiKey: '5b3ce3597851110001cf62485eeed0fe8af24203b9469afcc93c3b34');

  final TextEditingController _controller = TextEditingController();
  String _coordinates = "";
  LatLng _search = const LatLng(21.0278, 105.8311);
  LatLng startPoint = LatLng(21.0278, 105.8311);
  LatLng endPoint = LatLng(21.0278, 155.8311);
  List<LatLng> points = [


  ];
  Future<void> _getCurrentLocation() async {
    final location = loc.Location() ;
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      final requestedPermission = await location.requestPermission();
      if (requestedPermission != PermissionStatus.granted) {
        throw Exception('Location permission not granted');
      }
    }

    final currentLocation = await location.getLocation();
    setState(() {
      startPoint = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });


 
  }
  void findDirections() async {
    points = [];

_getCurrentLocation();
    final directions = await _openRouteService.directionsRouteCoordsGet(
     startCoordinate: ORSCoordinate(latitude: startPoint.latitude, longitude: startPoint.longitude),
      endCoordinate: ORSCoordinate(latitude: endPoint.latitude, longitude: endPoint.longitude),
      profileOverride:ORSProfile.footWalking
    );
    for(int i = 0; i< directions.length; i++) {

  points.add(LatLng(directions[i].latitude, directions[i].longitude));

    }
    setState(() {
      points;
    });
    }

  Future<void> _searchLocation(String value) async {
    try {
      List<Location> locations = await locationFromAddress(value);
      if (locations.isNotEmpty) {
        setState(() {
          _coordinates = "";
          _search = LatLng(locations.first.latitude, locations.first.longitude);
          endPoint = _search;
          Future.delayed(Duration.zero, () {
            _mapController.move(_search, 15);
          });

        });
        findDirections();
      } else {
        setState(() {
          _coordinates = "No coordinates found";
        });
      }
    } catch (e) {
      setState(() {
        _coordinates = "Error occurred: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        _mapController.move(const LatLng(21.0278, 105.8311), 15);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm đường'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: LatLng(21.0278, 105.8311),
                initialZoom: 13,
              ),
              children: [

                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                CurrentLocationLayer(
                  alignPositionOnUpdate: AlignOnUpdate.once,
                  // zoomAnimation: true,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80,
                      height: 80,
                      point: _search,
                      child: const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),

                  ],
                ),
      PolylineLayer(
        polylines: [
          Polyline(
            points: points,
            strokeWidth: 5.0,
            color: Colors.blue,
          ),
        ],
      )
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20, // Ensure the TextField takes up available width
            child: Column(
              children: [
                TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter location',
                    ),
                    onChanged: (value) {
                      // _location = value;
                    },
                    onSubmitted: (value) {
                      _searchLocation(value);
                    }),
               if(_coordinates != "")
                 Center(child: Text(_coordinates,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
