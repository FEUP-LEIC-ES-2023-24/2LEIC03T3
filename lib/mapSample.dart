import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'consts.dart';
import 'screens/WaterReport.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  List<LatLng> coordinatesGeres = getList();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final Map<PolylineId, Polyline> _polylines = {};
  LatLng? _currentP;

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (value) => getPolyline()
          .then((coordinates) => generatePolylineFromPoints(coordinates)),
    );
  }

  LatLng calculateCentroid(List<LatLng> points) {
  double latitude = 0;
  double longitude = 0;

  for (var point in points) {
    latitude += point.latitude;
    longitude += point.longitude;
  }

  return LatLng(latitude / points.length, longitude / points.length);
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Map',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF5bb5da),
      ),
      body:  GoogleMap(
            onMapCreated: (controller) => _mapController.complete(controller),
            initialCameraPosition: CameraPosition(
              target: calculateCentroid(coordinatesGeres),  // Substitua com a latitude e longitude desejadas
              zoom: 11,
            ),
            markers: Set<Marker>.of(_generateMarkers()),
            polylines: Set<Polyline>.of(_polylines.values),
          ),
    );
  }

  Iterable<Marker> _generateMarkers() sync* {
    for (int i = 0; i < coordinatesGeres.length; i++) {
      yield Marker(
        markerId: MarkerId("Marker_$i"),
        position: coordinatesGeres[i],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DefaultWaterReportScreen()),
          );
        },
      );
    }
  }

  Future<void> cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition cameraPosition = CameraPosition(
      target: position,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  bool _cameraPositionSet = false;
  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await _locationController.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.longitude != null && currentLocation.latitude != null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          if (!_cameraPositionSet) {
            cameraToPosition(_currentP!);
            _cameraPositionSet = true;
          }
        });
      }
    });
  }

  Future<List<LatLng>> getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(coordinatesGeres[1].latitude, coordinatesGeres[1].longitude),
      PointLatLng(coordinatesGeres[2].latitude, coordinatesGeres[2].longitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 3,
    );
    setState(() {
      _polylines[id] = polyline;
    });
  }
}
