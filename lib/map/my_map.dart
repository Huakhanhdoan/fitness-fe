import 'package:flutter/cupertino.dart';
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
  bool show_direction = false;
  final OpenRouteService _openRouteService = OpenRouteService(
      apiKey: '5b3ce3597851110001cf62485eeed0fe8af24203b9469afcc93c3b34');

  final TextEditingController _controller = TextEditingController();
  String _coordinates = "";
  LatLng _search = const LatLng(21.0278, 105.8311);
  LatLng startPoint = const LatLng(21.0278, 105.8311);
  LatLng endPoint = const LatLng(21.0278, 155.8311);
  List<LatLng> points = [];
  String _textSearch = "";

  Future<void> _getCurrentLocation() async {
    // lấy vị trí hiện tại của người dùng
    final location = loc.Location();
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      final requestedPermission = await location.requestPermission();
      if (requestedPermission != PermissionStatus.granted) {
        throw Exception('Location permission not granted');
      }
    }

    final currentLocation = await location.getLocation();
    setState(() {
      startPoint =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  void findDirections() async {
    // tìm đường đi từ startpoint đế endpoint
    points = [];
    _getCurrentLocation();
    final directions = await _openRouteService.directionsRouteCoordsGet(
        startCoordinate: ORSCoordinate(
            latitude: startPoint.latitude, longitude: startPoint.longitude),
        endCoordinate: ORSCoordinate(
            latitude: endPoint.latitude, longitude: endPoint.longitude),
        profileOverride: ORSProfile.footWalking);
    for (int i = 0; i < directions.length; i++) {
      points.add(LatLng(directions[i].latitude, directions[i].longitude));
    }
    setState(() {
      points;
    });
  }

  Future<void> _searchLocation(String value) async {
    setState(() {
      _textSearch = value;
    });
    // chuyển đổi giá trị tìm kiếm từ string  -> tọa dộ
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
        setState(() {
          show_direction = true;
        });
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
                      "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                SearchBar(
                    controller: _controller,
                    onChanged: (value) {
                      // _location = value;
                    },
                    leading:
                        Icon(Icons.search, color: Colors.blueAccent.shade200),
                    onSubmitted: (value) {
                      _searchLocation(value);
                    }),
                if (_coordinates != "")
                  Center(
                      child: Text(
                    _coordinates,
                  ))
              ],
            ),
          ),
          if (show_direction)
            Positioned(
                bottom: 120,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 16,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      border: Border.all(
                        color: Colors.grey, // Màu sắc của viền
                        width: 1, // Độ dày của viền
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Màu của bóng
                          spreadRadius: 1, // Độ lan rộng của bóng
                          blurRadius: 7, // Độ mờ của bóng
                          offset: const Offset(-3, 3), // Độ lệch của bóng
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               Text(
                                'Vị trí hiện tại',
                                style: TextStyle(color: Colors.blue.shade200,
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Icon(Icons.send_sharp, color: Colors.white,),
                              Text(
                                _textSearch,
                                style: const TextStyle( color: Colors.orange,
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Khoảng cách",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  Text(
                                    "${((points.length) / 15).toString().substring(0,3)}" " KM",
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 0.5, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Thời Gian",
                                    style:
                                        TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${points.length}" " Phút",
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 0.5, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),

                                elevation: MaterialStateProperty.all(4.0),
    ),
                                child: const Text(
                                  "Tìm đường",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                onPressed: () {
                                  findDirections();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
