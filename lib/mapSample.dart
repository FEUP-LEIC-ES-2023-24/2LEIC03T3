import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'consts.dart';
import 'firebase_parse.dart';
import 'screens/WaterReport.dart';
import 'screens/Bookmarks.dart';

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

  //final Map<PolylineId, Polyline> _polylines = {};
  LatLng? _currentP;

  @override
  void initState() {
    super.initState();
    /*
    getLocationUpdates().then(
      (value) => getPolyline()
          .then((coordinates) => generatePolylineFromPoints(coordinates)),
    );
    */
    getLocationUpdates();
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
    return FutureBuilder<List<WaterResource>>(
      future: getAllWaterResources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<WaterResource> resources = snapshot.data!;
          return Scaffold(
            appBar: AppBar(

              leading: IconButton(
                padding: const EdgeInsets.only(left: 30),
                icon: const Icon(Icons.star, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookmarkScreen(),
                    ),
                  );
                },
              ),
              title: const Text(
                'DigiWater',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              centerTitle: true,
              backgroundColor: const Color(0xFF5bb5da),
            ),
            body: GoogleMap(
              onMapCreated: (controller) => _mapController.complete(controller),
              initialCameraPosition: CameraPosition(
                target: calculateCentroid(resources.map((resource) {
                  List<String> coordinates = resource.coordinates.split(', ');
                  return LatLng(double.parse(coordinates[0]), double.parse(coordinates[1]));
                }).toList()),
                zoom: 11,
              ),
              markers: Set<Marker>.of(_generateMarkers(resources)),
              myLocationEnabled: true,
            ),
          );
        }
      },
    );
  }

  Iterable<Marker> _generateMarkers(List<WaterResource> resources) sync* {
    for (int i = 0; i < resources.length; i++) {
      WaterResource resource = resources[i];
      List<String> coordinates = resource.coordinates.split(', ');
      LatLng position = LatLng(double.parse(coordinates[0]), double.parse(coordinates[1]));
      yield Marker(
        markerId: MarkerId("Marker_$i"),
        position: position,
        icon: getMarkerIcon(resource),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WaterReportScreen(resource: resource)),
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

  Future<void> getLocationUpdates() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await _locationController.serviceEnabled();

  if (!serviceEnabled) {
    serviceEnabled = await _locationController.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await _locationController.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await _locationController.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  // If we reach here, it means the location service is enabled and permission is granted
  // Call setState to trigger a rebuild of your widget
  setState(() {});
}
  /*
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
  */
}
