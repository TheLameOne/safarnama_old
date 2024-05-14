import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  static const String routeNamed = "GoogleMapsScreen";
  LatLng? location;

  GoogleMapsScreen({this.location});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-33.86, 151.20);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  // String googleApikey = "AIzaSyAjjI20vfKGmHfmFU4zQgOziLPBomXWN_g";
  // GoogleMapController? mapController; //contrller for Google map
  // CameraPosition? cameraPosition;
  // LatLng startLocation = LatLng(17.471236, 78.721465);
  // String location = "Search Location";
  // bool validator = false;
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.amber,
        // height: size.height * 0.9,
        // width: size.width * 0.9,
        // child: Text("harsh")
        child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            )
            // // mapType: MapType.hybrid,
            // initialCameraPosition: CameraPosition(
            //   target: startLocation,
            //   zoom: 14.0,
            // ),
            // onMapCreated: (controller) {
            //   //method called when map is created
            //   setState(() {
            //     mapController = controller;
            //   });
            // },
            ),
      ),
    );
  }
}
