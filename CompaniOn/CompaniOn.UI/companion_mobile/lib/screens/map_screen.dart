import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, this.latitude, this.longitude}) : super(key: key);
  final double? latitude;
  final double? longitude;

  @override
  _MapScreen createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  double lat = 0;
  double lng = 0;

  late CameraPosition _kGooglePlex;
  Set<Marker> _markers = {}; // Add a set of markers

  @override
  void initState() {
    super.initState();
    lat = widget.latitude ?? 0.0;
    lng = widget.longitude ?? 0.0;

    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 14.4746,
    );

    // Add a marker at the provided latitude and longitude
    _markers.add(
      Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: 'User Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Red marker
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location of user'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,  // Set the markers on the map
      ),
    );
  }
}
