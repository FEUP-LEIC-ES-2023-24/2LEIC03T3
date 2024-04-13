import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
    const LatLng _pApplePark = LatLng(37.3346, -122.0090);
    const LatLng _geresFirst = LatLng(41.696372, -8.173056);
    const LatLng _geresSecond = LatLng(41.774896, -8.181896);
    const LatLng _geresThird = LatLng(41.721266, -8.129861);
    const LatLng _geresForth = LatLng(41.724124, -8.195978);

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
        markers: {
          const Marker(
              markerId: MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pGooglePlex),
          const Marker(
              markerId: MarkerId("_sourcelocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pApplePark),
        },
      ),
    );
  }
}
