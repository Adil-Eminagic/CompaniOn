import 'dart:async';
import 'package:companion_mobile/models/location.dart';
import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/providers/location_provider.dart';
import 'package:companion_mobile/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LocationTrackerScreen extends StatefulWidget {
  const LocationTrackerScreen({Key? key, this.familyMember, this.locationId})
      : super(key: key);
  final Users? familyMember;
  final int? locationId;

  @override
  _LocationTrackerScreen createState() => _LocationTrackerScreen();
}

class _LocationTrackerScreen extends State<LocationTrackerScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final LatLng _specificLocation = LatLng(43.359054, 17.815117);
  LocationProvider _locationProvider = LocationProvider();
  bool isLoading = true;

  bool existLocation = false;
  double lat = 0;
  double lng = 0;
  String locationTime = '';

  late CameraPosition _kGooglePlex;
  Set<Marker> _markers = {}; // Set of markers

  @override
  void initState() {
    super.initState();
    _locationProvider = context.read<LocationProvider>();
    getmeberLastLocation();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _initForm() async {
    _kGooglePlex = CameraPosition(
      target:
          LatLng(lat, lng), // Initialize with fetched latitude and longitude
      zoom: 14.4746,
    );

    _markers.add(Marker(
      markerId: const MarkerId('Member location'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(title: 'Member location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed), // Set red icon
    ));
  }

  void getmeberLastLocation() async {
    try {
      Location? location;
      if (widget.familyMember != null) {
        location = await _locationProvider
            .getLastByUserId(widget.familyMember?.id ?? 0);
      } else {
        location = await _locationProvider.getById(widget.locationId ?? 0);
      }

      lat = location?.latitude ?? 0.0;
      lng = location?.longitude ?? 0.0;

      if (location != null) {
        if (mounted) {
          setState(() {
            existLocation = true;
            locationTime = location!.createdAt != null
                ? DateFormat('dd.MM.yyyy HH:mm').format(location.createdAt!)
                : '';
          });
        }

        await _initForm(); // Initialize after fetching the location
      }
    } catch (e) {
      alertBox(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Location ${locationTime != '' ? 'on $locationTime' : ''}'),
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
        body: isLoading
            ? const SpinKitCircle(color: Colors.green)
            : (existLocation
                ? GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: _markers, // Set the markers on the map
                  )
                : const Center(
                    child: Text("This user has no location"),
                  )));
  }
}
